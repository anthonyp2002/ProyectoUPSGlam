import 'package:apsglam/controller/inicio_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Edit extends StatelessWidget {
  const Edit({super.key});
  @override
  Widget build(BuildContext context) {
    final InicioService service = Get.find<InicioService>();

    return Scaffold(
        backgroundColor: const Color(0xff120C24),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 5),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back_rounded,
                          color: Colors.white30,
                          size: 30,
                        ),
                        onPressed: () {
                          service.imageProcesada.value = "";
                          Get.back();
                        },
                      ),
                    ],
                  ),
                ),
                const Padding(padding: EdgeInsets.only(bottom: 10)),
                Obx(
                  () {
                    return service.imageProcesada.isNotEmpty
                        ? Image.network(
                            service.imageProcesada.value,
                            width: 250,
                          )
                        : Image.file(
                            service.imageSave!,
                            width: 250,
                          );
                  },
                ),
                const Padding(padding: EdgeInsets.only(bottom: 15)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        showFilterOptions(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 63, 183, 169),
                      ),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.settings,
                            size: 20.0,
                            color: Colors.black54,
                          ),
                          Padding(padding: EdgeInsets.only(left: 15)),
                          Text(
                            'Filtros',
                            style: TextStyle(color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(left: 15)),
                    ElevatedButton(
                      onPressed: () {
                        service.imageProcesada.isNotEmpty
                            ? service.subirPost("procesada")
                            : service.subirPost("camara");
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 63, 183, 169),
                      ),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.post_add,
                            size: 20.0,
                            color: Colors.black54,
                          ),
                          Padding(padding: EdgeInsets.only(left: 10)),
                          Text(
                            'Publicar',
                            style: TextStyle(color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 40, right: 40),
                  child: Row(
                    children: [
                      Text(
                        'Descripción',
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 40, right: 40),
                  child: TextField(
                    maxLines: 2,
                    controller: service.descripcionPost,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Escribe aqui..',
                      hintStyle: TextStyle(color: Colors.white),
                      contentPadding: EdgeInsets.all(10.0),
                    ),
                    style: const TextStyle(fontSize: 16.0, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  void showFilterOptions(BuildContext context) {
    final InicioService service = Get.find<InicioService>();

    showModalBottomSheet(
      backgroundColor: const Color.fromARGB(255, 63, 183, 169),
      context: context,
      isScrollControlled: true, 
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(
                    16.0), 
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DropdownButton<String>(
                      value: service.selectedFilter,
                      items: const [
                        DropdownMenuItem(
                            value: 'laplace', child: Text('Laplace')),
                        DropdownMenuItem(
                            value: 'motion_blur', child: Text('Motion Blur')),
                        DropdownMenuItem(
                            value: 'relieve', child: Text('Relieve')),
                        DropdownMenuItem(
                            value: 'Logo', child: Text('logo')),
                        DropdownMenuItem(
                            value: 'Pixelete', child: Text('pixelate_filter')),
                      ],
                      onChanged: (value) {
                        setModalState(() {
                          service.selectedFilter = value!;
                        });
                      },
                      style: const TextStyle(color: Colors.white54,fontSize: 16),
                      dropdownColor: const Color.fromARGB(255, 72, 50, 141),
                    ),
                    if (service.selectedFilter != 'relieve')
                      Slider(
                        value: service.kernelSize,
                        min: 3,
                        max: 11,
                        divisions: 4,
                        label:
                            'Tamaño del Kernel: ${service.kernelSize.toInt()}',
                        onChanged: (value) {
                          setModalState(() {
                            service.kernelSize = value;
                          });
                        },
                        activeColor: const Color.fromARGB(255, 72, 50, 141),
                      ),
                    if (service.selectedFilter == 'relieve')
                      Column(
                        children: [
                          Slider(
                            value: service.kernelSize,
                            min: 3,
                            max: 11,
                            divisions: 4,
                            label:
                                'Tamaño del Kernel: ${service.kernelSize.toInt()}',
                            onChanged: (value) {
                              setModalState(() {
                                service.kernelSize = value;
                              });
                            },
                          ),
                          Slider(
                            value: service.reliefFactor,
                            min: 0.5,
                            max: 5.0,
                            divisions: 10,
                            label:
                                'Factor de Relieve: ${service.reliefFactor.toStringAsFixed(1)}',
                            onChanged: (value) {
                              setModalState(() {
                                service.reliefFactor = value;
                              });
                            },
                          ),
                        ],
                      ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Threads por Bloque',
                          labelStyle: const TextStyle(
                            color:
                                Colors.white54, 
                            fontWeight:
                                FontWeight.bold, 
                          ),

                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(20), 
                            
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color:  Color.fromARGB(255, 72, 50, 141), // Color del borde cuando está en foco
                              width: 2,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:const BorderSide(
                              color:  Color.fromARGB(255, 72, 50, 141), 
                              width: 2,
                            ),
                          ),
                        ),
                        style:const  TextStyle(
                          color: Colors
                              .white54, 
                          fontSize: 16, 
                        ),
                        onChanged: (value) {
                          setModalState(() {
                            service.threadsPerBlock = int.tryParse(value) ?? 16;
                          });
                        },
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(bottom: 25)),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff120C24),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        print(service.selectedFilter);
                        if(service.selectedFilter == 'Logo'){
                          service.baseUrl = 'http://172.16.217.123:5000';
                        }else if(service.selectedFilter == 'Pixelete'){
                          service.baseUrl = 'http://172.16.217.123:5000';
                        }else{
                          service.baseUrl = 'http://172.16.219.153:5000';
                        }
                        print(service.baseUrl);
                        service.applyServerFilter(service.baseUrl);
                      },
                      child: const Text(
                        'Aplicar Filtro',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(bottom: 250)),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
