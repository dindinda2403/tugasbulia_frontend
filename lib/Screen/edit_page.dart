import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_dinda/models/product.dart';
import 'package:flutter_project_dinda/services/api.service.dart';
import 'package:image_picker/image_picker.dart';

class EditPage extends StatefulWidget {
  final Product product;
  const EditPage({super.key, required this.product});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController namaController;
  late TextEditingController hargaController;
  late TextEditingController stokController;
  late TextEditingController deskripsiController;

  final ApiService api = ApiService();
  bool loading = false;
  File? image;
  Uint8List? imageBytes;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    namaController = TextEditingController(text: widget.product.nama);
    hargaController = TextEditingController(text: widget.product.harga.toString());
    stokController = TextEditingController(text: widget.product.stok.toString());
    deskripsiController = TextEditingController(text: widget.product.deskripsi);
  }

  Future<void> pilihGambar() async {
    final XFile? picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      final bytes = await picked.readAsBytes();
      setState(() {
        imageBytes = bytes;
        if (!kIsWeb) {
          image = File(picked.path);
        }
      });
    }
  }

  Future<void> updateData() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      loading = true;
    });

    Product updatedProduct = Product(
      id: widget.product.id,
      nama: namaController.text,
      harga: int.parse(hargaController.text),
      stok: int.parse(stokController.text),
      deskripsi: deskripsiController.text,
    );

    // BISA DIKIRIM DENGAN GAMBAR (imageBytes)
    bool berhasil = await api.updateProduct(updatedProduct, imageBytes: imageBytes);

    setState(() {
      loading = false;
    });

    if (!mounted) return;

    if (berhasil) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Produk berhasil diperbarui")),
      );
      Navigator.pop(context, true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Gagal memperbarui produk")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Produk"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Fitur Upload Gambar di Edit Page
             Center(
  child: GestureDetector(
    onTap: pilihGambar,
    child: imageBytes != null
        // 1. Gambar baru yang baru saja dipilih dari galeri
        ? ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.memory(
              imageBytes!,
              height: 150,
              width: 150,
              fit: BoxFit.cover,
            ),
          )
        : (widget.product.gambar != null && widget.product.gambar!.isNotEmpty)
            // 2. Gambar lama dari Laravel Storage
            ? ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  "http://127.0.0.1:8000/storage/${widget.product.gambar}",
                  height: 150,
                  width: 150,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Icon(Icons.broken_image, size: 50, color: Colors.grey),
                    );
                  },
                ),
              )
            // 3. Ikon default jika belum ada gambar
            : Container(
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
              ),
  ),
),

              TextFormField(
                controller: namaController,
                decoration: const InputDecoration(
                  labelText: "Nama Produk",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.shopping_bag),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return "Nama wajib diisi";
                  return null;
                },
              ),
              const SizedBox(height: 20),

              TextFormField(
                controller: hargaController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Harga Produk",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.money),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return "Harga wajib diisi";
                  return null;
                },
              ),
              const SizedBox(height: 20),

              TextFormField(
                controller: stokController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Stok Produk",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.inventory),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return "Stok wajib diisi";
                  return null;
                },
              ),
              const SizedBox(height: 20),

              TextFormField(
                controller: deskripsiController,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: "Deskripsi Produk",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.description),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return "Deskripsi wajib diisi";
                  return null;
                },
              ),
              const SizedBox(height: 30),

              SizedBox(
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: loading ? null : updateData,
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
                  label: Text(loading ? "Menyimpan..." : "Simpan"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}