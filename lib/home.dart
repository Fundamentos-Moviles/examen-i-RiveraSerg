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
                            color: Colors.redAccent.withOpacity(0.4), // Color del resplandor
                            spreadRadius: 5, // Extensión del resplandor
                            blurRadius: 15, // Borrosidad del resplandor
                            offset: const Offset(0, 0), // Posición de la sombra
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

                        ///Tipo dinamico o que se adapta al valor que se asigna
                        ///datos = [1, Text1, textN1, 101]
                        var datos = lista[index].toString().split('#'); ///$ -> NO USAR

                        return Column(
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
                            const SizedBox(height: 10), // Ajusta el espacio entre las tarjetas aquí
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
}



///Clase para crear widgets  o creador de widgets sin estado
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
                    style: TextStyle(
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
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Text(
                    '$nombre $apellido',
                    style: TextStyle(
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
                    style: TextStyle(
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

