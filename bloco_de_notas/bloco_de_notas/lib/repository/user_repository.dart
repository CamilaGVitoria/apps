import 'package:bloco_de_notas/model/user.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class UserRepository extends GetConnect{
  Future<User?> loginUser(String userName, String password) async{

    final path = 'http://10.1.4.175:8000/user/login';

    final response = await http.post(Uri.parse(path), body: {
      'userName' : userName,
      'password' : password,
    });

    if (response.statusCode != 200) {
      print('Erro ao fazer login: ${response.body}');
    }
  }

  Future<User?> addUser(User user) async {
    final path = 'http://10.1.4.175:8000/user/add';
    final response = await http.post(Uri.parse(path), body: {
      'userName' : user.userName,
      'password' : user.password
    });

    if (response.statusCode != 200) {
      throw Exception('Erro ao adicionar usuário: ${response.body}');
    }
  }
}