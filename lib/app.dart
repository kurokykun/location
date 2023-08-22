// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

TextEditingController _controller = TextEditingController();

Future<void> fetchData() async {
  final response = await http.get(Uri.parse('http://localhost:8000/test'));

  if (response.statusCode == 200) {
    // Successful response
    _controller.text = response.body;
    print(response.body); // Do whatever you want with the API response
  } else {
    print('Error: ${response.statusCode}');
  }
}

Future<void> sendData() async {
  var content = jsonEncode(<String, String>{'coordenadas': 'Texto de prueba'});
  final response = await http.post(
    Uri.parse('http://localhost:8000/test'),
    body: content,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(18),
              child: TextField(
                enabled: true,
                controller: _controller,
                decoration: InputDecoration(
                  errorStyle: TextStyle(height: 0),
                  prefixIcon: Icon(
                    Icons.gps_fixed,
                    size: 18,
                  ),
                  border: OutlineInputBorder(),
                  labelText: 'Coordenadas',
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            FilledButton(
                onPressed: () {
                  sendData();
                },
                child: Text("Mandar coordenadas")),
            SizedBox(
              height: 8,
            ),
            FilledButton(
                onPressed: () {
                  fetchData();
                },
                child: Text("Obtener Texto del Servidor"))
          ],
        ),
      ),
    );
  }
}
