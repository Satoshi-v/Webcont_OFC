#!/usr/bin/env python3
# encoding: utf-8
import socket
import threading
import select
import sys
import time
from os import system

# Limpeza do terminal
system("clear")

# Configurações de conexão padrão
IP = '0.0.0.0'
try:
    PORT = int(sys.argv[1])
except (IndexError, ValueError):
    PORT = 80

PASS = ''
BUFLEN = 8196 * 8
TIMEOUT = 60
MSG = ''
COR = '<font color="null">'
FTAG = '</font>'
DEFAULT_HOST = '0.0.0.0:22'
RESPONSE = f"HTTP/1.1 200 {COR}{MSG}{FTAG}\r\n\r\n"

class Server(threading.Thread):
    def __init__(self, host, port):
        super().__init__()
        self.running = False
        self.host = host
        self.port = port
        self.threads = []
        self.threadsLock = threading.Lock()

    def run(self):
        self.soc = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        self.soc.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
        self.soc.settimeout(2)
        self.soc.bind((self.host, self.port))
        self.soc.listen(0)
        self.running = True

        try:
            while self.running:
                try:
                    client, addr = self.soc.accept()
                    client.setblocking(1)
                except socket.timeout:
                    continue

                conn = ConnectionHandler(client, self, addr)
                conn.start()
                self.addConn(conn)
        finally:
            self.running = False
            self.soc.close()

    def addConn(self, conn):
        with self.threadsLock:
            if self.running:
                self.threads.append(conn)

    def removeConn(self, conn):
        with self.threadsLock:
            self.threads.remove(conn)

    def close(self):
        self.running = False
        with self.threadsLock:
            threads = list(self.threads)
            for conn in threads:
                conn.close()

class ConnectionHandler(threading.Thread):
    def __init__(self, client, server, addr):
        super().__init__()
        self.clientClosed = False
        self.targetClosed = True
        self.client = client
        self.client_buffer = ''
        self.server = server

    def close(self):
        try:
            if not self.clientClosed:
                self.client.shutdown(socket.SHUT_RDWR)
                self.client.close()
        except:
            pass
        finally:
            self.clientClosed = True
            
        try:
            if not self.targetClosed:
                self.target.shutdown(socket.SHUT_RDWR)
                self.target.close()
        except:
            pass
        finally:
            self.targetClosed = True

    def run(self):
        try:
            self.client_buffer = self.client.recv(BUFLEN)

            hostPort = self.findHeader(self.client_buffer, 'X-Real-Host') or DEFAULT_HOST
            split = self.findHeader(self.client_buffer, 'X-Split')

            if split:
                self.client.recv(BUFLEN)

            if hostPort:
                passwd = self.findHeader(self.client_buffer, 'X-Pass')
                if PASS and passwd != PASS:
                    self.client.send(b'HTTP/1.1 400 WrongPass!\r\n\r\n')
                elif hostPort.startswith(IP):
                    self.method_CONNECT(hostPort)
                else:
                    self.client.send(b'HTTP/1.1 403 Forbidden!\r\n\r\n')
            else:
                print('- No X-Real-Host!')
                self.client.send(b'HTTP/1.1 400 NoXRealHost!\r\n\r\n')
        except Exception:
            pass
        finally:
            self.close()
            self.server.removeConn(self)

    def findHeader(self, head, header):
        aux = head.find(f'{header}: ')
        if aux == -1:
            return ''
        aux = head.find(':', aux)
        head = head[aux + 2:]
        aux = head.find('\r\n')
        return head[:aux] if aux != -1 else ''

    def connect_target(self, host):
        i = host.find(':')
        port = int(host[i+1:]) if i != -1 else (443 if self.method == 'CONNECT' else 22)
        host = host[:i] if i != -1 else host

        (soc_family, soc_type, proto, _, address) = socket.getaddrinfo(host, port)[0]
        self.target = socket.socket(soc_family, soc_type, proto)
        self.targetClosed = False
        self.target.connect(address)

    def method_CONNECT(self, path):
        self.connect_target(path)
        self.client.sendall(RESPONSE.encode())
        self.client_buffer = ''
        self.doCONNECT()

    def doCONNECT(self):
        socs = [self.client, self.target]
        count = 0
        error = False
        while not error:
            count += 1
            recv, _, err = select.select(socs, [], socs, 3)
            if err:
                break
            for in_ in recv:
                try:
                    data = in_.recv(BUFLEN)
                    if data:
                        (self.client if in_ is self.target else self.target).send(data)
                        count = 0
                    else:
                        error = True
                        break
                except:
                    error = True
                    break
            if count == TIMEOUT:
                break

def main():
    print("\033[0;34m━"*8, "\033[1;32m PROXY SOCKS", "\033[0;34m━"*8, "\n")
    print("\033[1;33mIP:\033[1;32m", IP)
    print("\033[1;33mPORTA:\033[1;32m", PORT, "\n")
    print("\033[0;34m━"*10, "\033[1;32m SSHPLUS", "\033[0;34m━\033[1;37m"*11, "\n")
    server = Server(IP, PORT)
    server.start()
    try:
        while True:
            time.sleep(2)
    except KeyboardInterrupt:
        print('\nParando...')
        server.close()

if __name__ == '__main__':
    main()
