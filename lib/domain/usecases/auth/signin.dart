import 'package:dartz/dartz.dart';
import 'package:flutter_project/core/usecase/usecase.dart';
import 'package:flutter_project/data/models/auth/signin_user_req.dart';
import 'package:flutter_project/data/repository/auth/auth_repository_impl.dart';
import 'package:flutter_project/data/sources/auth/auth_firebase_service.dart';
import 'package:flutter_project/domain/repository/auth/auth.dart';
import 'package:flutter_project/service_locator.dart';
import '../../../data/models/auth/create_user_req.dart';

class SigninUseCase implements UseCase<Either,SigninUserReq>{
  @override
  Future<Either> call ({SigninUserReq ? params}) async{
    return sl<AuthRepository>().signin(params!);
  }
}