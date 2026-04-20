import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/entities/user.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, User>> signupWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<Either<Failure, User>> signinWithEmailPassword({
    required String email,
    required String password,
  });

  Future<Either<Failure, User>> getUser();
}
