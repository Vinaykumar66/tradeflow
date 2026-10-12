import 'package:flutter/foundation.dart';

class PlatformCapabilities {
  static bool get isDesktop =>
      !kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.windows ||
          defaultTargetPlatform == TargetPlatform.macOS ||
          defaultTargetPlatform == TargetPlatform.linux);

  static bool get supportsCameraCapture => !isDesktop;
  static bool get supportsBarcodeCameraScan => !isDesktop;
  static bool get supportsThermalPrinter => !isDesktop;
}
