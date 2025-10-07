import 'package:flutter/material.dart';

class FormDosenPage extends StatefulWidget {
  const FormDosenPage({super.key});

  @override
  State<FormDosenPage> createState() => _FormDosenPageState();
}

class _FormDosenPageState extends State<FormDosenPage> {
  final _formKey = GlobalKey<FormState>();

  final Map<String, TextEditingController> _controllers = {
    "NIDN": TextEditingController(),
    "Nama Dosen": TextEditingController(),
    "Home Base": TextEditingController(),
    "Email": TextEditingController(),
    "No. Telp": TextEditingController(),
  };

  void _showOutputDialog() {
    final output = _controllers.entries
        .map((e) => "${e.key}: ${e.value.text}")
        .join("\n");

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Data Dosen"),
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
      appBar: AppBar(title: const Text("Form Dosen")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              for (var entry in _controllers.entries) ...[
                TextFormField(
                  controller: entry.value,
                  decoration: InputDecoration(
                    labelText: entry.key,
                    border: const OutlineInputBorder(),
                  ),
                  keyboardType: entry.key == "No. Telp"
                      ? TextInputType.phone
                      : TextInputType.text,
                ),
                const SizedBox(height: 12),
              ],
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
