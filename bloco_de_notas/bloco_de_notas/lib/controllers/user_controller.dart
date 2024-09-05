import 'package:bloco_de_notas/model/user.dart';
import 'package:bloco_de_notas/repository/user_repository.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  var user = Rxn<User>();
  var isLoading = false.obs;

  final UserRepository userRepository = UserRepository();

  Future<void> login(String userName, String password) async {
    isLoading(true);
    try {
      final loggedUser = await userRepository.loginUser(userName, password);

      if (loggedUser != null) {
        user.value = loggedUser;
      } else {
        print('Falha ao fazer login: Verifique os dados!');
      }
    } catch (e) {
      print('Erro ao fazer login: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> register(User newUser) async {
    isLoading(true);
    try {
      final registeredUser = await userRepository.addUser(newUser);

      if (registeredUser != null) {
        user.value = registeredUser;
      }
    } catch (e) {
      print('Erro ao registrar usuário: $e');
    } finally {
      isLoading(false);
    }
  }
}
