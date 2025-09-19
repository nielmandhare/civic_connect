// lib/services/supabase_service.dart
import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  // singleton pattern
  SupabaseService._();
  static final SupabaseService instance = SupabaseService._();

  final SupabaseClient _supabase = Supabase.instance.client;

  /// Upload an image file to the given bucket
  Future<String> uploadImage({
    required File file,
    String bucketName = 'sih_images',
  }) async {
    try {
      final ext = file.path.split('.').last;
      final filename = '${DateTime.now().millisecondsSinceEpoch}.$ext';
      final destPath = 'uploads/$filename';

      final uploadedPath = await _supabase.storage
          .from(bucketName)
          .upload(destPath, file, fileOptions: const FileOptions(upsert: false));

      return uploadedPath; // this is the storage path
    } catch (e) {
      throw Exception('Upload failed: $e');
    }
  }

  /// Get public URL for a file in a public bucket
  String getPublicUrl({
    required String path,
    String bucketName = 'sih_images',
  }) {
    return _supabase.storage.from(bucketName).getPublicUrl(path);
  }

  /// Save metadata about uploaded file into "images" table
  Future<void> insertImageRecord({
    required String path,
    required String filename,
    String bucketName = 'sih_images',
  }) async {
    final userId = _supabase.auth.currentUser?.id;
    await _supabase.from('images').insert({
      'user_id': userId,
      'bucket_id': bucketName,
      'path': path,
      'filename': filename,
      'public_url': getPublicUrl(path: path, bucketName: bucketName),
      'created_at': DateTime.now().toIso8601String(),
    });
  }
}
