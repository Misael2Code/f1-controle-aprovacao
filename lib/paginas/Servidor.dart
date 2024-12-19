import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:controle_aprovacao/model/Model_DNS.dart';
import 'package:controle_aprovacao/model/Model_Parametro.dart';
import 'package:controle_aprovacao/paginas/Login.dart';
import 'package:controle_aprovacao/requisicoes/Rest_ValidarDNS.dart';
import 'package:controle_aprovacao/requisicoes/disconnect.dart';
import 'package:controle_aprovacao/requisicoes/set_Memory.dart';
import 'package:flutter/material.dart';

class Servidor extends StatefulWidget {
  const Servidor({super.key});

  @override
  _ServidorState createState() => _ServidorState();
}

class _ServidorState extends State<Servidor> {
  final TextEditingController _controllerServidor = TextEditingController();
  String _errorText = '';
  bool _isLoading = false;
  bool _changeEnable = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.blue,
                        spreadRadius: 1,
                        blurRadius: 9,
                        offset: Offset(0, 4),
                      ),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        color: Colors.transparent,
                        child: Image.asset(
                          'image/logo.png',
                          height: 70,
                        ),
                      ),
                      const SizedBox(height: 48),
                      TextFormField(
                        enabled: !_changeEnable,
                        controller: _controllerServidor,
                        decoration: InputDecoration(
                          errorText: _errorText.isEmpty ? null : _errorText,
                          helperText: ResultadoDNS().conectado ? null : 
                            'Exemplo: https://servidor:porta',
                          suffixIcon: _isLoading
                              ? Transform.scale(
                                  scale: 0.5,
                                  child: const CircularProgressIndicator(
                                    color: Colors.blue,
                                  ),
                                )
                              : Icon(
                                  ResultadoDNS().conectado ? 
                                    Icons.check :
                                     Icons.miscellaneous_services,
                                  color: Colors.blue,
                                ),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(16),
                            ),
                          ),
                          hintText: 'Informe o Servidor',
                        ),
                      ),
                      const SizedBox(height: 12),
                      _changeEnable
                          ? ElevatedButton(
                              onPressed: () async {
                                Disconnect().disconnect();
                                Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const Servidor()));
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                    color: Color.fromRGBO(13, 71, 161, 1),
                                  ),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                              child: const Text(
                                'Alterar',
                                style: TextStyle(
                                  color: Color.fromRGBO(13, 71, 161, 1),
                                ),
                              ),
                            )
                          : const SizedBox(height: 0),
                      const SizedBox(height: 6),
                      ElevatedButton(
                        onPressed: () async {
                          if(ResultadoDNS().conectado) {
                            Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const Login()));
                          } else {
                            setState(() {
                            _isLoading = true;
                            _errorText = '';
                          });

                          String ret = await conectarServidor(context);

                          setState(() {
                            _isLoading = false;
                            if (ret.contains('Falhou')) {
                              _errorText = 'Servidor não encontrado.';
                            } else if (ret.contains('Conectou')) {
                              _changeEnable = true;
                            }
                          });
                          }                          
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromRGBO(13, 71, 161, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: Text(
                          _changeEnable ? 'Avançar' : 'Conectar',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<String> conectarServidor(BuildContext context) async {
    try {
      var querySnapshot =
          await FirebaseFirestore.instance.collection('users').get();

      for (var docSnapshot in querySnapshot.docs) {
        Model_DNS().DNS = docSnapshot.data().toString();
      }
      if (Model_DNS().DNS.contains(_controllerServidor.text)) {
        Model_Parametro().Url = _controllerServidor.text;
        ResultadoDNS().conectado = true;
        setMemory(_controllerServidor.text);
        return 'Conectou';
      } else {
        return 'Falhou';
      }
    } catch (e) {
      return 'Erro ao conectar ao servidor: $e';
    }
  }
}