import 'package:flutter/material.dart';
import 'package:flutter_project/common/widgets/appbar/app_bar.dart';
import 'package:flutter_project/common/widgets/button/basic_app_button.dart';
import 'package:flutter_project/core/configs/assets/app_vectors.dart';
import 'package:flutter_project/data/models/auth/signin_user_req.dart';
import 'package:flutter_project/domain/usecases/auth/signin.dart';
import 'package:flutter_project/presentation/auth/pages/signup.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../service_locator.dart';
import 'package:flutter_project/presentation/home/pages/home.dart';

class SigninPage extends StatelessWidget {
   SigninPage({super.key});

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: signupText(context), // Исправлено на signupText
      appBar: BasicAppbar(
        title: SvgPicture.asset(
          AppVectors.logo,
          height: 40,
          width: 40,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 50,
          horizontal: 30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _registerText(),
            const SizedBox(height: 85),
            _emailField(context),
            const SizedBox(height: 25),
            _passwordField(context),
            const SizedBox(height: 25),
            BasicAppButton(
              onPressed: () async{
                var result = await sl<SigninUseCase>().call(
                    params: SigninUserReq(
                        email: _email.text.toString(),
                        password: _password.text.toString()
                    )
                );
                result.fold(
                        (l){
                      var snackbar = SnackBar(content: Text(l));
                      ScaffoldMessenger.of(context).showSnackBar(snackbar);
                    },
                        (r){
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (BuildContext context) => const HomePage()),
                              (route) => false
                      );
                    }
                );
              },
              title: 'Sign In',
            ),
          ],
        ),
      ),
    );
  }

  Widget _registerText() {
    return const Text(
      'Sign In',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 33,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _emailField(BuildContext context) {
    return TextField(
      controller: _email,
      decoration: const InputDecoration(
        hintText: 'Enter Email',
      ).applyDefaults(
        Theme.of(context).inputDecorationTheme,
      ),
    );
  }

  Widget _passwordField(BuildContext context) {
    return TextField(
      controller: _password,
      decoration: const InputDecoration(
        hintText: 'Password',
      ).applyDefaults(
        Theme.of(context).inputDecorationTheme,
      ),
    );
  }

  Widget signupText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Not A Member?',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) =>  SignupPage()
                  )
              );
            },
            child: const Text('Register Now'),
          ),
        ],
      ),
    );
  }
}
