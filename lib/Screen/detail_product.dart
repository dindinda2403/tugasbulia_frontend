import 'package:flutter/material.dart';
import 'package:flutter_project_dinda/Screen/edit_page.dart';
import '../models/product.dart';

class DetailProduk extends StatelessWidget {
  final Product product;
  const DetailProduk({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail produk"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Hero(
              tag: product.id ?? product.nama, // Mencegah crash jika ID null
              child: Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 235, 52, 204),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: product.gambar == null || product.gambar!.isEmpty
                      ? Image.asset(
                          "image/laptop.jpg",
                          fit: BoxFit.cover,
                        )
                      : Image.network(
                          // Menggunakan IP 127.0.0.1
                          "http://127.0.0.1:8000/storage/${product.gambar}",
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            // Menampilkan icon broken image jika gambar dari server gagal di-load
                            return Container(
                              color: Colors.grey[300],
                              child: const Center(
                                child: Icon(
                                  Icons.broken_image,
                                  size: 50,
                                  color: Colors.grey,
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.nama,
                      style: const TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const Icon(Icons.attach_money),
                        const SizedBox(width: 10),
                        Text(
                          "RP ${product.harga}",
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        const Icon(Icons.inventory),
                        const SizedBox(width: 10),
                        Text(
                          "${product.stok}",
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 16),
                    const Text(
                      "DESKRIPSI",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      product.deskripsi,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15),
            // Tombol EDIT
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.edit),
                label: const Text("EDIT"),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                onPressed: () async {
                  final hasil = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => EditPage(product: product),
                    ),
                  );
                  if (hasil == true) {
                    Navigator.pop(context, true);
                  }
                },
              ),
            ),
            const SizedBox(height: 15),
            // Tombol KEMBALI
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                icon: const Icon(Icons.arrow_back),
                label: const Text("KEMBALI"),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}