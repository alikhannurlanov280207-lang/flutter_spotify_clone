import 'package:flutter/material.dart';
import 'package:flutter_project/common/helpers/is_dark_mode.dart';
import 'package:flutter_project/common/widgets/appbar/app_bar.dart';
import 'package:flutter_project/common/widgets/button/basic_app_button.dart';
import 'package:flutter_project/core/configs/assets/app_images.dart';
import 'package:flutter_project/presentation/auth/pages/signin.dart';
import 'package:flutter_project/presentation/auth/pages/signup.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/app_colors.dart';
import '../../../core/configs/assets/app_vectors.dart';

class SignupOrSigninPage extends StatelessWidget {
  const SignupOrSigninPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BasicAppbar(),
          Align(
            alignment: Alignment.topRight,
            child: SvgPicture.asset(AppVectors.topPattern),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: SvgPicture.asset(AppVectors.bottomPattern),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Image.asset(AppImages.authBG),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(AppVectors.logo),
                  const SizedBox(
                    height: 55,
                  ),
                  const Text(
                    'Enjoy Listening To Music',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
                  const SizedBox(
                    height: 21,
                  ),
                  const Text(
                    'Spotify is a proprietary Swedish audio streaming and media services provider',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 19,
                      color: AppColors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: BasicAppButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                builder: (BuildContext context) => SignupPage(),
                            )
                            );
                          },
                          title: 'Register',
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 21,
                          ), // Добавляем текстовый стиль
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        flex: 1,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) => SigninPage(),
                                )
                            );
                          },
                          child: Text(
                            "Sign in",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 21,
                              color: context.isDarkMode
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
