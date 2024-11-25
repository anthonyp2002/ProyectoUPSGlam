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
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.filter),
                      onPressed: () {
                        showFilterOptions(context);
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.publish),
                      onPressed: () {
                         service.imageProcesada.isNotEmpty
                    ? service.subirPost("procesada") : service.subirPost("camara");
                      },
                    ),
                  ],
                ),
                const Padding(padding: EdgeInsets.only(bottom: 50)),
                Obx(() {
                  return service.imageProcesada.isNotEmpty
                    ? Image.network(
                        service.imageProcesada.value,
                        width: 250,
                      )
                    :                 Image.file(
                  service.imageSave!,
                  width: 250,
                );
                },)
                
              ],
            ),
          ),
        ));
  }

  void showFilterOptions(BuildContext context) {
    final InicioService service = Get.find<InicioService>();

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButton<String>(
                  value: service.selectedFilter,
                  items: const [
                    DropdownMenuItem(value: 'laplace', child: Text('Laplace')),
                    DropdownMenuItem(
                        value: 'motion_blur', child: Text('Motion Blur')),
                    DropdownMenuItem(value: 'relieve', child: Text('Relieve')),
                  ],
                  onChanged: (value) {
                    setModalState(() {
                      service.selectedFilter = value!;
                    });
                  },
                ),
                if (service.selectedFilter != 'relieve')
                  Slider(
                    value: service.kernelSize,
                    min: 3,
                    max: 11,
                    divisions: 4,
                    label: 'Tamaño del Kernel: ${service.kernelSize.toInt()}',
                    onChanged: (value) {
                      setModalState(() {
                        service.kernelSize = value;
                      });
                    },
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
                TextField(
                  keyboardType: TextInputType.number,
                  decoration:
                      const InputDecoration(labelText: 'Threads por Bloque'),
                  onChanged: (value) {
                    setModalState(() {
                      service.threadsPerBlock = int.tryParse(value) ?? 16;
                    });
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    service.applyServerFilter();
                  },
                  child: const Text('Aplicar Filtro'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
