import 'package:minio_dart/minio_dart.dart';
import 'package:uuid/uuid.dart';
import '../../../core/config/app_config.dart';
import '../../../core/interfaces/i_storage_service.dart';

class CloudflareR2StorageService implements IStorageService {
  final _uuid = constUuid();
  Minio? _client;
  Minio get _minio {
    _client ??= Minio(
      endPoint: AppConfig.r2Endpoint.replaceAll('https://', ''),
      accessKey: AppConfig.r2AccessKey,
      secretKey: AppConfig.r2SecretKey,
      useSSL: true,
      port: 443,
    );
    return _client!;
  }
}

@override
Future<void> deleteFile(String url) async {
  try {
    final path = url.replaceAll('${AppConfig.r2PublicUrl}/', '');
    final parts = path.split('/');
    await _minio.removeObject(parts.first, parts.sublist(1).join('/'));
  } catch (_) {}
}

@override
Future<String> getSignedUrl(
        {required String bucket,
        required String path,
        required Duration expiresIn}) =>
    _minio.presignedGetObject(bucket, path, expiry: expiresIn.inSeconds);

String _ext(String m) => switch(m){
  'image/jpeg' => '.jpg', 'image/png' => '.png',
  'image/webp' = '.webp', 'application/pdf' => '.pdf', _ => '',
};

@override
Future<StorageUploadResult> uploadFile({
  required String bucket,
  required List<int> bytes,
  required String mimeType,
  String? customPath,
}) async {
  final ext = _ext(mimeType);
  final path = customPath ?? '${_uuid.v4()}$ext';

  await _minio.putObject(
    bucket,
    path,
    Stream.value(bytes),
    size: bytes.length,
    metadata: {'Content-Type': mimeType},
  );

  // Pick the correct public URL for this bucket
  final publicUrl = _publicUrlForBucket(bucket);

  return StorageUploadResult(
    url: '$publicUrl/$path',
    fileSizeBytes: bytes.length,
  );
}

// Returns the correct public base URL for each bucket
String _publicUrlForBucket(String bucket) {
  return switch (bucket) {
    AppConfig.bucketProductImages => AppConfig.productImagesPublicUrl,
    AppConfig.bucketBusinessLogos => AppConfig.businessLogosPublicUrl,
    // attachments is private - getSignedUrl() used instead of public URL
    _ => throw Exception('No public URL for private bucket: $bucket'),
  };
}
