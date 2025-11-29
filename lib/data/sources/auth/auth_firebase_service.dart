import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_project/core/configs/constants/app_urls.dart';
import 'package:flutter_project/data/models/auth/create_user_req.dart';
import 'package:flutter_project/data/models/auth/signin_user_req.dart';
import 'package:flutter_project/data/models/auth/user.dart';
import 'package:flutter_project/domain/entities/auth/user.dart';

abstract class AuthFirebaseService {
  Future<Either<String, String>> signup(CreateUserReq createUserReq);
  Future<Either<String, String>> signin(SigninUserReq signinUserReq);

  Future<Either> getUser();
}

class AuthFirebaseServiceImpl extends AuthFirebaseService {
  @override
  Future<Either<String, String>> signup(CreateUserReq createUserReq) async {
    try {
      // Создание пользователя в Firebase Auth
      var userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: createUserReq.email,
        password: createUserReq.password,
      );

      // Сохранение данных пользователя в Firestore
      await FirebaseFirestore.instance.collection('Users').doc(userCredential.user?.uid)
      .set({
        'name': createUserReq.fullName,
        'email': createUserReq.email,
      });

      return const Right('Signup was Successful');
    } on FirebaseAuthException catch (e) {
      String message = '';

      if (e.code == 'weak-password') {
        message = 'The password provided is too weak';
      } else if (e.code == 'email-already-in-use') {
        message = 'An account already exists with that email';
      }

      return Left(message);
    }
  }

  @override
  Future<Either<String, String>> signin(SigninUserReq signinUserReq) async {
    try {
      // Вход пользователя в Firebase Auth
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: signinUserReq.email,
        password: signinUserReq.password,
      );

      return const Right('Signin was Successful');
    } on FirebaseAuthException catch (e) {
      String message = '';

      if (e.code == 'user-not-found') {
        message = 'No user found for that email';
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password provided for that user';
      }

      return Left(message);
    }
  }

  @override
  Future<Either> getUser() async {
    try {
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      var user = await firebaseFirestore.collection('Users').doc(
          firebaseAuth.currentUser?.uid
      ).get();

      UserModel userModel = UserModel.fromJson(user.data()!);
      userModel.imageURL =
          firebaseAuth.currentUser?.photoURL ?? AppURLs.defaultImage;
      UserEntity userEntity = userModel.toEntity();
      return Right(userEntity);
    }catch (e){
      return Left('An error occurred');
    }
  }
}
