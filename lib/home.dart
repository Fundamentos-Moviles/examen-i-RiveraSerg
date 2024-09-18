import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:examen1_rrsa/utils/constantes.dart' as con;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late List lista;


  @override
  void initState(){
    lista = List.from(con.listaExamen);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: con.fondo2,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 15.0),
                Align(
                  child: Container(
                      height: 50,
                      width: 450,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.redAccent.withOpacity(0.4),
                            spreadRadius: 5,
                            blurRadius: 15, 
                            offset: const Offset(0, 0),
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Text(
                          'Calendario de cumpleaños',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w600,
                            color: con.titulos,
                          ),
                        ),
                      )
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: size.height, ///100%
                  width: size.width, ///100%
                    child:
                    ListView.builder(
                      padding: const EdgeInsets.all(18),
                      itemCount: lista.length,
                      itemBuilder: (BuildContext context, int index){
                        ///Area de construcción NO PASAR

                        var datos = lista[index].toString().split('#'); ///$ -> NO USAR

                        return (int.parse(datos[0]) % 2 == 0) ? Column(
                          children: [
                            createdCard(
                                edad: datos[1],
                                dia: datos[2],
                                mes: datos[3],
                                nombre: datos[4],
                                apellido: datos[5],
                                descripcion: datos[6],
                                num: datos[7],
                                id: datos[0],
                                context: context,
                              ),
                              const SizedBox(height: 10),
                          ],
                        ) :  Column(
                              children: [
                                createdCard2(
                                datos[1],
                                datos[2],
                                datos[3],
                                datos[4],
                                datos[5],
                                datos[6],
                                datos[7],
                                datos[0],
                                  index
                            ),
                            const SizedBox(height: 10),
                          ],
                        );
                      }
                    ),
                ),
                const SizedBox(height: 5),
                Align(
                  child: Container(
                      height: 20,
                      width: 450,
                      decoration: const BoxDecoration(
                        color: con.fondo2,
                      ),
                      child: const Center(
                        child: Text(
                          'SEGUNDA VISTA: Rivera Rosales Sergio Alexander',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: con.titulos,
                          ),
                        ),
                      )
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ],
      ),
    );
  }
  InkWell createdCard2(String edad, String dia, String mes, String nombre,
      String apellido, String descripcion, String num, String id, int index) {
    return InkWell(
      onTap: () {
        showSnackBar(
            'ID: $id '
                '\nFecha de nacimiento: $dia de $mes'
                '\nNombre completo: $nombre $apellido'
                '\nNo. Estrellas: $num',
            10,
        );
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 10, // 80%
                        child: Text(
                          '$dia - $mes',
                          style: const TextStyle(
                            fontSize: 28,
                            color: con.fondo,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1, // 10%
                        child: Icon(
                          (id == '10' || id == '15') ? Icons.add_alert_rounded : Icons.edit,
                          color: (id == '10' || id == '15') ? Colors.amber : Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Text(
                          '$nombre $apellido',
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Text(
                          descripcion,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: List.generate(5, (index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 1.0),
                      child: Icon(
                        Icons.star,
                        color: index < int.parse(num) ? Colors.amber : Colors.grey,
                      ),
                    )),
                  )
                ],
              ),
            ),
          ),

          const SizedBox(width: 10),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(top: 45.0),
              child: Center(
                child: Container(
                  width: 150,
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (![10, 15, 20].contains(int.parse(id))) {
                          setState(() {
                            lista.removeAt(index);
                            showSnackBar('Se eliminó el elemento $id', 15);
                            if (kDebugMode) {
                              print("Fue presionado el botón de eliminar id: $id");
                            }
                          });
                        } else {
                          showSnackBar('No se puede eliminar el elemento con ID: $id', 15);
                          if (kDebugMode) {
                            print("Intento de eliminar elemento con ID prohibido: $id");
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.delete, color: Colors.white),
                          SizedBox(width: 1),
                          Text(
                            'Borrar',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  void showSnackBar(String texto, int duracion){
    final snack = SnackBar(
      content: Text(texto),
      duration: Duration(seconds: duracion),
      action: SnackBarAction(
        onPressed: () {
          //Cualquier acción al dar clic sobre el widget
        },
        label: 'Cerrar',
      ),
    );

    ///Muestra el mensaje en pantalla
    ScaffoldMessenger.of(context).showSnackBar(snack);
  }
}

class createdCard extends StatelessWidget {
  final String dia;
  final String num;
  final String mes;
  final String edad;
  final String nombre;
  final String apellido;
  final String descripcion;
  final String id;
  final BuildContext context;
  const createdCard({
    super.key, required this.dia, required this.mes,
    required this.edad, required this.id, required this.nombre,
    required this.apellido, required this.descripcion,
    required this.context, required this.num
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showSnackBar(
            'ID: $id '
                '\nFecha de nacimiento: $dia de $mes'
                '\nNombre completo: $nombre $apellido'
                '\nNo. Estrellas: $num',
            10
        );
      },
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 10, // 80%
                  child: Text(
                    '$dia - $mes',
                    style: const TextStyle(
                      fontSize: 28,
                      color: con.fondo,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1, // 10%
                  child: Icon(
                    (id == '10' || id == '15') ? Icons.add_alert_rounded : Icons.edit, // Cambia el ícono si id es 10 o 15
                    color: (id == '10' || id == '15') ? Colors.amber : Colors.black, // Cambia el color si id es 10 o 15
                  ),
                ),

              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Text(
                    '$nombre $apellido',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Text(
                    descripcion,
                    style: const TextStyle(
                        color: Colors.grey
                    ),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: List.generate(5, (index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 1.0), // Espacio entre los íconos
                child: Icon(
                  Icons.star,
                  color: index < int.parse(num) ? Colors.amber : Colors.grey, // Cambia el color según el índice
                ),
              )),
            )

          ],
        ),
      ),
    );
  }
  ///AREA PARA LAS FUNCIONES
  void showSnackBar(String texto, int duracion){
    final snack = SnackBar(
      content: Text(texto),
      duration: Duration(seconds: duracion),
      action: SnackBarAction(
        onPressed: () {
          //Cualquier acción al dar clic sobre el widget
        },
        label: 'Cerrar',
      ),
    );

    ///Muestra el mensaje en pantalla
    ScaffoldMessenger.of(context).showSnackBar(snack);
  }
}



