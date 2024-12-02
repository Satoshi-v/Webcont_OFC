#!/bin/bash
MEUIP=$(wget -qO- ipinfo.io/ip);
echo "Verificando VPS"

clear 
if [ ! -e /usr/local/bin/reboot_otomatis ]; then
echo '#!/bin/bash' > /usr/local/bin/reboot_otomatis 
echo 'data=$(date +"%d-%m-%Y")' >> /usr/local/bin/reboot_otomatis 
echo 'hora=$(date +"%T")' >> /usr/local/bin/reboot_otomatis 
echo 'echo "Servidor reiniciado com sucesso em $data às $hora." >> /root/log-reboot.txt' >> /usr/local/bin/reboot_otomatis 
echo '/sbin/shutdown -r now' >> /usr/local/bin/reboot_otomatis 
chmod +x /usr/local/bin/reboot_otomatis
fi
clear
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\E[40;1;37m       • **MENU AUTO-REBOOT** •        \e[0m"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""
echo -e "[\e[36m•1\e[0m] **CONFIGURAR AUTO-REBOOT A CADA 1 HORA**"
echo -e "[\e[36m•2\e[0m] **CONFIGURAR AUTO-REBOOT A CADA 6 HORAS**"
echo -e "[\e[36m•3\e[0m] **CONFIGURAR AUTO-REBOOT A CADA 12 HORAS**"
echo -e "[\e[36m•4\e[0m] **CONFIGURAR AUTO-REBOOT A CADA 1 DIA**"
echo -e "[\e[36m•5\e[0m] **CONFIGURAR AUTO-REBOOT A CADA 1 SEMANA**"
echo -e "[\e[36m•6\e[0m] **CONFIGURAR AUTO-REBOOT A CADA 1 MÊS**"
echo -e "[\e[36m•7\e[0m] **DESATIVAR AUTO-REBOOT**"
echo -e "[\e[36m•8\e[0m] **VER LOG DE REBOOTS**"
echo -e "[\e[36m•9\e[0m] **REMOVER LOG DE REBOOTS**"
echo -e ""
echo -e "[\e[31m•0\e[0m] **VOLTAR AO MENU**"
echo -e ""
echo -e "**PRESSIONE X OU [ CTRL+C ] PARA SAIR**"
echo -e ""
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""
read -p " **SELECIONE O MENU: **" x
if test $x -eq 1; then
echo "10 * * * * root /usr/local/bin/reboot_otomatis" > /etc/cron.d/reboot_otomatis
echo "**AUTO-REBOOT CONFIGURADO PARA CADA 1 HORA.**"
elif test $x -eq 2; then
echo "10 */6 * * * root /usr/local/bin/reboot_otomatis" > /etc/cron.d/reboot_otomatis
echo "**AUTO-REBOOT CONFIGURADO PARA CADA 6 HORAS.**"
elif test $x -eq 3; then
echo "10 */12 * * * root /usr/local/bin/reboot_otomatis" > /etc/cron.d/reboot_otomatis
echo "**AUTO-REBOOT CONFIGURADO PARA CADA 12 HORAS.**"
elif test $x -eq 4; then
echo "10 0 * * * root /usr/local/bin/reboot_otomatis" > /etc/cron.d/reboot_otomatis
echo "**AUTO-REBOOT CONFIGURADO PARA UMA VEZ AO DIA.**"
elif test $x -eq 5; then
echo "10 0 */7 * * root /usr/local/bin/reboot_otomatis" > /etc/cron.d/reboot_otomatis
echo "**AUTO-REBOOT CONFIGURADO PARA UMA VEZ POR SEMANA.**"
elif test $x -eq 6; then
echo "10 0 1 * * root /usr/local/bin/reboot_otomatis" > /etc/cron.d/reboot_otomatis
echo "**AUTO-REBOOT CONFIGURADO PARA UMA VEZ POR MÊS.**"
elif test $x -eq 7; then
rm -f /etc/cron.d/reboot_otomatis
echo "**AUTO-REBOOT DESATIVADO COM SUCESSO.**"
elif test $x -eq 8; then
if [ ! -e /root/log-reboot.txt ]; then
	clear
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e "\E[40;1;37m        • **LOG AUTO-REBOOT** •        \e[0m"
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e ""
    echo "**NENHUMA ATIVIDADE DE REBOOT ENCONTRADA**"
    echo -e ""
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo ""
    read -n 1 -s -r -p "**PRESSIONE QUALQUER TECLA PARA VOLTAR AO MENU**"
    auto-reboot
	else
	clear
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e "\E[40;1;37m        • **LOG AUTO-REBOOT** •        \e[0m"
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e ""    
	echo '**LOG DE REBOOTS**'
	cat /root/log-reboot.txt
    echo -e ""
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo ""
    read -n 1 -s -r -p "**PRESSIONE QUALQUER TECLA PARA VOLTAR AO MENU**"
    auto-reboot    
fi
elif test $x -eq 9; then
clear
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\E[40;1;37m        • **LOG AUTO-REBOOT** •        \e[0m"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""  
echo "" > /root/log-reboot.txt
echo "**LOG DE REBOOTS APAGADO COM SUCESSO!**"
echo -e ""
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo ""
read -n 1 -s -r -p "**PRESSIONE QUALQUER TECLA PARA VOLTAR AO MENU**"
auto-reboot 
elif test $x -eq 0; then
clear
menu-set
else
clear
echo ""
echo "**OPÇÃO NÃO ENCONTRADA NO MENU**"
echo ""
read -n 1 -s -r -p "**PRESSIONE QUALQUER TECLA PARA VOLTAR AO MENU**"
auto-reboot 
fi
