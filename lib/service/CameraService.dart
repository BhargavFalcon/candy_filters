import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

Future<File?> pickImage(ImageSource source) async {
  try {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
        source: source,
        preferredCameraDevice: CameraDevice.front,
        maxHeight: 480,
        maxWidth: 640);

    if (pickedFile != null) {
      return File(pickedFile.path);
    } else {
      return null;
    }
  } catch (e) {
    debugPrint('Error picking image: $e');
    PermissionStatus permissionStatus = await Permission.photos.request();
    if (permissionStatus.isGranted) {
      return pickImage(source);
    } else {
      customDialog(
        context: Get.context!,
        title: "Permission Required",
        content: (source == ImageSource.camera)
            ? "This app requires permission to access the camera. Allow access in app settings to continue."
            : "This app requires permission to access the gallery. Allow access in app settings to continue.",
        cancel: "Cancel",
        ok: "Open Setting",
        okColor: Colors.blue,
        onOk: () {
          openAppSettings();
        },
      );
      return null;
    }
  }
}

customDialog({
  required BuildContext context,
  required String title,
  required String content,
  required String cancel,
  required String ok,
  required Function() onOk,
  Color? okColor,
}) {
  if (Platform.isIOS) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: Text(cancel, style: TextStyle(color: Colors.blue)),
          ),
          CupertinoDialogAction(
            onPressed: () => onOk(),
            child: Text(ok, style: TextStyle(color: okColor ?? Colors.red)),
          ),
        ],
      ),
    );
  } else {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: Text(cancel, style: TextStyle(color: Colors.blue)),
          ),
          TextButton(
            onPressed: () => onOk(),
            child: Text(ok, style: TextStyle(color: okColor ?? Colors.red)),
          ),
        ],
      ),
    );
  }
}
