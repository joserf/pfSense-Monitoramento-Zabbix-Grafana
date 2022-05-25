#!/bin/sh

#
# José Rodrigues Filho
# Você pode alterar, mas mantenha os créditos.
#

# Versão do Script
VERSION='v1.0.0'
# Versão homologada do pfSense
pfVERSION='2.6.0-RELEASE'
# Versão homologada do Zabbix
zbxVERSION='1.0.4_12'
# Versão homologada do Status Traffic (vnstat 2.8)
sttVERSION='2.3.2_2'

# Verifica versão pfSense
if [ "$(cat /etc/version)" != "${pfVERSION}" ]; then
    echo "ERRO: Você precisa do pfSense versão 2.6.0 para aplicar este script!"
    exit 2
fi

# Instalação de pacotes sem confirmação 
ASSUME_ALWAYS_YES=YES
export ASSUME_ALWAYS_YES

# Update
/usr/sbin/pkg update

# Verifica se existe o Zabbix | Instala o Zabbix
if [ "$(pkg info -i pfSense-pkg-zabbix-agent54 | grep Version | awk '{ print $3 }')" != "${zbxVERSION}" ]; then
    /usr/sbin/pkg install pfSense-pkg-zabbix-agent54    
else
    echo "Zabbix instalado!"
fi

# Verifica se existe o Status Traffic Totals | Instala o Status Traffic Totals
if [ "$(pkg info -i pfSense-pkg-Status_Traffic_Totals | head -n3 | awk '{ print $3 }' | tail -n 1)" = "${sttVERSION}" ]; then
    echo "Status Traffic instalado!"
else
    /usr/sbin/pkg install pfSense-pkg-Status_Traffic_Totals-2.3.2_2
fi


