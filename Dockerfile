# Usar la imagen base de CUDA con soporte para cuDNN y Ubuntu 22.04
FROM nvidia/cuda:12.4.1-cudnn-devel-ubuntu22.04

# Actualizar paquetes y configurar Python con dependencias necesarias
RUN apt-get -qq update && \
    apt-get -qq install -y build-essential python3-pip && \
    pip3 install flask pycuda numpy

# Crear directorio para la aplicación y copiar los archivos del proyecto
WORKDIR /app
COPY . /app

# Establecer el archivo principal como punto de entrada
# Exponer el puerto para la aplicación Flask
EXPOSE 5000

# Comando para iniciar el servidor, ajustado para la ruta correcta de app.py
CMD ["python3", "/app/ProyectoUPSGlam/app.py"]

#docker build -t upsglam_imagen .
#docker run -p 5000:5000 --gpus all upsglam_imagen
