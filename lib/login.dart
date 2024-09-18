import 'package:flutter/material.dart';
import 'package:examen1_rrsa/utils/constantes.dart' as con;
import 'package:examen1_rrsa/home.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController user = TextEditingController();
  TextEditingController pass = TextEditingController();
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    List<Color> baseColors = [
      con.fondo,
      con.fondo2,
      con.fondo3,
      con.fondo4
    ];

    List<List<Color>> colorPatterns = [
      baseColors,
      [baseColors[3], baseColors[0], baseColors[1], baseColors[2]],
      [baseColors[2], baseColors[3], baseColors[0], baseColors[1]],
      [baseColors[1], baseColors[2], baseColors[3], baseColors[0]],
    ];
    return Scaffold(
      backgroundColor: con.fondo2,
      body: Stack(
        children: [
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 6,
            itemBuilder: (BuildContext context, int index) {
              List<Color> rowColors = colorPatterns[index % colorPatterns.length];
              return ContainerFondo(size: size, rowColors: rowColors);
            },
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(50.0),
              child: Container(
                height: 400,
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.black54,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 20.0),
                      const Text(
                        'Bienvenido a tu primer EXAMEN',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: con.titulos
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Ingresa tu correo electronico',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      TextFormField(
                        controller: user,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                              width: 1,
                              style: BorderStyle.none,
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Correo',
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Ingresa tu contraseña',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      TextFormField(
                        controller: pass,
                        obscureText: true, // Ocultar contraseña
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                              width: 1,
                              style: BorderStyle.none,
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Contraseña',
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      if (errorMessage.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: Text(
                            errorMessage,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                      const SizedBox(height: 10.0),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: con.botones,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          fixedSize: const Size(300, 40),
                        ),
                        onPressed: () {
                          setState(() {
                            if (user.text.isEmpty || pass.text.isEmpty) {
                              errorMessage = 'Datos incompletos';
                            } else if (user.text != "test@correo.mx" && pass.text != "FDM2") {
                              errorMessage = 'Usuario y/o contraseña incorrectos';
                            } else if (user.text != "test@correo.mx") {
                              errorMessage = 'El correo es incorrecto';
                            } else if (pass.text != "FDM2") {
                              errorMessage = 'La contraseña es incorrecta';
                            } else {
                              errorMessage = '';
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const Home()),
                              );
                            }
                          });
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Iniciar Sesión',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      const Text(
                        'Mi primer examen, ¿estará sencillo?',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ContainerFondo extends StatelessWidget {
  const ContainerFondo({
    super.key,
    required this.size,
    required this.rowColors,
  });

  final Size size;
  final List<Color> rowColors;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height / 6,
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(0),
              decoration: BoxDecoration(
                color: rowColors[0], // Primer color de la fila
                borderRadius: BorderRadius.circular(45), // Círculo
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(0),
              decoration: BoxDecoration(
                color: rowColors[1], // Segundo color de la fila
                borderRadius: BorderRadius.circular(45), // Círculo
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(0),
              decoration: BoxDecoration(
                color: rowColors[2], // Tercer color de la fila
                borderRadius: BorderRadius.circular(45), // Círculo
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(0),
              decoration: BoxDecoration(
                color: rowColors[3], // Cuarto color de la fila
                borderRadius: BorderRadius.circular(45), // Círculo
              ),
            ),
          ),
        ],
      ),
    );
  }
}
