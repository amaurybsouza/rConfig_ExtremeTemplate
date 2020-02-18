#!/usr/bin/env bash
 
# ------------------------------------------------------------------------ #
# Script Name:   rconfig_backup.sh 
# Description:   Clear old logs and debugs of the system and verify disco size.
# Written by:    Amaury Souza
# Maintenance:   Amaury Souza
# ------------------------------------------------------------------------ #
# Usage:         
#       $ ./rconfig_backup.sh
# ------------------------------------------------------------------------ #
# Bash Version:  
#              Bash 4.4.19
# ------------------------------------------------------------------------ # 
# History:        v1.0 10/06/2019, Amaury:
#                - Start de program
#                - Add (find command)
#                v1.1 11/06/2019, Amaury:
#                - Tested with apt variable feature
#                v1.2 11/06/2019, Amaury:
#                - Teste again with new functions
# ------------------------------------------------------------------------ #
# Thankfulness:
#
# ------------------------------------------------------------------------ #
clear
while true; do
TIME=1
LISTASWITCHES=`ls /home/rconfig/data/Switches/ | wc -l`
LISTAFIREWALL=`ls /home/rconfig/data/Firewalls/ | wc -l`
echo " "
echo "SEJA BEM VINDO AO $0 DO rConfig!"
echo " "
echo "Escolha uma opção abaixo para começar!
      
      1 - Limpar dados de debug do rConfig
      2 - Limpar dados de cache dos switches (1, 2, 3, 4 e 5)
      3 - Mostrar dados do Fortigate e exclui-los
      4 - Mostrar estatística de espaço em disco
      5 - Mostrar número total de switches
      6 - Mostrar número total de firewalls
      0 - Sair do sistema"
echo " "
echo -n "Opção escolhida: "
read opcao
case $opcao in
                1)
                        echo Limpando o debug do sistema...
                        sleep $TIME
                        rm -rfv /home/rconfig/logs/debugging/debug* > /dev/null
                        if [ $? -eq 0 ]
                        then
                                echo Limpeza de debug realizado com êxito!
                        else
                                echo Ainda existem arquivos de debug no sistema!
                        fi
                        ;;
                2)
			echo Limpando o cache dos switches principais da empresa
                        sleep $TIME
                        echo -n "Digite um dia do mês atual (conte 5 dias atrás) para limpar: "
                        read dia
                        find /home/rconfig/data/Switches/sw1/2019/Jun/$dia/showconfiguration* -mtime +5 | xargs rm -rf
                        find /home/rconfig/data/Switches/sw2/2019/Jun/$dia/showconfiguration* -mtime +5 | xargs rm -rf
                        find /home/rconfig/data/Switches/sw3/2019/Jun/$dia/showconfiguration* -mtime +5 | xargs rm -rf
                        find /home/rconfig/data/Switches/sw4/2019/Jun/$dia/showconfiguration* -mtime +5 | xargs rm -rf
                        find /home/rconfig/data/Switches/sw5/2019/Jun/$dia/showconfiguration* -mtime +5 | xargs rm -rf
                        ;;
                3)
                        echo Mostrando os dados em cache do Firewall...
                        echo " "
                        sleep $TIME
                        find /home/rconfig/data/Firewalls/Firewall/2019/* -mtime +7
                        echo " "
                        echo -n "Deseja excluir os dados com mais de 7 dias? Digite sim ou não: "
                        read usuario
                        if [ $usuario == sim ]
                        then
                                find /home/rconfig/data/Firewalls/Firewall/2019/* -mtime +7 | xargs rm -rf > /dev/null
                                sleep $TIME
                                echo Dados deletados com êxito!
                                sleep $TIME
                        else
                                echo Você digitou errado!
                        fi
                        ;;
                4)
                        echo O espaço em disco é: 
                        echo " " 
                        df -h / | sed 's/.\{23\}//'
                        ;;
                5)
                        echo O número de switches no rConfig é: $LISTASWITCHES
                        ;;
                6)
                        echo O número de firewalls no rConfig é: $LISTAFIREWALL
                        ;;
                0)
                        echo Saindo do sistema...
                        sleep $TIME
                        exit 0
                        ;;
		*)
                        echo Opção inválida! Tente novamente.
                        exit 0
                        ;;
esac
done

