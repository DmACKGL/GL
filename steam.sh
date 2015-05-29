#!/bin/bash
# Verificacion ROOT
FILE="/tmp/out.$$"
GREP="/bin/grep"
# Solo usuarios Root [CHECK]
if [[ $EUID -ne 0 ]]; then
   echo "Solo Usuarios ROOT pueden correr este Script" 1>&2
   exit 1
fi

#Carga de programa definicion de parametros
dir=/home/steam/
csudo='sudo -u steam'
echo """
	Sistema de Instalacion de servidores GamerLive.cL!
	Confirma en en Resolv.conf tengas los siguientes DNS

		1.- nameserver 131.221.33.45

	Procura no tener ningun otro 'nameserver' en la lista!
	Los DNS solo funcionan en la RED GamerLive y no fuera de ella
	"""
elegir=""
	while [ "$elegir" != "q" ]
	do
		echo """
			1) Instalacion Basica (STEAMCMD PURO)
			2) Instalacion Servidores por ID
			3) Instalacion Parches STEAMCMD (Errores conocidos)
			4) Salir
			"""
		read elegir
		case $elegir in
			'1') echo "Comenzando Instalacion"
				#Descargando paquetes necesarios
				apt-get install lib32gcc1
				#Creacion de usuario y descarga de STEAMCMD
				echo "Creando Usuario"
				useradd -m steam
				$csudo mkdir $dir/steamcmd
				cd $dir/steamcmd
				echo "Descargando STEAMCMD"
				$csudo wget http://media.steampowered.com/installer/steamcmd_linux.tar.gz
				$csudo tar -xvzf steamcmd_linux.tar.gz
				cd $dir/steamcmd
				$csudo wget http://fsanllehi.me/steamcmdp.txt
				$csudo mv steamcmdp.txt CMDPURO.txt
				$csudo ./steamcmd.sh +runscript CMDPURO.txt
				echo """
					Instalacion finalizada...
					Directorio: /home/steam/steamcmd

					Gracias por utilizar el sistema de instalacion automatica
					"""
				exit 0
				;;
			'2') echo "Comenzando Instalacion"
			 	while [ "$elegir" != "q" ]
					do
						echo """
						Lista de servdiores LINUX STEAMCMD: https://fsanllehi.me/servers.html
						Escriba ID Servidor dedicado
						"""
						read elegir
						ID=$elegir
					#Creacion de usuario y descarga de STEAMCMD
					echo "Creando Usuario"
					useradd -m steam
					$csudo mkdir $dir/steamcmd
					cd $dir/steamcmd
					echo "Descargando STEAMCMD"
					$csudo wget http://media.steampowered.com/installer/steamcmd_linux.tar.gz
					$csudo tar -xvzf steamcmd_linux.tar.gz
					cd $dir/steamcmd
					$csudo ./steamcmd.sh +login anonymous +app_update $ID +quit
					echo """
						Instalacion finalizada...
						Directorio: /home/steam/steamcmd/
						Directorio servidores instalados: /home/Steam/steamapps/

						Gracias por utilizar el sistema de instalacion automatica
						"""
					exit 0
					done;;

			'3') echo "Aplicando Parches!"
					apt-get install lib32gcc1
					dpkg --add-architecture i386
					apt-get update
					apt-get install lib32gcc1
				 	echo """
				 		Parches aplicados!
				 		""";;
			'4') echo "Saliendo..."
					exit;;
			*) 	 echo "Selecciona una opcion valida";;
		esac
	done
exit 0