import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/product.dart';

class ApiService {
  static const String baseUrl = "http://127.0.0.1:8000/api/";

  Future<List<Product>> getProducts() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString("token") ?? "";

    final response = await http.get(
      Uri.parse("${baseUrl}products"),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      List jsonData = jsonDecode(response.body);
      return jsonData.map((e) => Product.fromJson(e)).toList();
    } else {
      throw Exception('Gagal mengambil data produk');
    }
  }

  // UPDATED: Menerima parameter image (File) dan imageBytes (Uint8List)
  Future<bool> storeProduct(
    Product product,
    File? image, {
    Uint8List? imageBytes,
  }) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString("token") ?? "";

    var request = http.MultipartRequest(
      "POST",
      Uri.parse("${baseUrl}products"),
    );

    request.headers.addAll({
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    });

    request.fields["nama"] = product.nama;
    request.fields["harga"] = product.harga.toString();
    request.fields["stok"] = product.stok.toString();
    request.fields["deskripsi"] = product.deskripsi;

    // Cek jika berjalan di Web
    if (kIsWeb && imageBytes != null) {
      request.files.add(
        http.MultipartFile.fromBytes(
          "gambar",
          imageBytes,
          filename: 'product_${DateTime.now().millisecondsSinceEpoch}.jpg',
        ),
      );
    } else if (image != null) {
      // Jika berjalan di Mobile
      request.files.add(
        await http.MultipartFile.fromPath(
          "gambar",
          image.path,
        ),
      );
    }

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode != 200 && response.statusCode != 201) {
      print("Error Store Product (${response.statusCode}): ${response.body}");
      return false;
    }

    return true;
  }

  Future<bool> updateProduct(Product product, {Uint8List? imageBytes}) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String token = pref.getString("token") ?? "";

      var uri = Uri.parse('${baseUrl}products/${product.id}');
      var request = http.MultipartRequest('POST', uri);

      request.headers.addAll({
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      });

      request.fields['_method'] = 'PUT';
      request.fields['nama'] = product.nama;
      request.fields['harga'] = product.harga.toString();
      request.fields['stok'] = product.stok.toString();
      request.fields['deskripsi'] = product.deskripsi;

      if (imageBytes != null) {
        request.files.add(
          http.MultipartFile.fromBytes(
            'gambar',
            imageBytes,
            filename: 'product_${DateTime.now().millisecondsSinceEpoch}.jpg',
          ),
        );
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode != 200 && response.statusCode != 201) {
        print("Response Error (${response.statusCode}): ${response.body}");
        return false;
      }

      return true;
    } catch (e) {
      print("Error Exception: $e");
      return false;
    }
  }

  Future<bool> deleteProduct(int id) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString("token") ?? "";

    final response = await http.delete(
      Uri.parse("${baseUrl}products/$id"),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );
    return response.statusCode == 200;
  }

  Future<String?> login(String email, String password) async {
    final response = await http.post(
      Uri.parse("${baseUrl}login"),
      body: {
        "email": email,
        "password": password,
      },
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data["token"];
    }
    return null;
  }

  Future<void> logout() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString("token") ?? "";

    await http.post(
      Uri.parse("${baseUrl}logout"),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );
    await pref.remove("token");
  }
}