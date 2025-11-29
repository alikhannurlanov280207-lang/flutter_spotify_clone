import 'package:flutter/material.dart';
import 'package:flutter_project/common/widgets/button/basic_app_button.dart';
import 'package:flutter_project/core/app_colors.dart';
import 'package:flutter_project/core/configs/assets/app_images.dart';
import 'package:flutter_project/core/configs/assets/app_vectors.dart';
import 'package:flutter_project/presentation/choose_mode/pages/choose_mode.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GetStartedPage extends StatelessWidget{
  const GetStartedPage ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 37,
              horizontal: 37,
            ),
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(
                      AppImages.introBG,
                    )
                )
            ),
          ),

          Container(
            color: Colors.black.withOpacity(0.15),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(
                vertical:40,
                horizontal: 40
            ),
            child: Column(
              children: [
                SizedBox(height: 30),
                Align(
                  alignment: Alignment.topCenter,
                  child: SvgPicture.asset(
                      AppVectors.logo
                  ),
                ),
                Spacer(),
                const Text(
                  'Enjoy Listening To Music',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 23
                  ),
                ),
                SizedBox(height: 21,),
                const Text(
                  'Dive into endless playlists, discover new tracks, and enjoy your favorite tunes — all in one place. Let the music move you.',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: AppColors.grey,
                      fontSize: 17
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20,),
                BasicAppButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => const ChooseModePage()
                        )
                    );
                  },
                  title: 'Get Started' ,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}