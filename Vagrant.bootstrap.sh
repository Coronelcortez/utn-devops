#!/bin/bash

### Aprovisionamiento de software ###

# Actualizo los paquetes de la maquina virtual
sudo apt-get update

# Instalo un servidor web
sudo apt-get install -y nginx 

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
APP_PATH="$NGINX_ROOT/utn-devops-app"


## configuración servidor web
#copio el archivo de configuración del repositorio en la configuración del servidor web
if [ -f "/tmp/equipo-5.site.conf" ]; then
	echo "Copio el archivo de configuracion de nginx"
	sudo mv /tmp/equipo-5.site.conf /etc/nginx/sites-available
	#hago un link para activar el sitio
	sudo rm /etc/nginx/sites-enabled/default
	sudo ln -s /etc/nginx/sites-available/equipo-5.site.conf /etc/nginx/sites-enabled/default
	#relod nginx
	sudo service nginx reload
fi
	
## aplicación

# descargo la app del repositorio
if [ ! -d "$APP_PATH" ]; then
	echo "clono el repositorio"
	cd $NGINX_ROOT
	sudo git clone https://github.com/tomich/webapp-ejemplo-curso.git
	cd $APP_PATH
	sudo git checkout main
fi

