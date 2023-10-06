# Preparacion
Estoy usando **mikrok8s-hostpath** como **storageclass** y **Traefik** como **Ingress**. Habrá que ajustar estos valores dependiendo del clúster.

También tendremos que modificar el **provider** para usar el que corresponda a nuestro clúster.

Tendremos que tener localizadas las carpetas que se van a montar como volúmenes en nuestros pods, en este caso van a ser volúmenes de tipo **hostpath** por lo que tendremos que pasar las carpetas al **host**. Una vez las carpetas en el host, tendremos que modificar los **pv**, poner correctamente el **path** y ajustar el tamaño de los volúmenes si fuera necesario.

Habrá que modificar también el **dominio** en el **ingressroute**.

# Variables que se pueden cambiar
namespace:
- name

pv:
- name
- labels
- capacity.storage
- access_modes
- host_path

pvc:
- name

apps:
- name
- replicas

svc:
- name
- selector

ingressroute:
- name
- entrypoints
- routes
- middlewares
- tls

# Post-instalacion
Hay que cambiar los permisos del volumen de glpi para que la carpeta con la web pertenezca a www-data.

Una vez creada la infrastructura, habra que volver a reconfigurar la aplicacion para que detecte la bbdd.

Tendremos que meternos en el pod de glpi y en la carpeta donde esta instalado usamos el comando `php bin/console db:configure -r -H HOST -d DB_NAME -u DB_USER -p DB_PASSWORD`. Tendremos que poner en HOST, el nombre del servicio de mariadb.

