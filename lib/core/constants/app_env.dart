import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppEnv {
  AppEnv._();

  static String get apiBaseUrl =>
      dotenv.env['API_BASE_URL'] ?? 'http://192.168.0.101:8000/api';

  static String get appName => dotenv.env['APP_NAME'] ?? 'FuFu Shopping';

  static String get appVersion => dotenv.env['APP_VERSION'] ?? '1.0.0';

  static String get cloudinaryCloudName =>
      dotenv.env['CLOUDINARY_CLOUD_NAME'] ?? '';

  static String get cloudinaryApiKey =>
      dotenv.env['CLOUDINARY_API_KEY'] ?? '';

  static String get cloudinaryApiSecret =>
      dotenv.env['CLOUDINARY_API_SECRET'] ?? '';

  static String get cloudinaryUploadPreset =>
      dotenv.env['CLOUDINARY_UPLOAD_PRESET'] ?? '';

  static String get paypalClientId =>
      dotenv.env['PAYPAL_CLIENT_ID'] ?? '';

  static String get paypalSecretKey =>
      dotenv.env['PAYPAL_SECRET_KEY'] ?? '';
}
