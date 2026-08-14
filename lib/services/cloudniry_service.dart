import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;

/// Cloudinary upload service.
///
/// SECURITY: this client no longer holds the Cloudinary `api_key` / `api_secret`.
/// Uploads use an **unsigned upload preset**, so no signing secret ever ships
/// inside the app. The cloud name and preset name below are not secrets.
///
/// Firebase Console / Cloudinary setup required (see PRODUCTION_HARDENING_REPORT):
///   1. Cloudinary dashboard → Settings → Upload → add an *unsigned* upload
///      preset named `englify_unsigned` (or override via --dart-define).
///   2. On that preset, allow the `public_id` and `folder` params and restrict
///      the allowed formats / max file size as desired.
///
/// Both values can be overridden at build time without code changes:
///   flutter build apk --dart-define=CLOUDINARY_CLOUD_NAME=xxx \
///                     --dart-define=CLOUDINARY_UPLOAD_PRESET=yyy
class CloudinaryService {
  // Non-secret configuration. Overridable via --dart-define for other tenants.
  static const String cloudName =
      String.fromEnvironment('CLOUDINARY_CLOUD_NAME', defaultValue: 'dkswfrmz0');
  static const String uploadPreset = String.fromEnvironment(
    'CLOUDINARY_UPLOAD_PRESET',
    defaultValue: 'englify_unsigned',
  );

  static const String uploadUrl =
      'https://api.cloudinary.com/v1_1/$cloudName/image/upload';
  static const String rawUploadUrl =
      'https://api.cloudinary.com/v1_1/$cloudName/raw/upload';

  /// Shared unsigned upload. Returns the `secure_url` on success, throws on
  /// failure. `endpoint` selects the image vs raw endpoint.
  Future<String> _unsignedUpload({
    required String endpoint,
    required List<int> bytes,
    required String filename,
    required String folder,
    required String publicId,
  }) async {
    final request = http.MultipartRequest('POST', Uri.parse(endpoint));
    request.files.add(
      http.MultipartFile.fromBytes('file', bytes, filename: filename),
    );
    // Unsigned upload — only the preset, no api_key / signature.
    request.fields['upload_preset'] = uploadPreset;
    request.fields['folder'] = folder;
    request.fields['public_id'] = publicId;

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['secure_url'] as String;
    }
    throw Exception(
      "Upload failed with status ${response.statusCode}: ${response.body}",
    );
  }

  Future<String> uploadClassroomImage({
    required File imageFile,
    required String classId,
  }) async {
    try {
      print("\n📤 ===== CLOUDINARY UPLOAD STARTED =====");
      print("📂 File path: ${imageFile.path}");

      if (!await imageFile.exists()) {
        throw Exception("Image file not found at: ${imageFile.path}");
      }

      final fileSize = await imageFile.length();
      print("📊 File size: ${(fileSize / 1024).toStringAsFixed(2)} KB");

      final bytes = await imageFile.readAsBytes();
      final imageUrl = await _unsignedUpload(
        endpoint: uploadUrl,
        bytes: bytes,
        filename: 'classroom_$classId.jpg',
        folder: 'englify_classrooms',
        publicId: 'class_$classId',
      );

      print("✅ Upload successful!");
      print("🔗 URL: $imageUrl");
      print("===== UPLOAD COMPLETED =====\n");
      return imageUrl;
    } catch (e) {
      print("❌ Upload error: $e");
      print("===== UPLOAD FAILED =====\n");
      throw Exception("Failed to upload image: $e");
    }
  }

  Future<void> deleteImage(String imageUrl) async {
    // NOTE: destructive Cloudinary deletes require the api_secret, which has
    // intentionally been removed from the client. Deletion must be performed
    // server-side (a Cloud Function) — see PRODUCTION_HARDENING_REPORT. This
    // call is a no-op so callers don't break.
    print("🗑️ Image deletion requested (server-side only): $imageUrl");
  }

  Future<String> uploadLessonImage({
    required File imageFile,
    required String lessonId,
  }) async {
    try {
      print("\n📤 ===== LESSON IMAGE UPLOAD STARTED =====");

      if (!await imageFile.exists()) {
        throw Exception("Image file not found at: ${imageFile.path}");
      }

      final bytes = await imageFile.readAsBytes();
      final imageUrl = await _unsignedUpload(
        endpoint: uploadUrl,
        bytes: bytes,
        filename: 'lesson_img_$lessonId.jpg',
        folder: 'englify_lessons',
        publicId: 'lesson_img_$lessonId',
      );

      print("✅ Lesson image uploaded: $imageUrl");
      print("===== LESSON IMAGE UPLOAD COMPLETED =====\n");
      return imageUrl;
    } catch (e) {
      print("❌ Lesson image upload error: $e");
      throw Exception("Failed to upload lesson image: $e");
    }
  }

  // ── Profile picture upload
  Future<String> uploadProfilePicture({
    required File imageFile,
    required String userId,
  }) async {
    try {
      print("\n📤 ===== PROFILE IMAGE UPLOAD STARTED =====");

      if (!await imageFile.exists()) {
        throw Exception("Image file not found");
      }

      final bytes = await imageFile.readAsBytes();
      final imageUrl = await _unsignedUpload(
        endpoint: uploadUrl,
        bytes: bytes,
        filename: 'profile_$userId.jpg',
        folder: 'user/userprofile/profileimage',
        publicId: 'profile_$userId',
      );

      print("✅ Profile image uploaded: $imageUrl");
      return imageUrl;
    } catch (e) {
      print("❌ Profile image upload error: $e");
      throw Exception("Failed to upload profile image: $e");
    }
  }

  // ─────────────────────────────────────────
  // Lesson CONTENT FILE upload (PDF, doc, etc.)
  // ─────────────────────────────────────────
  Future<String> uploadLessonContent({
    required File contentFile,
    required String lessonId,
    required String fileExtension,
  }) async {
    try {
      print("\n📤 ===== LESSON CONTENT UPLOAD STARTED =====");

      if (!await contentFile.exists()) {
        throw Exception("Content file not found at: ${contentFile.path}");
      }

      final bytes = await contentFile.readAsBytes();

      // Use raw upload for PDFs/docs, image upload for images.
      final isImage = [
        'jpg',
        'jpeg',
        'png',
        'gif',
        'webp',
      ].contains(fileExtension.toLowerCase());
      final endpoint = isImage ? uploadUrl : rawUploadUrl;

      final contentUrl = await _unsignedUpload(
        endpoint: endpoint,
        bytes: bytes,
        filename: 'lesson_content_$lessonId.$fileExtension',
        folder: 'englify_lessons_content',
        publicId: 'lesson_content_$lessonId',
      );

      print("✅ Lesson content uploaded: $contentUrl");
      print("===== LESSON CONTENT UPLOAD COMPLETED =====\n");
      return contentUrl;
    } catch (e) {
      print("❌ Lesson content upload error: $e");
      throw Exception("Failed to upload lesson content: $e");
    }
  }
}
