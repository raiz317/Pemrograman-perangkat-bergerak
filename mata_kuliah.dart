import 'package:flutter/material.dart';

class FormMatkulPage extends StatefulWidget {
  const FormMatkulPage({super.key});

  @override
  State<FormMatkulPage> createState() => _FormMatkulPageState();
}

class _FormMatkulPageState extends State<FormMatkulPage> {
  final _formKey = GlobalKey<FormState>();

  final _kodeController = TextEditingController();
  final _namaController = TextEditingController();
  final _sksController = TextEditingController();

  void _showOutputDialog() {
    final output = """
Kode Mata Kuliah: ${_kodeController.text}
Nama Mata Kuliah: ${_namaController.text}
SKS: ${_sksController.text}
""";

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Data Mata Kuliah"),
        content: Text(output),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Tutup"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Form Mata Kuliah")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _kodeController,
                decoration: const InputDecoration(
                  labelText: "Kode Mata Kuliah",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _namaController,
                decoration: const InputDecoration(
                  labelText: "Nama Mata Kuliah",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _sksController,
                decoration: const InputDecoration(
                  labelText: "SKS",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _showOutputDialog,
                child: const Text("Simpan"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
