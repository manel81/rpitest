##### DOCKERFILE DEVELOPER PORTAL INSTALLATION PROVIDED BY PRONOVIX
# FILE: Dockerfile 
# Fecha: 27/01/21
# 
# FUNCION: Recibimos dos ficheros con el contenido DP-site-allianz_accept_LATEST que contiene la base del DP 
# Y dp-allianz-accept-"fecha"* con los ficheros incluidos en el directorio files. 
# Ejecutamos un primer paso copiando los ficheros dentro de la imagen y un segundo paso con el install.sh que contiene 
# el proceso de instalación mínimo para la imagen del Developer Portal 
# El fichero post_install.sh contiene el script para ejecutar el proceso de migración de datos.
### IMAGEN BASE PARA NUESTRA IMAGEN 
FROM centos:7
##### Copiar Ficheros necesarios a la imagen 
COPY install.sh  /tmp/
COPY start.sh  /
COPY sshd_config /etc/ssh/
COPY welcome.conf /etc/httpd/conf.d/
### EJECUTAR install.sh QUE REALIZARA LA INSTALACION MINIMA EN LA IMAGEN 
RUN chmod 755 /tmp/install.sh; /tmp/install.sh ; chmod +x /start.sh ; /usr/sbin/sshd
#;  mkdir /home/devportal ; mkdir /home/devportal/web
### Comando que ejecutaremos en el contenedor
#CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
CMD ["sh","-c","/start.sh; /usr/sbin/httpd -D FOREGROUND ; /usr/sbin/sshd " ]
## Acceso SSH desde webapps



