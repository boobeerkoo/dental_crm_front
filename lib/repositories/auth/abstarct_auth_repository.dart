import 'package:dental_crm_flutter_front/repositories/auth/models/models.dart';

abstract class AbstractAuthRepository {
  Future<User> register(String email, String password);
  Future<User> login(String email, String password);
}
