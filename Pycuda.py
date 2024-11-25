from flask import Flask, render_template, request, send_from_directory
import numpy as np
import time
from PIL import Image
import os
from flask import jsonify
from datetime import datetime

app = Flask(__name__)

# Directorio donde se guardarán las imágenes
UPLOAD_FOLDER = os.path.join(os.getcwd(), 'images')
if not os.path.exists(UPLOAD_FOLDER):
    os.makedirs(UPLOAD_FOLDER)

app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

# Funciones para cargar, procesar y guardar imágenes
def load_image(filename):
    img = Image.open(filename).convert('RGB')
    return np.array(img), img.size

def save_image(filename, img, width, height):
    img = Image.fromarray(img.reshape((height, width)).astype(np.uint8))
    img.save(filename)

def apply_laplace_filter(img, width, height, kernel_size):
    cuda.init()
    device = cuda.Device(0)
    context = device.make_context()  # Crea un contexto para la GPU

    try:
        # Convierte la imagen a un array de GPU
        img_gpu = gpuarray.to_gpu(img)

        # Crear el kernel Laplace
        laplace_kernel = np.array([[-1, -1, -1], [-1, 8, -1], [-1, -1, -1]], dtype=np.float32)
        kernel_gpu = gpuarray.to_gpu(laplace_kernel)

        # Compilar el código CUDA
        mod = compiler.SourceModule(laplace_filter_code)
        laplace_filter = mod.get_function("laplace_filter")

        block_size = (16, 16, 1)
        grid_size = ((width + block_size[0] - 1) // block_size[0],
                     (height + block_size[1] - 1) // block_size[1])

        # Ejecutar el filtro Laplace en la GPU
        output_gpu = gpuarray.empty_like(img_gpu)
        laplace_filter(img_gpu, output_gpu, np.int32(width), np.int32(height), kernel_gpu, np.int32(kernel_size),
                       block=block_size, grid=grid_size)

        # Sincronizar la ejecución
        cuda.Context.synchronize()

        # Traer el resultado de vuelta a la CPU
        laplace_image = output_gpu.get()

    finally:
        # Liberar el contexto de la GPU
        context.pop()

    return laplace_image


# Función para aplicar el filtro Motion Blur
def apply_motion_blur_filter(img, width, height, kernel_size):
    cuda.init()
    device = cuda.Device(0)
    context = device.make_context()

    try:
        img_gpu = gpuarray.to_gpu(img)
        output_gpu = gpuarray.empty_like(img_gpu)

        mod = compiler.SourceModule(motion_blur_filter_code)
        motion_blur_filter = mod.get_function("motion_blur_filter")

        block_size = (16, 16, 1)
        grid_size = ((width + block_size[0] - 1) // block_size[0],
                     (height + block_size[1] - 1) // block_size[1])

        motion_blur_filter(img_gpu, output_gpu, np.int32(width), np.int32(height), np.int32(kernel_size),
                           block=block_size, grid=grid_size)

        cuda.Context.synchronize()

        motion_blur_image = output_gpu.get()

    finally:
        context.pop()

    return motion_blur_image


# Función para aplicar el filtro Relieve
def apply_relieve_filter(img, width, height, kernel_size, factor):
    cuda.init()
    device = cuda.Device(0)
    context = device.make_context()

    try:
        relieve_kernel = np.zeros((kernel_size, kernel_size), dtype=np.int32)
        mitad = kernel_size // 2
        for i in range(kernel_size):
            for j in range(kernel_size):
                if i < mitad and j < mitad:
                    relieve_kernel[i, j] = -1
                elif i > mitad and j > mitad:
                    relieve_kernel[i, j] = 1

        img_gpu = gpuarray.to_gpu(img)
        output_gpu = gpuarray.empty_like(img_gpu)
        relieve_kernel_gpu = gpuarray.to_gpu(relieve_kernel.flatten())

        mod = compiler.SourceModule(relieve_filter_code)
        relieve_filter = mod.get_function("relieve_filter")

        block_size = (16, 16, 1)
        grid_size = ((width + block_size[0] - 1) // block_size[0],
                     (height + block_size[1] - 1) // block_size[1])

        relieve_filter(img_gpu, output_gpu, np.int32(width), np.int32(height), relieve_kernel_gpu, np.int32(kernel_size),
                       np.float32(factor), block=block_size, grid=grid_size)

        cuda.Context.synchronize()

        relieve_image = output_gpu.get()

    finally:
        context.pop()

    return relieve_image

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/upload', methods=['POST'])
def upload_image():
    if 'image' not in request.files:
        return 'No image file part', 400
    file = request.files['image']
    if file.filename == '':
        return 'No selected file', 400

    filename = os.path.join(app.config['UPLOAD_FOLDER'], file.filename)
    file.save(filename)

    # Leer la imagen
    img = Image.open(filename).convert('RGB')
    img = np.array(img)
    img_gray = np.dot(img[..., :3], [0.299, 0.587, 0.114]).astype(np.uint8)
    height, width = img_gray.shape

    # Obtener los parámetros del formulario
    filter_name = request.form['filter']
    kernel_size = int(request.form['kernel_size'])
    threads_per_block = int(request.form['threads'])


    timestamp = datetime.now().strftime('%y%m%d_%H%M%S')  # Incluye los segundos
    # Guardar la imagen procesada
    processed_filename = os.path.join(app.config['UPLOAD_FOLDER'], f'processed_{timestamp}.png')

    save_image(processed_filename, img_gray, width, height)

    # Enviar el nombre del archivo procesado como respuesta
    return jsonify({"filename": f'processed_{timestamp}.png'})

@app.route('/images/<filename>')
def uploaded_file(filename):
    return send_from_directory(app.config['UPLOAD_FOLDER'], filename)

@app.route('/process', methods=['POST'])
def process_image():
    if 'image' not in request.files:
        return 'No image file part', 400
    file = request.files['image']
    if file.filename == '':
        return 'No selected file', 400

    filename = os.path.join(app.config['UPLOAD_FOLDER'], file.filename)
    file.save(filename)

    # Leer la imagen
    img = Image.open(filename).convert('RGB')
    img = np.array(img)
    img_gray = np.dot(img[..., :3], [0.299, 0.587, 0.114]).astype(np.uint8)
    height, width = img_gray.shape

    # Obtener los parámetros del formulario
    print(filter_name)
    filter_name = request.form.get('filter', 'laplace')
    kernel_size = int(request.form.get('kernel_size', 3))

    timestamp = datetime.now().strftime('%y%m%d_%H%M')
    # Guardar la imagen procesada
    processed_filename = os.path.join(app.config['UPLOAD_FOLDER'], f'processed_{unique_id}.png')

    save_image(processed_filename, img_gray, width, height)

    # Devolver la imagen procesada al cliente
    return send_from_directory(app.config['UPLOAD_FOLDER'], os.path.basename(processed_filename))


if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)