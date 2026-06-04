import 'package:flutter/material.dart';

void main() {
  runApp(const EventosAcademicosApp());
}

////////////////////////////////////////////////////////////
/// MODELO
////////////////////////////////////////////////////////////

class Evento {
  final String nombre;
  final String fecha;
  final String lugar;
  final String duracion;
  final String tipo;

  Evento({
    required this.nombre,
    required this.fecha,
    required this.lugar,
    required this.duracion,
    required this.tipo,
  });
}

////////////////////////////////////////////////////////////
/// DATOS
////////////////////////////////////////////////////////////

List<Evento> eventos = [
  Evento(
    nombre: 'Hackathon ADSO',
    fecha: '15/06/2026',
    lugar: 'Auditorio Principal',
    duracion: '8 horas',
    tipo: 'Tecnología',
  ),
  Evento(
    nombre: 'Seminario de IA',
    fecha: '20/06/2026',
    lugar: 'Sala TIC',
    duracion: '4 horas',
    tipo: 'Conferencia',
  ),
  Evento(
    nombre: 'Feria de Proyectos',
    fecha: '28/06/2026',
    lugar: 'Centro de Formación',
    duracion: '6 horas',
    tipo: 'Exposición',
  ),
];

////////////////////////////////////////////////////////////
/// APP
////////////////////////////////////////////////////////////

class EventosAcademicosApp extends StatelessWidget {
  const EventosAcademicosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Eventos Académicos',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const HomeScreen(),
    );
  }
}

////////////////////////////////////////////////////////////
/// MENÚ PRINCIPAL
////////////////////////////////////////////////////////////

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade50,
      appBar: AppBar(
        title: const Text('Eventos Académicos'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Icon(
              Icons.event,
              size: 100,
              color: Colors.deepPurple,
            ),

            const SizedBox(height: 20),

            const Text(
              'Gestión de Eventos Académicos',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            ElevatedButton.icon(
              icon: const Icon(Icons.list),
              label: const Text('Ver Eventos'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ListaEventosScreen(),
                  ),
                );
              },
            ),

            const SizedBox(height: 15),

            ElevatedButton.icon(
              icon: const Icon(Icons.app_registration),
              label: const Text('Inscribirse'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const FormularioInscripcionScreen(),
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
/// LISTA DE EVENTOS
////////////////////////////////////////////////////////////

class ListaEventosScreen extends StatelessWidget {
  const ListaEventosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Eventos'),
      ),
      body: ListView.builder(
        itemCount: eventos.length,
        itemBuilder: (context, index) {
          final evento = eventos[index];

          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              leading: const Icon(
                Icons.event_available,
                color: Colors.deepPurple,
              ),
              title: Text(evento.nombre),
              subtitle: Text(
                '${evento.fecha} - ${evento.lugar}',
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        DetalleEventoScreen(evento: evento),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

////////////////////////////////////////////////////////////
/// DETALLE EVENTO
////////////////////////////////////////////////////////////

class DetalleEventoScreen extends StatelessWidget {
  final Evento evento;

  const DetalleEventoScreen({
    super.key,
    required this.evento,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(evento.nombre),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Card(
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  evento.nombre,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                Text('Fecha: ${evento.fecha}'),
                Text('Lugar: ${evento.lugar}'),
                Text('Duración: ${evento.duracion}'),
                Text('Tipo: ${evento.tipo}'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

////////////////////////////////////////////////////////////
/// FORMULARIO INSCRIPCIÓN
////////////////////////////////////////////////////////////

class FormularioInscripcionScreen extends StatefulWidget {
  const FormularioInscripcionScreen({super.key});

  @override
  State<FormularioInscripcionScreen> createState() =>
      _FormularioInscripcionScreenState();
}

class _FormularioInscripcionScreenState
    extends State<FormularioInscripcionScreen> {
  final _formKey = GlobalKey<FormState>();

  final nombreController = TextEditingController();
  final correoController = TextEditingController();
  final documentoController = TextEditingController();
  final programaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulario de Inscripción'),
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
                  labelText: 'Nombre',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Campo obligatorio' : null,
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: correoController,
                decoration: const InputDecoration(
                  labelText: 'Correo',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obligatorio';
                  }

                  if (!value.contains('@') ||
                      !value.contains('.')) {
                    return 'Correo inválido';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: documentoController,
                decoration: const InputDecoration(
                  labelText: 'Documento',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obligatorio';
                  }

                  if (value.length < 6) {
                    return 'Mínimo 6 caracteres';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: programaController,
                decoration: const InputDecoration(
                  labelText: 'Programa de formación',
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
                          'Inscripción realizada correctamente',
                        ),
                      ),
                    );
                  }
                },
                child: const Text('Inscribirse'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}