#!/bin/bash 
#####
##
## FILE: install.sh 
## Autor: Yo
## Fecha: 23-07-19
## Función: Instalar las dependencias necesarias e instalación del DP de pronovix
## El script recoge el nombre de los ficheros a usar por parametros (se configuraran dentro del Dockerfile como variables) 
##
######
LATEST=$1
FILES=$2
CONF=$3


echo -e "Instalando Developer portal...\n"
echo -e "==============================\n\n"
{
### Instalacion de los paquetes necesarios 
echo -e "Install requeriments\n" 
yum -y install epel-release http://rpms.remirepo.net/enterprise/remi-release-7.rpm yum-utils 
yum-config-manager --enable remi-php74  
yum -y install openssh-server httpd git zip php mod_php php-bcmath php-cli php-gd php-ldap php-mbstring php-soap php-common php-gd php-json php-mbstring php-mysqlnd php-opcache php-pdo php-process php-xml php-intl php-xmlrpc php-zip mysql mod_ssl telnet wget  
## configuracion sshd
echo "root:Docker!" | chpasswd 
ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N ''
ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key -N ''
/usr/bin/ssh-keygen -A
/usr/bin/sshd

### Modificación del Apache (Document Root) 
echo -e "Modify Apache configuration\n"
sed -i 's|DocumentRoot .*|DocumentRoot /home/devportal/web/|' /etc/httpd/conf/httpd.conf  
# sed 's/Listen 80/Listen 80\nListen 443/g' -i httpd.conf
### Activar AllowOverride 
#echo -e "<Directory /home/devportal/web/>\n    AllowOverride All \n Require All granted\n</Directory>" >>  /etc/httpd/conf.d/welcome.conf  


### Añadir el usuario para el Devportal (el propietario será devportal y el grupo apache)
echo -e "Adding user devportal\n"
adduser devportal

### Crear el directorio del site
# mkdir -p /home/web
/usr/bin/git clone https://github.com/manel81/webcontent.git /home/devportal
chown -R devportal: /home/devportal
chmod +x /start.sh 
} | tee /tmp/installation.log
echo "Installation finished. LOG into /tmp/installation.log"
rm -rf /home/devportal
/usr/bin/git clone https://github.com/manel81/webcontent.git /home/devportal

