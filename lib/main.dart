import 'dart:io';
import 'package:ControleAprovacao/welcome.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  // Garantir a inicialização correta dos widgets do Flutter.
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializar o Firebase com as opções da plataforma atual.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Sobrescrever a configuração de certificados HTTP.
  HttpOverrides.global = MyHttpOverrides();

  // Iniciar o aplicativo.
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Welcome(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// Classe para sobrescrever as validações de certificado SSL.
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
