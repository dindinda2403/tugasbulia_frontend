class Product {
  final int? id;
  final String nama;
  final int harga;
  final int stok;
  final String deskripsi;
  final String? gambar;

  Product({
    this.id,
    required this.nama,
    required this.harga,
    required this.stok,
    required this.deskripsi,
    this.gambar,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      nama: json['nama'],
      stok: json['stok'],
      harga: json['harga'],
      deskripsi: json['deskripsi'],
      gambar: json['gambar'],
    );
  }
}
