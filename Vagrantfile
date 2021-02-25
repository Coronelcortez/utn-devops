# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  #ubuntu 64 bits porque me place
  config.vm.box = "ubuntu/bionic64"

  #bindeamos el puerto 8080 del host al puerto 80 de la vm
  config.vm.network "forwarded_port", guest: 8081, host: 8080

  #nombre de la vm
  config.vm.hostname = "utn-devops-equipo-5.localhost"
  config.vm.provider "virtualbox" do |v|
	v.name = "utn-devops-vagrant-equipo-5"
  end
  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"
  # 
  # Mapeo de directorios que se comparten entre la maquina virtual y nuestro equipo. En este caso es
  # el propio directorio donde está el archivo  y el directorio "/vagrant" dentro de la maquina virtual.
  config.vm.synced_folder ".", "/vagrant"


  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   
  # Customize the amount of memory on the VM:
    vb.memory = "1024"
  end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
  # such as FTP and Heroku are also available. See the documentation at
  # https://docs.vagrantup.com/v2/push/atlas.html for more information.
  # config.push.define "atlas" do |push|
  #   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
  # end

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  #config.vm.provision "shell", inline: <<-SHELL
  #  echo "I am provisioning..."
  #  date > /etc/vagrant_provisioned_at
  #SHELL
  
  # Copia el archivo de configuración del servidor web // comento porque no hace falta ya
  #config.vm.provision "file", source: "Configs/equipo-5.site.conf", destination: "/tmp/equipo-5.site.conf"
  
  # En este archivo tendremos el provisionamiento de software necesario para nuestra 
  # maquina virtual. Por ejemplo, servidor web, servidor de base de datos, etc.
  config.vm.provision :shell, path: "Vagrant.bootstrap.sh", run: "always"
  

end
