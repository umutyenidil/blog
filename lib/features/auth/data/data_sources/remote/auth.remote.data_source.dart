import 'package:supabase_flutter/supabase_flutter.dart';

import '../../models/user.model.dart';

abstract interface class AuthRemoteDataSource {
  Session? get currentUserSession;

  Future<UserModel?> getCurrentUserData();

  Future<UserModel> registerWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<UserModel> loginWithEmailAndPassword({
    required String email,
    required String password,
  });
}


