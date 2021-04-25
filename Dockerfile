# Se define el lenguaje y la version que vamos a correr en nuestra maquina
FROM python:3.6.10

# Se hacen las actualizaciones, configuraciones de zona y se crean carpetas de configuración

RUN apt-get -y update \
       && apt-get install -y locales locales-all \
       && locale-gen en_US.ISO-8859-1 \
       && echo "America/Bogota" > /etc/timezone \
       && dpkg-reconfigure -f noninteractive tzdata \
       && mkdir -p /opt/config  \
       && mkdir -p /opt/files

# Se define un directorio de trabajo, donde se deben encontrar los archivos que queremos utilizar, como la carpeta User, en el OP
WORKDIR /code

# Se expone el puerto 8080 para poder comunicarse con el docker en caso de querer consumir servicios rest
EXPOSE 8080 

# Correr comandos para hacer configuraciones previas ej: instalación de una dependencia para una libreria
RUN wget http://download.osgeo.org/libspatialindex/spatialindex-src-1.8.5.tar.gz && \
  tar -xvzf spatialindex-src-1.8.5.tar.gz && \
  cd spatialindex-src-1.8.5 && \
  ./configure && \
  make && \
  make install && \
  cd - && \
  rm -rf spatialindex-src-1.8.5* && \
  ldconfig

# Copiar proyecto "COPY ruta_fuente ruta_destino"
COPY . /code
COPY requirements.txt /opt/config/

# ------- En caso de tener un archivo de credenciales a AWS, se copia a esta ruta, que es donde boto3 busca los accesos -------
#COPY credentials /root/.aws/credentials

# ------ Un ejemplo de como instalar librerias desde git -------------
#RUN pip install https://github.com/QuantCrimAtLeeds/PredictCode/zipball/master 

# Una vez copiado los archivos, corremos la instalación de requerimientos
RUN pip install -r /opt/config/requirements.txt 

# El punto de entrada es el ejecutable que va a correr el comando de la linea siguiente, que apunta hacía el archivo principal de nuestro script
ENTRYPOINT [ "python3" ]
CMD [ "src/main.py" ]