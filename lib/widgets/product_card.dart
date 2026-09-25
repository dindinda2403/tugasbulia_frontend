import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onDetail;

  const ProductCard({
    super.key,
    required this.product,
    required this.onEdit,
    required this.onDelete,
    required this.onDetail,
  });

  // 1. Fungsi Format Rupiah
  String _formatRupiah(dynamic harga) {
    if (harga == null) return '0';
    String numberString = harga.toString().replaceAll(RegExp(r'[^0-9]'), '');
    if (numberString.isEmpty) return '0';
    String reversed = numberString.split('').reversed.join('');
    String result = '';
    for (int i = 0; i < reversed.length; i++) {
      if (i > 0 && i % 3 == 0) result += '.';
      result += reversed[i];
    }
    return result.split('').reversed.join('');
  }

  // 2. Format URL Backend
  String _getImageUrl(String? path) {
    if (path == null || path.isEmpty) return '';
    if (path.startsWith('http://') || path.startsWith('https://')) {
      return path;
    }
    return "http://127.0.0.1:8000/storage/$path";
  }

  @override
  Widget build(BuildContext context) {
    final imageUrl = _getImageUrl(product.gambar);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      elevation: 2,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onDetail,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- GAMBAR PRODUK ---
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: imageUrl.isEmpty
                    ? Image.asset(
                        "image/shopping.webp",
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            _buildPlaceholder(),
                      )
                    : FutureBuilder<http.Response>(
                        future: http.get(Uri.parse(imageUrl)),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.done &&
                              snapshot.hasData &&
                              snapshot.data!.statusCode == 200) {
                            return Image.memory(
                              snapshot.data!.bodyBytes,
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            );
                          }
                          if (snapshot.hasError ||
                              (snapshot.hasData && snapshot.data!.statusCode != 200)) {
                            return _buildPlaceholder();
                          }
                          return Container(
                            height: 100,
                            width: 100,
                            color: Colors.grey[100],
                            child: const Center(
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          );
                        },
                      ),
              ),
              const SizedBox(width: 14),

              // --- DETAIL PRODUK ---
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.nama,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Rp ${_formatRupiah(product.harga)}",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.pink[400],
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "Stok: ${product.stok}",
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      product.deskripsi,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                    ),
                    const SizedBox(height: 10),

                    // --- TOMBOL ACTION ---
                    Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      children: [
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.pink[300],
                            foregroundColor: Colors.white,
                            elevation: 0,
                            minimumSize: const Size(75, 30),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          onPressed: onEdit,
                          icon: const Icon(Icons.edit, size: 14),
                          label: const Text("Edit", style: TextStyle(fontSize: 12)),
                        ),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red[400],
                            foregroundColor: Colors.white,
                            elevation: 0,
                            minimumSize: const Size(75, 30),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          onPressed: onDelete,
                          icon: const Icon(Icons.delete, size: 14),
                          label: const Text("Delete", style: TextStyle(fontSize: 12)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      height: 100,
      width: 100,
      color: Colors.grey[200],
      child: const Icon(Icons.broken_image, color: Colors.grey, size: 30),
    );
  }
}