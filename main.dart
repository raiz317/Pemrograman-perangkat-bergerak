import 'package:flutter/material.dart';
import 'form_mahasiswa.dart';
import 'daftar_mahasiswa.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Menu Drawer',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: const MainWithDrawer(),
      routes: {
        '/form': (_) => const FormMahasiswaPage(),
        '/list': (_) => const DaftarMahasiswaPage(),
      },
    );
  }
}

class MainWithDrawer extends StatelessWidget {
  const MainWithDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Menu Utama (Drawer)')),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text('Demo Form Mahasiswa'),
              accountEmail: Text('v1.0.0'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person_add),
              title: const Text('Form Mahasiswa'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/form');
              },
            ),
            ListTile(
              leading: const Icon(Icons.list_alt),
              title: const Text('Daftar Mahasiswa'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/list');
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('Tentang Aplikasi'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/tentang');
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Pengaturan'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/pengaturan');
              },
            ),
          ],
        ),
      ),
      body: const _HomeContent(),
    );
  }
}

class _HomeContent extends StatelessWidget {
  const _HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(24),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.menu, size: 48),
              SizedBox(height: 12),
              Text('Tap ikon ☰ atau geser dari kiri untuk membuka Drawer.'),
            ],
          ),
        ),
      ),
    );
  }
}