#!/bin/bash
clear
#--------@Net_Satoshi-----------#
source ShellBot.sh
touch lista
[[ -z $1 ]] && {
    clear && echo "INFORME O TOKEN" && return 0
}
[[ ! -e RESET ]] && touch RESET
api_bot=$1
ShellBot.init --token "$api_bot" --monitor --flush
ShellBot.username

# - Funcao menu
menu() {
    local msg
        msg="=×=×=×=×=×=×=×=×=×=×=×=×=×=×=×=\n"
        msg+="HOLA <b>${message_from_first_name[$id]}</b>, BIENVENIDOª 🙂\n"
        msg+="=×=×=×=×=×=×=×=×=×=×=×=×=×=×=×=\n"
        msg+="GENERE SU TEST GRATIS AHORA MISMO!\n\n"
        msg+="=×=×=×=×=×=×=×=×=×=×=×=×=×=×=×=\n"
        msg+="<b>👇🏽 DISPONIBLE 👇🏽</b>\n"
        msg+="=×=×=×=×=×=×=×=×=×=×=×=×=×=×=×=\n"
        msg+="<b>🥶 CONGELA MEGAS</b>\n"
        msg+="<b>😎 CONEXION SIN SALDO</b>\n"
        msg+="=×=×=×=×=×=×=×=×=×=×=×=×=×=×=×=\n"
        msg+="<b>🔴 CLARO NIC 🔴</b>\n"
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
        --text "$(echo -e $msg)" \
        --reply_markup "$keyboard1" \
        --parse_mode html
        return 0
}

# - funcao criar ssh
criarteste() {
    [[ $(grep -wc ${callback_query_from_id} lista) != '0' ]] && {
      ShellBot.sendMessage --chat_id ${callback_query_message_chat_id} \
        --text "Ya creo un test gratis, vuelva mañana 🤝"
      return 0
    }
    usuario=$(echo SSH$(( RANDOM% + 250 )))
    senha=$((RANDOM% + 999999))
    limite='1'
    tempo='12'
    tuserdate=$(date '+%C%y/%m/%d' -d " +2 days")
    useradd -M -N -s /bin/false $usuario -e $tuserdate > /dev/null 2>&1
    (echo "$senha";echo "$senha") | passwd $usuario > /dev/null 2>&1
    echo "$senha" > /etc/SSHPlus/senha/$usuario
    echo "$usuario $limite" >> /root/usuarios.db
    echo "#!/bin/bash
pkill -f "$usuario"
userdel --force $usuario
grep -v ^$usuario[[:space:]] /root/usuarios.db > /tmp/ph ; cat /tmp/ph > /root/usuarios.db
rm /etc/SSHPlus/senha/$usuario > /dev/null 2>&1
rm -rf /etc/SSHPlus/userteste/$usuario.sh" > /etc/SSHPlus/userteste/$usuario.sh
    chmod +x /etc/SSHPlus/userteste/$usuario.sh
    at -f /etc/SSHPlus/userteste/$usuario.sh now + $tempo hour > /dev/null 2>&1
    echo ${callback_query_from_id} >> lista
    # - ENVIA O SSH
    ShellBot.sendMessage --chat_id ${callback_query_message_chat_id} \
    --text "$(echo -e "▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬\n        <b>✅ Creado con exito ✅</b>\n▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬\n            👤 USUARIO: <code>$usuario</code>\n              🔑 Contraseña: <code>$senha</code>\n             ⏰ Expira en: $tempo Horas")\n            👇 Dominio cloudflare 👇\n             ✅ free.webcont.services\n▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬\n   \n <b>Soporte las 24/7, @Net_Satoshi</b>\n  ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬" \
    --parse_mode html
    return 0
}

#enviar app
enviarapp() {
    ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
        --text "♻️ ENVIANDO APLICACION..."
    ShellBot.sendDocument --chat_id ${callback_query_message_chat_id} \
        --document "@/root/Speed-X14.apk" \
    return 0

}

#enviar sks
enviarsks() {
    ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
        --text "♻️ ENVIANDO ARCHIVOS HC..."
    ShellBot.sendDocument --chat_id ${callback_query_message_chat_id} \
        --document "@/root/Redes-Nic.hc" \
    return 0
    ShellBot.sendDocument --chat_id ${callback_query_message_chat_id} \
        --document "@/root/Redes_Nic.ehi" \
    return 0
    ShellBot.sendDocument --chat_id ${callback_query_message_chat_id} \
        --document "@/root/TIM.sks" \
    return 0

}

#enviar ehi
enviarehi() {
    ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
        --text "♻️ ENVIANDO ARCHIVOS EHI..."
    ShellBot.sendDocument --chat_id ${callback_query_message_chat_id} \
        --document "@/root/CLARO.ehi" \
    return 0
    ShellBot.sendDocument --chat_id ${callback_query_message_chat_id} \
        --document "@/root/VIVO.ehi" \
    return 0
    ShellBot.sendDocument --chat_id ${callback_query_message_chat_id} \
        --document "@/root/TIM.ehi" \
    return 0


    }

#informacoes usuario
infouser () {
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
        --text "$(echo -e "Nome:  ${message_from_first_name[$(ShellBot.ListUpdates)]}\nUser: @${message_from_username[$(ShellBot.ListUpdates)]:-null}")\nID: ${message_from_id[$(ShellBot.ListUpdates)]} " \
        --parse_mode html
        return 0
}

unset botao1
botao1=''
ShellBot.InlineKeyboardButton --button 'botao1' --line 1 --text '♻️ GENERAR TEST  ♻️' --callback_data 'gerarssh'
ShellBot.InlineKeyboardButton --button 'botao1' --line 2 --text '🔰 DESCARGAR APLICACION 🔰' --callback_data 'appenviar'
ShellBot.InlineKeyboardButton --button 'botao1' --line 3 --text 'Comprar 1Mes C$100'  --callback_data '3' --url 'https://wa.me/+50557617268' # comprar
ShellBot.InlineKeyboardButton --button 'botao1' --line 4 --text 'Como usar el Bot'  --callback_data '4' --url 'https://youtu.be/BSS8YAPoHS8?si=hf_RLLGOZIay-POq' # tutorial
ShellBot.InlineKeyboardButton --button 'botao1' --line 5 --text 'Canal Telegram'  --callback_data '5' --url 'https://t.me/WEBCONT_OFC' # canal
ShellBot.regHandleFunction --function criarteste --callback_data gerarssh
ShellBot.regHandleFunction --function enviarapp --callback_data appenviar
ShellBot.regHandleFunction --function enviarsks --callback_data sksenviar
ShellBot.regHandleFunction --function enviarehi --callback_data ehienviar
unset keyboard1
keyboard1="$(ShellBot.InlineKeyboardMarkup -b 'botao1')"
while :; do
   [[ "$(date +%d)" != "$(cat RESET)" ]] && {
           echo $(date +%d) > RESET
           echo ' ' > lista
   }
  ShellBot.getUpdates --limit 100 --offset $(ShellBot.OffsetNext) --timeout 24
  for id in $(ShellBot.ListUpdates); do
    (
      ShellBot.watchHandle --callback_data ${callback_query_data[$id]}
      comando=(${message_text[$id]})
      [[ "${comando[0]}" = "/menu"  || "${comando[0]}" = "/start" ]] && menu
      [[ "${comando[0]}" = "/id"  ]] && infouser
    ) &
  done
done