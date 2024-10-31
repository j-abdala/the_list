import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> checkPermission(Permission permission, BuildContext context) async {
  final status = await permission.request();

  if (status.isDenied) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Some features won't function as intended.")));
  }
}