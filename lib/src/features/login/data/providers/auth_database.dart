import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';
import 'package:works_app/src/core/firebase/external/firebase_config.dart';
import 'package:works_app/src/features/login/data/repositorys/login_repository.dart';
import 'package:works_app/src/features/login/domain/entities/login_entity.dart';

class LoginDatasourceImpl implements LoginRepositoryImpl{
  @override
  Future<LoginEntity?> signUp(String email, String password) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      String? token = await FCM().getToken();
      var box = await Hive.openBox('tokenBox');
      await box.put('token', token!);
      return LoginEntity(userName: userCredential.user?.email);
    } catch (e) {
      print('Erro de login: $e');
    }
    return null;
  }

  @override
  Future<bool> signOut() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();
    return true;
  }
}