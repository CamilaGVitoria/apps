import 'dart:convert';

import 'package:bloco_de_notas/model/user.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class UserRepository extends GetConnect {
  Future<User?> loginUser(String userName, String password) async {
    final path = 'http://10.1.6.129:8000/user/login';

    final response = await http.post(Uri.parse(path), body: {
      'userName': userName,
      'password': password,
    });

    if (response.statusCode == 200) {
      final userJson = json.decode(response.body);
      return User.fromJson(userJson);
    } else {
      print('Erro ao fazer login: ${response.body}');
      return null;
    }
  }

  Future<User?> addUser(User user) async {
    final path = 'http://10.1.6.129:8000/user/add';
    final response = await http.post(
      Uri.parse(path),
      headers: {
        'Content-Type': 'application/json',
      },
      body: {'userName': user.userName, 'password': user.password},
    );

    if (response.statusCode == 200) {
      final userJson = json.decode(response.body);
      return User.fromJson(userJson);
    } else {
      throw Exception('Erro ao adicionar usuário: ${response.body}');
    }
  }
}
