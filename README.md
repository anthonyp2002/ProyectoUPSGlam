# UPSGlam - Plataforma Social de Imágenes con Convolución y Dockerización

## Descripción

UPSGlam es una aplicación móvil tipo Instagram que permite a los usuarios compartir y visualizar imágenes procesadas con filtros de convolución personalizados, desarrollados en PyCUDA para aprovechar el poder de las GPUs. La aplicación combina una interfaz intuitiva en Flutter, una API basada en Flask, y almacenamiento en Firebase Firestore Storage.
A few resources to get you started if this is your first Flutter project:

## Objetivos del Proyecto
El objetivo es ofrecer una plataforma social que permita:

  - Publicar imágenes con filtros únicos diseñados por el equipo.
  - Interactuar con publicaciones mediante likes y comentarios.
  - Integrar tecnologías modernas como PyCUDA y Firebase para maximizar la eficiencia.

## Arquitectura del Proyecto

![UPSGlam drawio](https://github.com/user-attachments/assets/4e2f1183-0b9b-4b89-9a3d-d1b9778be2fd)

## Filtros de Convolución Implementados
- Filtro LAPLACE:
Este filtro resalta las transiciones bruscas en la intensidad de los píxeles, lo que lo hace ideal para detectar bordes en las imágenes. Se utiliza principalmente en aplicaciones de análisis visual para identificar contornos y áreas de cambio repentino en color o luminosidad.

- Filtro LOGO UPS & VIGNETTE:
Combina dos efectos en un único filtro: superpone el logo de la Universidad Politécnica Salesiana (UPS) sobre la imagen original y aplica un sombreado de viñeta en los bordes, destacando el centro de la imagen. Este filtro tiene un enfoque estético y representativo.

- Filtro PIXELADO:
Agrupa los píxeles en bloques más grandes para crear un efecto de mosaico. Este filtro es popular en aplicaciones que buscan simplificar la visualización o añadir un estilo artístico retro a las imágenes.

- Filtro RELIEVE:
Este filtro resalta los bordes de los objetos en la imagen, generando un efecto tridimensional que simula profundidad. Es útil para mejorar detalles visuales y destacar estructuras en las imágenes.

- Filtro MOTION BLUR:
Simula el desenfoque producido por el movimiento, creando una sensación de dinamismo en la imagen. Este filtro se utiliza ampliamente en gráficos y efectos visuales para ilustrar velocidad o desplazamiento.

## Instalación y Configuración
Frontend
1. Instalar Flutter:
  Descarga Flutter desde la página oficial.
  Verifica la instalación:

    flutter doctor
   
3. Crear Proyecto y ejecutar:
   Clona el repositorio:
   
     git clone https://github.com/usuario/UPSGlam.git
   
     cd ProyectoUPSGlam
   
   Instala las dependencias:
   
     flutter pub get
   
   Corre el proyecto:
   
     flutter run
   
5. Construir el apk:
   
     flutter build apk --release

     El archivo apk se guardara en la ruta:
   
![image](https://github.com/user-attachments/assets/a4a1201c-5bd0-4461-8764-bfb424e40104)



# Backend
1. Clona el repositorio y navega a la carpeta del backend:
   
    git clone https://github.com/usuario/UPSGlam.git
   
    cd ProyectoUPSGlam
   
3. Crea un entorno virtual e instala las dependencias:
   
    python -m venv venv
   
    source venv/bin/activate  # En Windows usa `venv\Scripts\activate`
   
    pip install numpy flask pycuda pillow
   
5. Correr el servidor:
   
    python app.py

# Dockerización:
1. Crea un archivo DockerFile:
   
    Usar la imagen base de CUDA con soporte para cuDNN y Ubuntu 22.04
    FROM nvidia/cuda:12.4.1-cudnn-devel-ubuntu22.04
    
    Actualizar paquetes y configurar Python con dependencias necesarias
    RUN apt-get -qq update && \
        apt-get -qq install -y build-essential python3-pip && \
        pip3 install flask pycuda numpy
    
    Crear directorio para la aplicación y copiar los archivos del proyecto
    WORKDIR /app
    COPY . /app
    
    Establecer el archivo principal como punto de entrada
    Exponer el puerto para la aplicación Flask
    EXPOSE 5000
    
    Comando para iniciar el servidor, ajustado para la ruta correcta de app.py
    CMD ["python3", "/app/ProyectoUPSGlam/app.py"]
    
    #docker build -t upsglam_imagen .
    #docker run -p 5000:5000 --gpus all upsglam_imagen

3. Ejecuta el comando
   
   docker build -t nombreDelContenedor .
   
5. Ejecuta el comando
   
   docker run -p 5000:5000 --gpus all upsglam_imagen

# Docker creado:
![image](https://github.com/user-attachments/assets/0e05faed-cc0e-4134-a4e1-7baa1254c2b3)



## Resultados
![Imagen de WhatsApp 2024-11-25 a las 21 35 34_2ee798ee](https://github.com/user-attachments/assets/ef54696e-9215-47ee-acee-b677c94083ad)

![Imagen de WhatsApp 2024-11-25 a las 21 35 33_e517f889](https://github.com/user-attachments/assets/64bde61d-0b9c-452a-9a34-55f0ce83285e)

![Imagen de WhatsApp 2024-11-25 a las 21 43 10_66cadbb8](https://github.com/user-attachments/assets/a110913c-f721-4468-b307-c6b14cc14250)

![Imagen de WhatsApp 2024-11-26 a las 08 03 29_16dad4a0](https://github.com/user-attachments/assets/d9adf1f0-abb4-40a8-af2b-5c993b5d1d7d)


## Conclusiones

Como conclusión, UPSGlam representa una combinación innovadora de creatividad técnica y funcionalidad práctica, destacándose como una plataforma que integra redes sociales con procesamiento gráfico avanzado mediante el uso de filtros personalizados implementados con PyCUDA. El proyecto logró superar importantes desafíos, como la implementación eficiente de algoritmos de convolución, la integración fluida entre el frontend desarrollado en Flutter, el backend basado en Flask y PyCUDA, y el almacenamiento en Firebase. A futuro, se plantea la posibilidad de implementar filtros en tiempo real y optimizar la aplicación para dispositivos iOS, con el objetivo de expandir su alcance y mejorar la experiencia del usuario.
