import 'package:flutter/material.dart';
import 'package:flutter_project_dinda/Screen/add_page.dart';
import 'package:flutter_project_dinda/Screen/detail_product.dart';
import 'package:flutter_project_dinda/Screen/edit_page.dart';
import 'package:flutter_project_dinda/Screen/login_page.dart';
import 'package:flutter_project_dinda/models/product.dart';
import 'package:flutter_project_dinda/services/api.service.dart';
import 'package:flutter_project_dinda/widgets/DashboardCard.dart';
import 'package:flutter_project_dinda/widgets/product_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ApiService api = ApiService();

  final TextEditingController searchController =
      TextEditingController();

  List<Product> semuaProduk = [];
  List<Product> hasilPencarian = [];

  String filterHarga = "Semua";
  String sorting = "Ascending";

  Future<void> loadProducts() async {
    try {
      final data = await api.getProducts();

      if (!mounted) return;

      setState(() {
        semuaProduk = List.from(data);
        hasilPencarian = List.from(data);
      });

      prosesData();
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Gagal mengambil data: $e',
          ),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  void prosesData() {
    List<Product> data = List.from(semuaProduk);

    // =========================
    // PENCARIAN BERDASARKAN NAMA
    // =========================
    final keyword = searchController.text.toLowerCase();

    if (keyword.isNotEmpty) {
      data = data.where((produk) {
        return produk.nama
            .toLowerCase()
            .contains(keyword);
      }).toList();
    }

    // =========================
    // FILTER BERDASARKAN HARGA
    // =========================
    if (filterHarga == "< Rp500000") {
      data = data.where((produk) {
        return produk.harga < 500000;
      }).toList();
    }

    if (filterHarga == "Rp500000-Rp2000000") {
      data = data.where((produk) {
        return produk.harga >= 500000 &&
            produk.harga <= 2000000;
      }).toList();
    }

    if (filterHarga == ">Rp2000000") {
      data = data.where((produk) {
        return produk.harga > 2000000;
      }).toList();
    }

    // =========================
    // SORTING
    // =========================
    if (sorting == "Ascending") {
      data.sort(
        (a, b) => a.nama
            .toLowerCase()
            .compareTo(
              b.nama.toLowerCase(),
            ),
      );
    }

    if (sorting == "Descending") {
      data.sort(
        (a, b) => b.nama
            .toLowerCase()
            .compareTo(
              a.nama.toLowerCase(),
            ),
      );
    }

    if (sorting == "Harga tertinggi") {
      data.sort(
        (a, b) => b.harga.compareTo(a.harga),
      );
    }

    if (sorting == "Harga terendah") {
      data.sort(
        (a, b) => a.harga.compareTo(b.harga),
      );
    }

    if (sorting == "Stok banyak") {
      data.sort(
        (a, b) => b.stok.compareTo(a.stok),
      );
    }

    if (sorting == "Stok sedikit") {
      data.sort(
        (a, b) => a.stok.compareTo(b.stok),
      );
    }

    // =========================
    // PENYIMPANAN HASIL
    // =========================
    setState(() {
      hasilPencarian = data;
    });
  }

  // =========================
  // PENCARIAN
  // =========================
  void cariProduk(String keyword) {
    prosesData();
  }

  // =========================
  // FILTER HARGA
  // =========================
  void pilihfilterHarga(String? pilihan) {
    if (pilihan == null) return;

    setState(() {
      filterHarga = pilihan;
    });

    prosesData();
  }

  // =========================
  // SORTING
  // =========================
  void pilihsorting(String? pilihan) {
    if (pilihan == null) return;

    setState(() {
      sorting = pilihan;
    });

    prosesData();
  }

  // =========================
  // TOTAL STOK
  // =========================
  int totalStok() {
    return semuaProduk.fold(
      0,
      (total, item) => total + item.stok,
    );
  }

  // =========================
  // TOTAL HARGA
  // =========================
  int totalHarga() {
    return semuaProduk.fold(
      0,
      (total, item) =>
          total + (item.harga * item.stok),
    );
  }

  // =========================
  // FORMAT RUPIAH
  // =========================
  String formatRupiah(int angka) {
    String hasil = angka.toString();
    String result = '';
    int counter = 0;

    for (int i = hasil.length - 1;
        i >= 0;
        i--) {
      result = hasil[i] + result;
      counter++;

      if (counter == 3 && i != 0) {
        result = ".$result";
        counter = 0;
      }
    }

    return "Rp$result";
  }

  // =========================
  // HAPUS PRODUK
  // =========================
  Future<void> hapusProduk(Product product) async {
    bool? konfirmasi = await showDialog<bool>(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("Konfirmasi"),
          content: Text(
            "Apakah yakin akan menghapus "
            "${product.nama}?",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text("Batal"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text("Ya"),
            ),
          ],
        );
      },
    );

    if (konfirmasi != true) {
      return;
    }

    try {
      bool hasil =
          await api.deleteProduct(product.id!);

      if (!mounted) return;

      if (hasil) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Produk berhasil dihapus",
            ),
            backgroundColor: Colors.green,
          ),
        );

        await loadProducts();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Produk gagal dihapus",
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Terjadi kesalahan: $e",
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // =========================
      // APP BAR
      // =========================
      appBar: AppBar(
        title: const Text(
          "Data Produk XII RPL 1",
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 248, 128, 198),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout,
            ),
            onPressed: () async {
              await api.logout();

              if (!mounted) return;

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      const LoginPage(),
                ),
              );
            },
          ),
        ],
      ),

      // =========================
      // TOMBOL TAMBAH
      // =========================
      floatingActionButton:
          FloatingActionButton(
        onPressed: () async {
          final hasil =
              await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  const AddPage(),
            ),
          );

          if (hasil == true) {
            await loadProducts();
          }
        },
        child: const Icon(
          Icons.add,
        ),
      ),

      // =========================
      // BODY
      // =========================
      body: RefreshIndicator(
        onRefresh: loadProducts,
        child: ListView(
          physics:
              const AlwaysScrollableScrollPhysics(),
          padding:
              const EdgeInsets.all(12),
          children: [
            // =========================
            // HEADER
            // =========================
            Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                const Text(
                  "Hallo Admin",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  "Selamat datang di "
                  "Aplikasi CRUD XII RPL 1",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight:
                        FontWeight.bold,
                    color:
                        Color.fromARGB(255, 241, 132, 236),
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 15,
            ),

            // =========================
            // SEARCH
            // =========================
            TextField(
              controller:
                  searchController,
              onChanged: cariProduk,
              decoration:
                  InputDecoration(
                hintText:
                    "Cari Produk",
                prefixIcon:
                    const Icon(
                  Icons.search,
                ),
                suffixIcon:
                    searchController
                            .text
                            .isNotEmpty
                        ? IconButton(
                            icon:
                                const Icon(
                              Icons.clear,
                            ),
                            onPressed: () {
                              searchController
                                  .clear();

                              prosesData();

                              setState(() {});
                            },
                          )
                        : null,
                border:
                    OutlineInputBorder(
                  borderRadius:
                      BorderRadius
                          .circular(15),
                ),
              ),
            ),

            const SizedBox(
              height: 15,
            ),

            // =========================
            // FILTER DAN SORTING
            // =========================
            Row(
              children: [
                // FILTER HARGA
                Expanded(
                  child:
                      DropdownButtonFormField<
                          String>(
                    value: filterHarga,
                    decoration:
                        InputDecoration(
                      labelText:
                          "Filter Harga",
                      prefixIcon:
                          const Icon(
                        Icons.filter_alt,
                      ),
                      border:
                          OutlineInputBorder(
                        borderRadius:
                            BorderRadius
                                .circular(
                                    15),
                      ),
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: "Semua",
                        child: Text(
                          "Semua",
                        ),
                      ),
                      DropdownMenuItem(
                        value:
                            "< Rp500000",
                        child: Text(
                          "< Rp500.000",
                        ),
                      ),
                      DropdownMenuItem(
                        value:
                            "Rp500000-Rp2000000",
                        child: Text(
                          "Rp500.000 - "
                          "Rp2.000.000",
                        ),
                      ),
                      DropdownMenuItem(
                        value:
                            ">Rp2000000",
                        child: Text(
                          "> Rp2.000.000",
                        ),
                      ),
                    ],
                    onChanged:
                        pilihfilterHarga,
                  ),
                ),

                const SizedBox(
                  width: 10,
                ),

                // SORTING
                Expanded(
                  child:
                      DropdownButtonFormField<
                          String>(
                    value: sorting,
                    decoration:
                        InputDecoration(
                      labelText:
                          "Sorting",
                      prefixIcon:
                          const Icon(
                        Icons.sort,
                      ),
                      border:
                          OutlineInputBorder(
                        borderRadius:
                            BorderRadius
                                .circular(
                                    15),
                      ),
                    ),
                    items: const [
                      DropdownMenuItem(
                        value:
                            "Ascending",
                        child: Text(
                          "Nama A-Z",
                        ),
                      ),
                      DropdownMenuItem(
                        value:
                            "Descending",
                        child: Text(
                          "Nama Z-A",
                        ),
                      ),
                      DropdownMenuItem(
                        value:
                            "Harga tertinggi",
                        child: Text(
                          "Harga "
                          "Tertinggi",
                        ),
                      ),
                      DropdownMenuItem(
                        value:
                            "Harga terendah",
                        child: Text(
                          "Harga "
                          "Terendah",
                        ),
                      ),
                      DropdownMenuItem(
                        value:
                            "Stok banyak",
                        child: Text(
                          "Stok Banyak",
                        ),
                      ),
                      DropdownMenuItem(
                        value:
                            "Stok sedikit",
                        child: Text(
                          "Stok Sedikit",
                        ),
                      ),
                    ],
                    onChanged:
                        pilihsorting,
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 20,
            ),

            // =========================
            // DASHBOARD CARD
            // =========================
            Row(
              children: [
                Expanded(
                  child:
                      DashboardCard(
                    title: "Produk",
                    value:
                        "${semuaProduk.length}",
                    icon:
                        Icons.shopping_bag,
                    color:
                        Colors.indigo,
                  ),
                ),
                Expanded(
                  child:
                      DashboardCard(
                    title: "Stok",
                    value:
                        "${totalStok()}",
                    icon:
                        Icons.inventory,
                    color:
                        Colors.green,
                  ),
                ),
                Expanded(
                  child:
                      DashboardCard(
                    title:
                        "Total Harga",
                    value:
                        "${totalHarga()}",
                    icon:
                        Icons.payment,
                    color:
                        Colors.orangeAccent,
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 15,
            ),

            // =========================
            // JUDUL DAFTAR PRODUK
            // =========================
            const Text(
              "Daftar Produk",
              style: TextStyle(
                fontSize: 18,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            // =========================
            // PRODUK DITEMUKAN
            // =========================
            Text(
              "Produk ditemukan: "
              "${hasilPencarian.length}",
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            // =========================
            // DAFTAR PRODUK
            // =========================
            if (hasilPencarian.isEmpty)
              const Padding(
                padding:
                    EdgeInsets.all(30),
                child: Center(
                  child: Text(
                    "Produk tidak ditemukan",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              )
            else
              ...hasilPencarian.map(
                (product) {
                  return ProductCard(
                    product: product,

                    // =========================
                    // EDIT
                    // =========================
                    onEdit: () async {
                      final hasil =
                          await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              EditPage(
                            product:
                                product,
                          ),
                        ),
                      );

                      if (hasil == true) {
                        await loadProducts();
                      }
                    },

                    // =========================
                    // DELETE
                    // =========================
                    onDelete: () {
                      hapusProduk(
                        product,
                      );
                    },

                    // =========================
                    // DETAIL
                    // =========================
                    onDetail: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              DetailProduk (
                            product:
                                product,
                          ),
                        ),
                      );

                      await loadProducts();
                    },
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}