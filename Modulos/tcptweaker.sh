#!/bin/bash
clear
tput setaf 7 ; tput setab 4 ; tput bold ; printf '%35s%s%-20s\n' "TCP Tweaker 1.0" ; tput sgr0

BACKUP_FILE="/etc/sysctl.conf.bak"

# Função para fazer backup do arquivo de configuração
backup_config() {
    if [ ! -f "$BACKUP_FILE" ]; then
        cp /etc/sysctl.conf "$BACKUP_FILE"
        echo "Backup do arquivo de configuração criado em $BACKUP_FILE"
    fi
}

# Função para restaurar configuração a partir do backup
restore_config() {
    if [ -f "$BACKUP_FILE" ]; then
        cp "$BACKUP_FILE" /etc/sysctl.conf
        sysctl -p /etc/sysctl.conf > /dev/null
        echo "Configuração restaurada a partir do backup."
    else
        echo "Backup não encontrado. Não foi possível restaurar a configuração."
    fi
}

# Verificar se as configurações já estão presentes
if grep -q "^#PH56" /etc/sysctl.conf; then
    echo ""
    echo "As configurações de rede TCP Tweaker já foram adicionadas no sistema!"
    echo ""
    read -p "Deseja remover as configurações do TCP Tweaker? [s/n]: " -e -i n resposta0
    if [[ "$resposta0" == 's' ]]; then
        backup_config
        sed -i '/^#PH56/d; /^net.ipv4.tcp_window_scaling = 1/d; /^net.core.rmem_max = 16777216/d; /^net.core.wmem_max = 16777216/d; /^net.ipv4.tcp_rmem = 4096 87380 16777216/d; /^net.ipv4.tcp_wmem = 4096 16384 16777216/d; /^net.ipv4.tcp_low_latency = 1/d; /^net.ipv4.tcp_slow_start_after_idle = 0/d' /etc/sysctl.conf
        sysctl -p /etc/sysctl.conf > /dev/null
        echo ""
        echo "As configurações de rede do TCP Tweaker foram removidas com sucesso."
        echo ""
        exit
    else
        echo ""
        exit
    fi
else
    echo ""
    echo "AVISO: Este é um script experimental. Utilize-o por sua própria conta e risco."
    echo "Este script altera configurações de rede do sistema com o objetivo de reduzir a latência"
    echo "e melhorar a velocidade da conexão TCP. Alterações incorretas podem afetar a estabilidade"
    echo "e o desempenho da sua rede. Certifique-se de entender as mudanças que serão aplicadas."
    echo ""
    read -p "Continuar com a instalação? [s/n]: " -e -i n resposta
    if [[ "$resposta" == 's' ]]; then
        backup_config
        echo ""
        echo "Modificando as seguintes configurações:"
        echo "" >> /etc/sysctl.conf
        echo "#PH56" >> /etc/sysctl.conf
        echo "net.ipv4.tcp_window_scaling = 1
net.core.rmem_max = 16777216
net.core.wmem_max = 16777216
net.ipv4.tcp_rmem = 4096 87380 16777216
net.ipv4.tcp_wmem = 4096 16384 16777216
net.ipv4.tcp_low_latency = 1
net.ipv4.tcp_slow_start_after_idle = 0" >> /etc/sysctl.conf
        echo ""
        sysctl -p /etc/sysctl.conf
        echo ""
        echo "As configurações de rede do TCP Tweaker foram adicionadas com sucesso."
        echo ""
    else
        echo ""
        echo "A instalação foi cancelada pelo usuário!"
        echo ""
    fi
fi
exit
