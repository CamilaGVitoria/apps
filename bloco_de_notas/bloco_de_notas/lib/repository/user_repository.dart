import 'dart:convert';
import 'package:bloco_de_notas/model/user.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserRepository extends GetConnect {
  final _url = 'http://10.1.6.59:8000';
  final http.Client _httpClient = http.Client();

  Future<void> loginUser(String userName, String password) async {
    
    final response = await http.put(
        Uri.parse('$_url/user/login'),
        headers: {
          'Content-Type': 'application/json'
        }, 
        body: json.encode({
          'userName': userName,
          'password': password
        }),
      );
    print('$_url/user/login');
    print('Nome:${userName}');
    print('PassWord:${password}');

    var data = json.decode(response.body);

    print('Token gerado ${data['token']}');
    print('Mensagem ${data['msg']}');
    print('codigo login:${response.statusCode}');

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

  Future<User?> addUser(User user) async {
    print('CADASTROOOOOOOOOOOOO');
    final response = await _httpClient.post(
      Uri.parse('$_url/user/add'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'userName': user.userName,
        'password': user.password,
      }),
    );
    var data = json.decode(response.body);
    print('Mensagem ${data['msg']}');
    print('codigo REG:${response.statusCode}');

    if (response.statusCode == 200) {
      final userJson = json.decode(response.body);
      return User.fromJson(userJson);
    } else {
      throw Exception('Erro ao adicionar usuário: ${response.body}');
    }
  }
}
