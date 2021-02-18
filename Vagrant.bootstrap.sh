#!/bin/bash

### Aprovisionamiento de software ###

# Actualizo los paquetes de la maquina virtual
sudo apt-get update

# Desinstalo el servidor web previamente instalado
if [ -x"$(command -v nginx)" ];then
	sudo apt-get remove --purge nginx -y
	sudo apt autoremove -y
fi 

### Configuración del entorno ###

##Genero una partición swap. Previene errores de falta de memoria
if [ ! -f "/swapdir/swapfile" ]; then
	sudo mkdir /swapdir
	cd /swapdir
	sudo dd if=/dev/zero of=/swapdir/swapfile bs=1024 count=2000000
	sudo mkswap -f  /swapdir/swapfile
	sudo chmod 600 /swapdir/swapfile
	sudo swapon swapfile
	echo "/swapdir/swapfile       none    swap    sw      0       0" | sudo tee -a /etc/fstab /etc/fstab
	sudo sysctl vm.swappiness=10
	echo vm.swappiness = 10 | sudo tee -a /etc/sysctl.conf
fi

# ruta raíz del servidor web
NGINX_ROOT="/var/www"
# ruta de la aplicación
APP_PATH="$NGINX_ROOT/webapp-ejemplo-curso"


##Aplicación

# descargo la app del repositorio
if [ ! -d "$APP_PATH" ]; then
	echo "clono el repositorio"
	cd $NGINX_ROOT
	sudo git clone https://github.com/tomich/webapp-ejemplo-curso.git
	cd $APP_PATH
	sudo git checkout main
fi

