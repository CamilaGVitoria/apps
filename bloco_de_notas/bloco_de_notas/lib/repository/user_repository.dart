import 'package:bloco_de_notas/model/user.dart';
import 'package:get/get.dart';

class UserRepository extends GetConnect{
  Future<User?> loginUser(String userName, String password) async{

    var path = 'http://192.168.1.13:8000/user/login';

    final response = await post(path, {
      'userName' : userName,
      'password' : password,
    });

    if (response.status.hasError) {
      throw Exception('Erro ao fazer login: ${response.statusText}');
    }

    final user = User.fromJson(response.body);
    return user;
  }

  Future<User?> addUser(User user) async {
    final path = 'http://192.168.1.13:8000/user/add';
    final response = await post(path, user.toJson());

    if (response.status.hasError) {
      throw Exception('Erro ao adicionar usuário: ${response.statusText}');
    }

    return User.fromJson(response.body);
  }
}