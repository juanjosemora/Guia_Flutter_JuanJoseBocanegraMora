import 'package:flutter/material.dart';

void main() {
  runApp(const ControlAsistenciaApp());
}

////////////////////////////////////////////////////////////
/// MODELO
////////////////////////////////////////////////////////////

class Aprendiz {
  final String nombre;
  final String ficha;
  final String estado;

  Aprendiz({
    required this.nombre,
    required this.ficha,
    required this.estado,
  });
}

////////////////////////////////////////////////////////////
/// DATOS
////////////////////////////////////////////////////////////

List<Aprendiz> aprendices = [
  Aprendiz(
    nombre: 'Juan José Bocanegra',
    ficha: '2873711',
    estado: 'Asistió',
  ),
  Aprendiz(
    nombre: 'María Gómez',
    ficha: '2873711',
    estado: 'Llegó tarde',
  ),
  Aprendiz(
    nombre: 'Carlos Rodríguez',
    ficha: '2873711',
    estado: 'No asistió',
  ),
  Aprendiz(
    nombre: 'Laura Martínez',
    ficha: '2873711',
    estado: 'Asistió',
  ),
];

////////////////////////////////////////////////////////////
/// APP
////////////////////////////////////////////////////////////

class ControlAsistenciaApp extends StatelessWidget {
  const ControlAsistenciaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Control de Asistencia',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const HomeScreen(),
    );
  }
}

////////////////////////////////////////////////////////////
/// INICIO
////////////////////////////////////////////////////////////

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      appBar: AppBar(
        title: const Text('Control de Asistencia'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Icon(
              Icons.fact_check,
              size: 100,
            ),

            const SizedBox(height: 20),

            const Text(
              'Gestión de Asistencia',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            ElevatedButton.icon(
              icon: const Icon(Icons.people),
              label: const Text('Ver Aprendices'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ListaAprendicesScreen(),
                  ),
                );
              },
            ),

            const SizedBox(height: 15),

            ElevatedButton.icon(
              icon: const Icon(Icons.edit_document),
              label: const Text('Reportar Novedad'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const FormularioNovedadScreen(),
                  ),
                );
              },
            ),

            const SizedBox(height: 15),

            ElevatedButton.icon(
              icon: const Icon(Icons.analytics),
              label: const Text('Resumen Visual'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ResumenScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

////////////////////////////////////////////////////////////
/// LISTA APRENDICES
////////////////////////////////////////////////////////////

class ListaAprendicesScreen extends StatelessWidget {
  const ListaAprendicesScreen({super.key});

  Color obtenerColor(String estado) {
    switch (estado) {
      case 'Asistió':
        return Colors.green;
      case 'Llegó tarde':
        return Colors.orange;
      default:
        return Colors.red;
    }
  }

  IconData obtenerIcono(String estado) {
    switch (estado) {
      case 'Asistió':
        return Icons.check_circle;
      case 'Llegó tarde':
        return Icons.access_time;
      default:
        return Icons.cancel;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Aprendices'),
      ),
      body: ListView.builder(
        itemCount: aprendices.length,
        itemBuilder: (context, index) {
          final aprendiz = aprendices[index];

          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              leading: Icon(
                obtenerIcono(aprendiz.estado),
                color: obtenerColor(aprendiz.estado),
              ),
              title: Text(aprendiz.nombre),
              subtitle: Text(
                'Ficha: ${aprendiz.ficha}',
              ),
              trailing: Text(
                aprendiz.estado,
                style: TextStyle(
                  color: obtenerColor(aprendiz.estado),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

////////////////////////////////////////////////////////////
/// FORMULARIO
////////////////////////////////////////////////////////////

class FormularioNovedadScreen extends StatefulWidget {
  const FormularioNovedadScreen({super.key});

  @override
  State<FormularioNovedadScreen> createState() =>
      _FormularioNovedadScreenState();
}

class _FormularioNovedadScreenState
    extends State<FormularioNovedadScreen> {
  final _formKey = GlobalKey<FormState>();

  final nombreController = TextEditingController();
  final fechaController = TextEditingController();
  final motivoController = TextEditingController();
  final instructorController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reportar Novedad'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nombreController,
                decoration: const InputDecoration(
                  labelText: 'Nombre del aprendiz',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Campo obligatorio' : null,
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: fechaController,
                decoration: const InputDecoration(
                  labelText: 'Fecha',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Fecha obligatoria' : null,
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: motivoController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Motivo',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obligatorio';
                  }

                  if (value.length < 10) {
                    return 'Mínimo 10 caracteres';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: instructorController,
                decoration: const InputDecoration(
                  labelText: 'Instructor que reporta',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Campo obligatorio' : null,
              ),

              const SizedBox(height: 25),

              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Novedad registrada correctamente',
                        ),
                      ),
                    );
                  }
                },
                child: const Text('Guardar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

////////////////////////////////////////////////////////////
/// RESUMEN VISUAL
////////////////////////////////////////////////////////////

class ResumenScreen extends StatelessWidget {
  const ResumenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    int asistieron =
        aprendices.where((a) => a.estado == 'Asistió').length;

    int tarde =
        aprendices.where((a) => a.estado == 'Llegó tarde').length;

    int ausentes =
        aprendices.where((a) => a.estado == 'No asistió').length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Resumen Visual'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Card(
              color: Colors.green.shade100,
              child: ListTile(
                leading: const Icon(Icons.check_circle),
                title: Text('Asistieron: $asistieron'),
              ),
            ),

            Card(
              color: Colors.orange.shade100,
              child: ListTile(
                leading: const Icon(Icons.access_time),
                title: Text('Llegaron tarde: $tarde'),
              ),
            ),

            Card(
              color: Colors.red.shade100,
              child: ListTile(
                leading: const Icon(Icons.cancel),
                title: Text('No asistieron: $ausentes'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}