import 'package:dartz/dartz.dart';
import 'package:flutter_project/core/usecase/usecase.dart';
import 'package:flutter_project/data/repository/auth/auth_repository_impl.dart';
import 'package:flutter_project/data/sources/auth/auth_firebase_service.dart';
import 'package:flutter_project/domain/repository/auth/auth.dart';
import 'package:flutter_project/service_locator.dart';
import '../../../data/models/auth/create_user_req.dart';

class SignupUseCase implements UseCase<Either,CreateUserReq>{
  @override
  Future<Either> call ({CreateUserReq ? params}) async{
    return sl<AuthRepository>().signup(params!);
  }
}