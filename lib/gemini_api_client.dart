import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ImageApiClient {
  final Dio _dio;

  ImageApiClient() : _dio = Dio();

  Future<String> generateImagePreview({
    required String personImage,
    required String clothingImage,
  }) async {
    final prompt =
        'Create an image of me in the first image wearing the piece of clothing in the second image. Do not change anything else about the image.';
    final String apiKey = dotenv.env['GEMINI_API_KEY'] ?? '';
    final String url =
        'https://generativelanguage.googleapis.com/v1beta/models/gemini-3.1-flash-image-preview:generateContent';

    try {
      final response = await _dio.post(
        url,
        options: Options(
          headers: {
            'x-goog-api-key': apiKey,
            'Content-Type': 'application/json',
          },
        ),
        data: {
          "contents": [
            {
              "parts": [
                {"text": prompt},
                {
                  "inline_data": {
                    "mime_type": "image/jpeg",
                    "data": personImage,
                  },
                },
                {
                  "inline_data": {
                    "mime_type": "image/jpeg",
                    "data": clothingImage,
                  },
                },
              ],
            },
          ],
        },
      );

      print('Status code: ${response.statusCode}');
      print('Response data: ${response.data}');

      return response
              .data['candidates']?[0]?['content']?['parts']?[0]?['inlineData']?['data'] ??
          '';
    } on DioException catch (e) {
      if (e.response != null) {
        print('Dio error!');
        print('STATUS: ${e.response?.statusCode}');
        print('DATA: ${e.response?.data}');
      } else {
        // Error due to setting up or sending the request
        print('Error sending request!');
        print(e.message);
      }
      return '';
    } catch (e) {
      print('Unexpected error: $e');
      return '';
    }
  }
}
