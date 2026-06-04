
import 'package:flutter/material.dart';

void main() {
  runApp(const BibliotecaApp());
}

class Libro {
  final String titulo;
  final String autor;
  final String categoria;
  final String estado;

  Libro({
    required this.titulo,
    required this.autor,
    required this.categoria,
    required this.estado,
  });
}

final List<Libro> libros = [
  Libro(
    titulo: 'Cien años de soledad',
    autor: 'Gabriel García Márquez',
    categoria: 'Novela',
    estado: 'Disponible',
  ),
  Libro(
    titulo: 'El Principito',
    autor: 'Antoine de Saint-Exupéry',
    categoria: 'Infantil',
    estado: 'Prestado',
  ),
  Libro(
    titulo: 'Don Quijote',
    autor: 'Miguel de Cervantes',
    categoria: 'Clásico',
    estado: 'Disponible',
  ),
];

class BibliotecaApp extends StatelessWidget {
  const BibliotecaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Biblioteca Personal',
      theme: ThemeData(
        colorSchemeSeed: Colors.indigo,
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
            colors: [Colors.indigo, Colors.blue],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.library_books, size: 120, color: Colors.white),
            const SizedBox(height: 20),
            const Text(
              'Biblioteca Personal',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Gestiona tus libros favoritos',
              style: TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const HomeScreen()),
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
      appBar: AppBar(title: const Text('Biblioteca Personal')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ElevatedButton.icon(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ListaLibrosScreen()),
              ),
              icon: const Icon(Icons.book),
              label: const Text('Lista de Libros'),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const FormularioLibroScreen()),
              ),
              icon: const Icon(Icons.add),
              label: const Text('Registrar Libro'),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const NormasScreen()),
              ),
              icon: const Icon(Icons.rule),
              label: const Text('Normas'),
            ),
          ],
        ),
      ),
    );
  }
}

class ListaLibrosScreen extends StatelessWidget {
  const ListaLibrosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Libros')),
      body: ListView.builder(
        itemCount: libros.length,
        itemBuilder: (context, index) {
          final libro = libros[index];
          return Card(
            child: ListTile(
              leading: const Icon(Icons.menu_book),
              title: Text(libro.titulo),
              subtitle: Text('${libro.autor} - ${libro.categoria}'),
              trailing: Text(libro.estado),
            ),
          );
        },
      ),
    );
  }
}

class FormularioLibroScreen extends StatefulWidget {
  const FormularioLibroScreen({super.key});

  @override
  State<FormularioLibroScreen> createState() => _FormularioLibroScreenState();
}

class _FormularioLibroScreenState extends State<FormularioLibroScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registrar Libro')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Título'),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Campo obligatorio' : (v.length < 3 ? 'Mínimo 3 caracteres' : null),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Autor'),
                validator: (v) => v == null || v.isEmpty ? 'Campo obligatorio' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Categoría'),
                validator: (v) => v == null || v.isEmpty ? 'Campo obligatorio' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Año'),
                validator: (v) =>
                    v == null || v.length != 4 ? 'Debe tener 4 dígitos' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Libro registrado correctamente')),
                    );
                  }
                },
                child: const Text('Guardar'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class NormasScreen extends StatelessWidget {
  const NormasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Normas de Préstamo')),
      body: const Padding(
        padding: EdgeInsets.all(20),
        child: Text(
          '• Máximo 2 libros por usuario.\n\n• Tiempo de préstamo: 15 días.\n\n• No rayar ni dañar los libros.\n\n• Entregar puntualmente.',
        ),
      ),
    );
  }
}
