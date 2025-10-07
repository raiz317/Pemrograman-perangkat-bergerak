import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
 const MyApp({super.key});
 @override
 Widget build(BuildContext context) {
   return MaterialApp(
     title: 'Form Mahasiswa',
     theme: ThemeData(
       useMaterial3: true,
       colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
     ),
     home: const FormMahasiswaPage(),
   );
 }
}

class FormMahasiswaPage extends

StatefulWidget {
 const FormMahasiswaPage({super.key});
 @override
 State<FormMahasiswaPage> createState() => _FormMahasiswaPageState();
}

class _FormMahasiswaPageState extends State<FormMahasiswaPage> {
 final _formKey = GlobalKey<FormState>();
 int _currentStep = 0; 

 final cNama = TextEditingController();
 final cNpm  = TextEditingController();
 final cEmail = TextEditingController();
 final cAlamat = TextEditingController();
 DateTime? tglLahir;
 TimeOfDay? jamBimbingan;

 String get tglLahirLabel =>
     tglLahir == null ? 'Pilih tanggal' : '${tglLahir!.day}/${tglLahir!.month}/${tglLahir!.year}';
 String get jamLabel =>
     jamBimbingan == null ? 'Pilih jam' : jamBimbingan!.format(context);
@override
 void dispose() {
   cNama.dispose();
   cNpm.dispose();
   cEmail.dispose();
   cAlamat.dispose();
   super.dispose();
 }

Future<void> _pickDate() async {
   final now = DateTime.now();
   final res = await showDatePicker(
     context: context,
     firstDate: DateTime(1970),
     lastDate: DateTime(now.year + 1),
     initialDate: DateTime(now.year - 18, now.month, now.day),
   );
   if (res != null) setState(() => tglLahir = res);
 }

 Future<void> _pickTime() async {
   final res = await showTimePicker(
     context: context,
     initialTime: const TimeOfDay(hour: 9, minute: 0),
   );
   if (res != null) setState(() => jamBimbingan = res);
 }

void _simpan() {
   if (!_formKey.currentState!.validate()) {
     ScaffoldMessenger.of(context).showSnackBar(
       const SnackBar(content: Text('Periksa kembali isian Anda.')),
     );
     return;
   }
   if (tglLahir == null) {
     ScaffoldMessenger.of(context).showSnackBar(
       const SnackBar(content: Text('Tanggal lahir belum dipilih')),
     );
     return;
   }
   if (jamBimbingan == null) {
     ScaffoldMessenger.of(context).showSnackBar(
       const SnackBar(content: Text('Jam bimbingan belum dipilih')),
     );
     return;
   }

   final data = {
     'Nama': cNama.text.trim(),
     'Npm': cNpm.text.trim(),
     'Email': cEmail.text.trim(),
     'Alamat': cAlamat.text.trim(),
     'TglLahir': tglLahirLabel,
     'JamBimbingan': jamLabel,
   };

   showDialog(
     context: context,
     builder: (_) => AlertDialog(
       title: const Text('Ringkasan Data (Bagian 1)'),
       content: SingleChildScrollView(
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: data.entries
               .map((e) => Padding(
                     padding: const EdgeInsets.only(bottom: 8),
                     child: Text('${e.key}: ${e.value}'),
                   ))
               .toList(),
         ),
       ),
       actions: [
         TextButton(onPressed: () => Navigator.pop(context), child: const Text('Tutup')),
       ],
     ),
   );
 }

Widget _sectionTitle(String text) => Padding(
       padding: const EdgeInsets.only(bottom: 8, top: 8),
       child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
     );
@override
 Widget build(BuildContext context) {
   final steps = <Step>[
     Step(
       title: const Text('Identitas'),
       isActive: true,
       state: StepState.indexed,
       content: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           _sectionTitle('Data Pribadi'),
           TextFormField(
             controller: cNama,
             decoration: const InputDecoration(
               labelText: 'Nama Lengkap',
               hintText: 'cth: Budi Santoso',
               border: OutlineInputBorder(),
               prefixIcon: Icon(Icons.person),
             ),
             validator: (v) => (v == null || v.trim().isEmpty) ? 'Nama wajib diisi' : null,
           ),
           const SizedBox(height: 10),
           TextFormField(
             controller: cNpm,
             keyboardType: TextInputType.number,
             decoration: const InputDecoration(
               labelText: 'NPM',
               hintText: 'cth: 221234567',
               border: OutlineInputBorder(),
               prefixIcon: Icon(Icons.badge),
             ),
             validator: (v) => (v == null || v.trim().isEmpty) ? 'NPM wajib diisi' : null,
           ),
           const SizedBox(height: 10),
           TextFormField(
             controller: cEmail,
             keyboardType: TextInputType.emailAddress,
             decoration: const InputDecoration(
               labelText: 'Email',
               hintText: 'cth: nama@kampus.ac.id',
               border: OutlineInputBorder(),
               prefixIcon: Icon(Icons.email),
             ),
             validator: (v) {
               if (v == null || v.trim().isEmpty) return 'Email wajib diisi';
               final ok = RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(v.trim());
               return ok ? null : 'Format email tidak valid';
             },
           ),
           const SizedBox(height: 10),
           TextFormField(
             controller: cAlamat,
             decoration: const InputDecoration(
               labelText: 'Alamat',
               border: OutlineInputBorder(),
               prefixIcon: Icon(Icons.home),
             ),
           ),
           const SizedBox(height: 10),
           Row(
             children: [
               Expanded(
                 child: OutlinedButton.icon(
                   icon: const Icon(Icons.calendar_month),
                   label: Text(tglLahirLabel),
                   onPressed: _pickDate,
                 ),
               ),
               const SizedBox(width: 10),
               Expanded(
                 child: OutlinedButton.icon(
                   icon: const Icon(Icons.schedule),
                   label: Text(jamLabel),
                   onPressed: _pickTime,
                 ),
               ),
             ],
           ),
         ],
       ),
     ),
   ];


   return Scaffold(
     appBar: AppBar(title: const Text('Form Mahasiswa — Bagian 1')),
     body: Form(
       key: _formKey,
       child: Stepper(
         type: StepperType.vertical,
         currentStep: _currentStep, 
         steps: steps,
         onStepContinue: _simpan,   
         onStepCancel: null,      
         controlsBuilder: (context, details) {
           return Row(
             children: [
               ElevatedButton.icon(
                 icon: const Icon(Icons.check),
                 label: const Text('Simpan'),
                 onPressed: details.onStepContinue,
               ),
             ],
           );
         },
       ),
     ),
   );
 }
}



// class FormMahasiswaPage extends StatelessWidget {
//   const FormMahasiswaPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Form Mahasiswa')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: const [
//             TextField(
//               decoration: InputDecoration(
//                 labelText: 'Nama',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 16),
//             TextField(
//               decoration: InputDecoration(
//                 labelText: 'NIM',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }