import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class MediaPickerService {
  final ImagePicker _picker = ImagePicker();

  Future<XFile?> pickImage() {
    return _picker.pickImage(source: ImageSource.gallery);
  }

  Future<XFile?> pickVideo() {
    return _picker.pickVideo(source: ImageSource.gallery);
  }

  Widget preview(XFile file) {
    if (file.mimeType?.startsWith('video/') ?? false) {
      final controller = VideoPlayerController.file(File(file.path));
      return FutureBuilder(
        future: controller.initialize(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return AspectRatio(
              aspectRatio: controller.value.aspectRatio,
              child: VideoPlayer(controller),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      );
    }
    return Image.file(File(file.path));
  }
}
