import 'package:apsglam/controller/inicio_service.dart';
import 'package:apsglam/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

class HomeInicio extends StatelessWidget {
  const HomeInicio({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 130,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [Historylist()],
              ),
            ),
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Contenidopage(),
          ),
        ],
      ),
    );
  }
}

class Historylist extends StatelessWidget {
  final InicioService service = Get.find<InicioService>();

  Historylist({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 18, left: 10),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 70.0,
                      height: 70.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color.fromARGB(255, 63, 183, 169),
                          width: 3,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: SizedBox(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: const Image(
                              image: NetworkImage(
                                'https://w7.pngwing.com/pngs/733/160/png-transparent-computer-icons-upload-youtube-icon-upload-miscellaneous-photography-sign-thumbnail.png',
                              ),
                              fit: BoxFit
                                  .cover, // La imagen ocupa todo el espacio disponible
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                        radius: 12.0,
                        backgroundColor:
                            Colors.white, // Fondo blanco para resaltar el ícono
                        child: Icon(
                          Icons.add, // Ícono de agregar
                          size: 20.0, // Tamaño del ícono
                          color: Color.fromARGB(
                              255, 63, 183, 169), // Color del ícono
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "  Historias",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: service.stories.map((story) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 70.0,
                            height: 70.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color:
                                      const Color.fromARGB(255, 63, 183, 169),
                                  width: 3),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: SizedBox(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image(
                                    image: NetworkImage(story['imageUrl']!),
                                    fit: BoxFit
                                        .cover, // La imagen ocupa todo el espacio disponible
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            story['name']!,
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          )
        ],
      );
    });
  }
}

class Contenidopage extends StatelessWidget {
  final InicioService service = Get.find<InicioService>();

  Contenidopage({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        children: [
          SizedBox(
            height: 500,
            child: ListView.builder(
              itemCount: service.contenidoPage.length,
              itemBuilder: (context, index) {
                final item = service.contenidoPage[index];
                return Column(children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 30, left: 5, right: 5),
                    child: GestureDetector(
                      onTap: () {
                        showFilterOptions(
                            context, item.comentarios, item.imgUrl);
                      },
                      child: Container(
                        height: 450,
                        decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10, left: 20),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(item.profileImgUrl),
                                  ),
                                  const Padding(
                                      padding: EdgeInsets.only(left: 10)),
                                  Text(item.name)
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 10),
                              child: SizedBox(
                                width: double.infinity,
                                height: 275,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image(
                                    image: NetworkImage(item.imgUrl),
                                    fit: BoxFit
                                        .cover, // La imagen ocupa todo el espacio disponible
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: () async {
                                      await editLikesByImgUrl(
                                          item.imgUrl, item.likes + 1);
                                      service.refreshData();
                                    },
                                    icon: Icon(
                                      item.likes > 0
                                          ? LineIcons.heart
                                          : LineIcons.heartBroken, 
                                      
                                      color: item.likes > 0
                                          ? Colors.red
                                          : Colors
                                              .grey, 
                                    ),
                                  ),
                                  Text(
                                    item.likes.toString(),
                                    style: const TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        showFilterOptions(context,
                                            item.comentarios, item.imgUrl);
                                      },
                                      icon: const Icon(LineIcons.comment)),
                                  Text(
                                    item.comentarios.length.toString(),
                                    style: const TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      item.descripcion,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      softWrap: true,
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ]);
              },
            ),
          ),
        ],
      );
    });
  }

  void showFilterOptions(
      BuildContext context, List<String> comentarios, String imgUrl) {
    final InicioService service = Get.find<InicioService>();

    showModalBottomSheet(
      backgroundColor: Colors.black,
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Comentarios",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    SizedBox(
                      height: 140,
                      child: ListView.builder(
                        itemCount: comentarios.length,
                        itemBuilder: (context, index) {
                          final item = comentarios[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Container(
                              alignment: Alignment.center,
                              width: 100,
                              height: 45,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                item.toString(),
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    TextField(
                      controller: service.newComentario,
                      decoration: InputDecoration(
                        labelText: 'Comenta..',
                        labelStyle: const TextStyle(
                          color: Colors.white54,
                          fontWeight: FontWeight.bold,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Color.fromARGB(255, 72, 50, 141),
                            width: 2,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Color.fromARGB(255, 72, 50, 141),
                            width: 2,
                          ),
                        ),
                      ),
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 16,
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 10)),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 72, 50, 141),
                      ),
                      onPressed: () {
                        comentarios.add(service.newComentario.text);
                        editCommentsByImgUrl(context, imgUrl, comentarios);
                        service.newComentario.text = "";
                        service.refreshData();
                      },
                      child: const Text(
                        'Guardar Comentario',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(bottom: 220))
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
