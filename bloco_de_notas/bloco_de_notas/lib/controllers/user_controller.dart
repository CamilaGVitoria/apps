import 'package:bloco_de_notas/model/user.dart';
import 'package:bloco_de_notas/repository/user_repository.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  final UserRepository _userRepository = UserRepository();

  Future<void> login(String userName, String password) async {
    try {
      await _userRepository.loginUser(userName, password);
    } catch (e) {
      print('Erro ao fazer login: $e');
    } 
  }

  Future<void> addUser(User user) async {
    try {
      await _userRepository.addUser(user);
    } catch (e) {
      print('Erro ao registrar usuário: $e');
    }
  }
}
