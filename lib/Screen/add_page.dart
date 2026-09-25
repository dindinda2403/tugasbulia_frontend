
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_dinda/models/product.dart';
import 'package:flutter_project_dinda/services/api.service.dart';
import 'package:image_picker/image_picker.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final _formKey = GlobalKey<FormState>();

  final namaController = TextEditingController();
  final hargaController = TextEditingController();
  final stokController = TextEditingController();
  final deskripsiController = TextEditingController();
  final ApiService api = ApiService();

  bool loading = false;
  File? image;
  Uint8List? imageBytes;
  final picker = ImagePicker();

  Future<void> pilihGambar() async {
    final XFile? picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      final bytes = await picked.readAsBytes();
      setState(() {
        imageBytes = bytes;
        if (!kIsWeb) {
          image = File(picked.path); // Hanya dijalankan jika bukan di Web
        }
      });
    }
  }

  Future<void> simpanData() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      loading = true;
    });

    final product = Product(
      nama: namaController.text,
      harga: int.parse(hargaController.text),
      stok: int.parse(stokController.text),
      deskripsi: deskripsiController.text,
    );

    // BISA DIUBAH MENJADI: (mengirim imageBytes untuk web / image untuk mobile)
    bool berhasil = await api.storeProduct(
      product, 
      kIsWeb ? null : image, 
      imageBytes: imageBytes,
    );

    setState(() {
      loading = false;
    });

    if (!mounted) return;

    if (berhasil) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Produk berhasil disimpan")),
      );
      Navigator.pop(context, true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Gagal menyimpan produk")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Produk"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // 1. GAMBAR PRODUK
              Center(
                child: GestureDetector(
                  onTap: pilihGambar,
                  child: imageBytes == null
                      ? Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Icon(
                            Icons.add_a_photo,
                            size: 60,
                            color: Colors.white,
                          ),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.memory(
                            imageBytes!,
                            height: 150,
                            width: 150,
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
              ),

              const SizedBox(height: 20),

              // 2. NAMA PRODUK
              TextFormField(
                controller: namaController,
                decoration: const InputDecoration(
                  labelText: "Nama Produk",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.shopping_bag),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Nama wajib diisi";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              // 3. HARGA PRODUK
              TextFormField(
                controller: hargaController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Harga Produk",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.money),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Harga wajib diisi";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              // 4. STOK PRODUK
              TextFormField(
                controller: stokController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Stok Produk",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.inventory),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Stok wajib diisi";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              // 5. DESKRIPSI PRODUK
              TextFormField(
                controller: deskripsiController,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: "Deskripsi Produk",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.description),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Deskripsi wajib diisi";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 30),

              // 6. TOMBOL SIMPAN
              SizedBox(
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: loading ? null : simpanData,
                  icon: loading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Icon(Icons.save),
                  label: Text(
                    loading ? "Menyimpan..." : "Simpan",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}