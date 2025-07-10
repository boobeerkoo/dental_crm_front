import 'package:dental_crm_flutter_front/repositories/user/models/user.dart';

abstract class AbstractUserRepository {
  Future<User> me();
}
