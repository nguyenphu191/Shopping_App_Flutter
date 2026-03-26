import 'dart:convert';
import 'dart:io';
import 'package:flutter_shopping_app/core/constants/app_env.dart';
import 'package:http/http.dart' as http;

class CloudinaryService {
  /// Upload một file ảnh lên Cloudinary và trả về secure URL.
  /// Throws [Exception] nếu upload thất bại.
  Future<String> uploadImage(File imageFile) async {
    final cloudName = AppEnv.cloudinaryCloudName;
    final uploadPreset = AppEnv.cloudinaryUploadPreset;

    if (cloudName.isEmpty || uploadPreset.isEmpty) {
      throw Exception(
          'Chưa cấu hình CLOUDINARY_CLOUD_NAME hoặc CLOUDINARY_UPLOAD_PRESET trong .env');
    }

    final uri = Uri.parse(
        'https://api.cloudinary.com/v1_1/$cloudName/image/upload');

    final request = http.MultipartRequest('POST', uri)
      ..fields['upload_preset'] = uploadPreset
      ..files.add(await http.MultipartFile.fromPath('file', imageFile.path));

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return data['secure_url'] as String;
    } else {
      throw Exception('Upload thất bại: ${response.statusCode} ${response.body}');
    }
  }
}
