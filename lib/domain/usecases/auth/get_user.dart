import 'package:dartz/dartz.dart';
import 'package:flutter_project/core/usecase/usecase.dart';
import 'package:flutter_project/data/models/auth/signin_user_req.dart';
import 'package:flutter_project/data/sources/auth/auth_firebase_service.dart';
import 'package:flutter_project/domain/repository/auth/auth.dart';
import 'package:flutter_project/service_locator.dart';

class GetUserUseCase implements UseCase<Either,dynamic>{
  @override
  Future<Either> call({params}) async{
    return await sl<AuthRepository>().getUser();
  }
}
