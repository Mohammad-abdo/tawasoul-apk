import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:mobile_app/core/extensions/image_url_extension.dart';
import 'package:mobile_app/features/shared%20copy/resources/app_images.dart';
import 'package:shimmer/shimmer.dart';
import 'package:svg_flutter/svg.dart';

class AppImage extends StatelessWidget {
  final String? imageUrl;
  final String? assetPath;
  final String? assetPackage;
  final File? file;
  final XFile? xFile;

  final double? width;
  final double? height;
  final BoxFit fit;

  final bool isCircle;
  final BorderRadius? borderRadius;
  final Border? border;

  final Widget? placeholder;
  final Widget? errorWidget;

  final String? heroTag;

  /// للـ SVG فقط: تلوين الأيقونة (مثلاً ColorFilter.mode(color, BlendMode.srcIn))
  final ColorFilter? colorFilter;

  const AppImage({
    super.key,
    this.imageUrl,
    this.assetPath,
    this.assetPackage,
    this.file,
    this.xFile,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.isCircle = false,
    this.borderRadius,
    this.border,
    this.placeholder,
    this.errorWidget,
    this.heroTag,
    this.colorFilter,
  });

  @override
  Widget build(BuildContext context) {
    Widget image = _buildImage();

    /// شكل الصورة
    if (isCircle) {
      image = ClipOval(child: image);
    } else if (borderRadius != null) {
      image = ClipRRect(borderRadius: borderRadius!, child: image);
    }

    /// إضافة Border
    if (border != null) {
      image = Container(
        decoration: BoxDecoration(
          border: border,
          shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
          borderRadius: isCircle ? null : borderRadius,
        ),
        child: image,
      );
    }

    /// Hero Support
    if (heroTag != null) {
      image = Hero(tag: heroTag!, child: image);
    }

    return image;
  }

  Widget _buildImage() {
    /// 1️⃣ XFile
    if (xFile != null) {
      return Image.file(
        File(xFile!.path),
        width: width,
        height: height,
        fit: fit,
      );
    }

    /// 2️⃣ File
    if (file != null) {
      return Image.file(file!, width: width, height: height, fit: fit);
    }

    /// 3️⃣ Network or Asset — مع دعم SVG (امتداد .svg)
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      final fullUrl = imageUrl.toImageUrl();
      final isSvg = fullUrl.toLowerCase().endsWith('.svg');
      if (isSvg) {
        return _buildSvg(fullUrl, isNetwork: fullUrl.startsWith('http') || fullUrl.startsWith('https://'));
      }
      if (fullUrl.startsWith('http://') || fullUrl.startsWith('https://')) {
        return CachedNetworkImage(
          imageUrl: fullUrl,
          width: width,
          height: height,
          fit: fit,
          placeholder: (context, url) => placeholder ?? _shimmer(),
          errorWidget: (context, url, error) => errorWidget ??  _defaultImage(),
        );
      }
      return Image.asset(
        imageUrl!,
        package: assetPackage,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (_, __, ___) =>
            errorWidget ?? const Icon(Icons.broken_image),
      );
    }

    /// 4️⃣ Asset (صور أو SVG)
    if (assetPath != null && assetPath!.isNotEmpty) {
      if (assetPath!.toLowerCase().endsWith('.svg')) {
        return _buildSvg(assetPath!, isNetwork: false);
      }
      return Image.asset(
        assetPath!,
        package: assetPackage,
        width: width,
        height: height,
        fit: fit,
      );
    }

    /// 5️⃣ Default fallback
    return placeholder ?? _defaultImage();
  }

  Widget _buildSvg(String path, {required bool isNetwork}) {
    try {
      if (isNetwork) {
        return SvgPicture.network(
          path,
          width: width,
          height: height,
          fit: fit,
          colorFilter: colorFilter,
        );
      }
      return SvgPicture.asset(
        path,
        width: width,
        height: height,
        fit: fit,
        colorFilter: colorFilter,
      );
    } catch (_) {
      return errorWidget ?? const Icon(Icons.broken_image);
    }
  }

  /// Shimmer widget يستخدم كـ placeholder عند تحميل الصور من الشبكة
  Widget _shimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(width: width, height: height, color: Colors.grey),
    );
  }

  Widget _defaultImage() {
    return Image.asset(
      AppImages.imageDefaultUser,
      width: width,
      height: height,
      fit: fit,
    );
  }
}
