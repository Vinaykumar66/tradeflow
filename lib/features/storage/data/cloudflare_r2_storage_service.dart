// lib/features/storage/data/cloudflare_r2_storage_service.dart

import 'dart:typed_data';

import 'package:minio/minio.dart';
import 'package:uuid/uuid.dart';
import '../../../core/config/app_config.dart';
import '../../../core/interfaces/i_storage_service.dart';

class CloudflareR2StorageService implements IStorageService {
  final _uuid = const Uuid();
  late final Minio _client;

  CloudflareR2StorageService() {
    _client = Minio(
      endPoint: AppConfig.r2Endpoint
          .replaceAll('https://', '')
          .replaceAll('http://', ''),
      accessKey: AppConfig.r2AccessKey,
      secretKey: AppConfig.r2SecretKey,
      useSSL: true,
      port: 443,
    );
  }

  @override
  Future<StorageUploadResult> uploadFile({
    required String bucket,
    required List<int> bytes,
    required String mimeType,
    String? customPath,
  }) async {
    final ext = _ext(mimeType);
    final path = customPath ?? '${_uuid.v4()}$ext';

    final data = Uint8List.fromList(bytes);

    await _client.putObject(
      bucket,
      path,
      Stream.value(data),
      size: data.length,
      metadata: {'Content-Type': mimeType},
    );

    return StorageUploadResult(
      url: '${_publicUrlForBucket(bucket)}/$path',
      fileSizeBytes: bytes.length,
    );
  }

  @override
  Future<void> deleteFile(String url) async {
    try {
      final path = url.contains('.r2.dev/')
          ? url.split('.r2.dev/').last
          : url.split('/').last;
      final parts = path.split('/');
      final bucket = parts.first;
      final key = parts.sublist(1).join('/');
      await _client.removeObject(bucket, key);
    } catch (_) {}
  }

  @override
  Future<String> getSignedUrl({
    required String bucket,
    required String path,
    required Duration expiresIn,
  }) async {
    return _client.presignedGetObject(
      bucket,
      path,
      expires: expiresIn.inSeconds,
    );
  }

  String _publicUrlForBucket(String bucket) => switch (bucket) {
        AppConfig.bucketProductImages => AppConfig.productImagesPublicUrl,
        AppConfig.bucketBusinessLogos => AppConfig.businessLogosPublicUrl,
        _ => throw Exception('No public URL for private bucket: $bucket'),
      };

  String _ext(String mime) => switch (mime) {
        'image/jpeg' => '.jpg',
        'image/png' => '.png',
        'image/webp' => '.webp',
        'application/pdf' => '.pdf',
        _ => '',
      };
}
