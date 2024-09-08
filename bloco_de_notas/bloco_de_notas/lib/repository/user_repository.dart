import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserRepository extends GetConnect {
  final _url = 'http://172.20.240.1:8000';
  final http.Client _httpClient = http.Client();

  Future<void> loginUser(String userName, String password) async {
    
    final response = await http.post(
        Uri.parse('$_url/user/login'),
        headers: {
          'Content-Type': 'application/json'
        }, 
        body: json.encode({
          'userName': userName,
          'password': password
        }),
      );
 
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      

      if (data != null && data['token'] != null) {
        final preferece = await SharedPreferences.getInstance();
        await preferece.setString('token', data['token']);
        Get.offNamed('/home');
      }
    } else {
      print('Erro ao fazer login: ${response.body}');
      return null;
    }
  }

  Future<void> addUser(String userName, String password) async {
      final response = await _httpClient.post(
      Uri.parse('$_url/user/add'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'userName': userName,
        'password': password,
      }),
    );
    var data = json.decode(response.body);

    if (response.statusCode == 201) {
      print('Cadastrado!');
    } else {
      throw Exception('Erro ao adicionar usuário: ${response.body}');
    }
  }
}
