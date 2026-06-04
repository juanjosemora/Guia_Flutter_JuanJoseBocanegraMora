import 'package:flutter/material.dart';

void main() {
  runApp(const AsistenciaApp());
}

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

final List<Aprendiz> aprendices = [
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
];

class AsistenciaApp extends StatelessWidget {
  const AsistenciaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Control de Asistencia',
      theme: ThemeData(
        colorSchemeSeed: Colors.green,
        useMaterial3: true,
      ),
      home: const BienvenidaScreen(),
    );
  }
}

class BienvenidaScreen extends StatelessWidget {
  const BienvenidaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green, Colors.teal],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.fact_check,
              size: 120,
              color: Colors.white,
            ),
            const SizedBox(height: 20),
            const Text(
              'Control de Asistencia',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const HomeScreen(),
                  ),
                );
              },
              child: const Text('Ingresar'),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Control de Asistencia'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ListaAprendicesScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.people),
              label: const Text('Lista de Aprendices'),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const FormularioScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.edit),
              label: const Text('Reportar Novedad'),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ResumenScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.bar_chart),
              label: const Text('Resumen Visual'),
            ),
          ],
        ),
      ),
    );
  }
}

class ListaAprendicesScreen extends StatelessWidget {
  const ListaAprendicesScreen({super.key});

  Color obtenerColor(String estado) {
    if (estado == 'Asistió') return Colors.green;
    if (estado == 'Llegó tarde') return Colors.orange;
    return Colors.red;
  }

  IconData obtenerIcono(String estado) {
    if (estado == 'Asistió') return Icons.check_circle;
    if (estado == 'Llegó tarde') return Icons.access_time;
    return Icons.cancel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aprendices'),
      ),
      body: ListView.builder(
        itemCount: aprendices.length,
        itemBuilder: (context, index) {
          final aprendiz = aprendices[index];

          return Card(
            child: ListTile(
              leading: Icon(
                obtenerIcono(aprendiz.estado),
                color: obtenerColor(aprendiz.estado),
              ),
              title: Text(aprendiz.nombre),
              subtitle: Text('Ficha: ${aprendiz.ficha}'),
              trailing: Text(aprendiz.estado),
            ),
          );
        },
      ),
    );
  }
}

class FormularioScreen extends StatefulWidget {
  const FormularioScreen({super.key});

  @override
  State<FormularioScreen> createState() => _FormularioScreenState();
}

class _FormularioScreenState extends State<FormularioScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reportar Novedad'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Nombre del aprendiz',
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Campo obligatorio' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Fecha',
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Fecha obligatoria' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Motivo',
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
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Instructor',
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Campo obligatorio' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Novedad registrada'),
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
              child: ListTile(
                leading: const Icon(Icons.check_circle),
                title: Text('Asistieron: $asistieron'),
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.access_time),
                title: Text('Llegaron tarde: $tarde'),
              ),
            ),
            Card(
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