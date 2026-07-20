abstract interface class IStorageService {
  /// Upload a file and return its public URL
  Future<String> uploadFile({
    required String bucket,
    required List<int> bytes,
    required String mimeType,
    String? customPath,
  });

  /// Delete a file by its URL
  Future<void> deleteFile(String url);

  /// Get a signed URL for a private file (expires after duration)
  Future<String> getSignedUrl({
    required String bucket,
    required String path,
    required Duration expiresIn,
  });
}

/// Result returned after every upload
/// Contains URL and byte size for storage tracking
class StorageUploadResult {
  final String url;
  final int fileSizeBytes;
  const StorageUploadResult({required this.url, required this.fileSizeBytes});
}

// When ready to switch - change ONE line in DI file:

// Current:
// IStorageService storageService(Ref ref) => SupabaseStorageService();

// After switch:
// IStorageService storageService(Ref ref) => CloudflareR2StorageService();
