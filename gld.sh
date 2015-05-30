#!/bin/bash
#Sistema diseñado para:
# Diseñado para:
#   Debian 7
#   Ubuntu LTS, Ubuntu 13.04, Ubuntu 13.10
#

# Ejecutado con ROOT?
if [ "x$(id -u)" != 'x0' ]; then
    echo 'Error: Este script es solo para usuarios ROOT'
    exit 1
fi
# Usuario Steam Existe?
if [ ! -z "$(grep ^steam: /etc/passwd)" ] && [ -z "$1" ]; then
    echo "Error: usuario steam ya existe"
    echo
    echo 'Elimina el usuario steam para continuar.'
    exit 1
fi
# Detectando sistema operativo
case $(head -n1 /etc/issue | cut -f 1 -d ' ') in
    Debian)     type="deb" ;;
    Ubuntu)     type="ubu" ;;
    *)          type="rhel" ;;
esac
# Descargando Instalador con WGET
if [ -e '/usr/bin/wget' ]; then
    wget http://fsanllehi.me/pub/steam_$type.sh -O steam_$type.sh
    if [ "$?" -eq '0' ]; then
        bash steam_$type.sh $*
        exit
    else
        echo "Error: Falla al descargar con WGET."
        exit 1
    fi
fi