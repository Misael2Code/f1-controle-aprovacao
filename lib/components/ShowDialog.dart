import 'package:controle_aprovacao/requisicoes/Rest_Autenticar.dart';
import 'package:flutter/material.dart';

class DialogHelper {
  static Future<void> showConnecting(BuildContext context, String title) async {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            title: Text(title),
            content: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
              ],
            ));
      },
    );
  }

  static Future<void> showLoginFailed(
      BuildContext context, String title) async {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(Autenticar().resultado),
          actions: [
            ElevatedButton(
              child: const Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }
}
