import 'package:http/http.dart' as http;

class ImageProcessor {
  // Método para enviar la imagen al servidor y recibir la imagen procesada
  Future<String> processImage(
    String imagePath,
    String filter, {
    int kernelSize = 3,
    double reliefFactor = 2.0,
    int threadsPerBlock = 16,
  }) async {
    final uri = Uri.parse('http://172.16.213.231:5000/process');
    final request = http.MultipartRequest('POST', uri);

    // Adjuntar la imagen
    request.files.add(await http.MultipartFile.fromPath('image', imagePath));

    // Adjuntar los parámetros del filtro
    request.fields['filter'] = filter;
    request.fields['kernel_size'] = kernelSize.toString();
    request.fields['threads'] = threadsPerBlock.toString();

    // Solo para el filtro de relieve
    if (filter == 'relieve') {
      request.fields['factor'] = reliefFactor.toString();
    }

    final response = await request.send();

    if (response.statusCode == 200) {
      final responseData = await response.stream.bytesToString();
      return 'http://172.16.213.231:5000/images/$responseData';
    } else {
      throw Exception('Error al procesar la imagen: ${response.reasonPhrase}');
    }
  }
}
