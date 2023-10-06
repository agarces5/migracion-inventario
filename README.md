# Prerrequisitos
Estoy usando mikrok8s-hostpath como storageclass y Traefik como Ingress.
# Instalacion
Solo tendremos que modificar el provider para usar el archivo de configuracion para kubectl y construirlo con Terraform.
Si nos da problemas el ingressroute, podemos ejecutarlo directamente con el yaml. El certificado se debe crear automaticamente con letsencrypt y ponerlo, habria que crear el middleware de la redireccion https y ponerlo en el ingressroute.
# Post-instalacion
Hay que cambiar los permisos del volumen de glpi para que la carpeta con la web pertenezca a www-data.
Una vez creada la infrastructura, habra que volver a reconfigurar la aplicacion para que detecte la bbdd.
Tendremos que meternos en el pod de glpi y en la carpeta donde esta instalado usamos el comando `php bin/console db:configure -r -H HOST -d DB_NAME -u DB_USER -p DB_PASSWORD`. Tendremos que poner en HOST, el nombre del servicio de mariadb.

