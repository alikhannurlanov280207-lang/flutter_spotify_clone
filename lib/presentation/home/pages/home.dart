import 'package:flutter/material.dart';
import 'package:flutter_project/common/helpers/is_dark_mode.dart';
import 'package:flutter_project/common/widgets/appbar/app_bar.dart';
import 'package:flutter_project/core/app_colors.dart';
import 'package:flutter_project/core/configs/assets/app_images.dart';
import 'package:flutter_project/presentation/home/widgets/news_songs.dart';
import 'package:flutter_project/presentation/home/widgets/play_list.dart';
import 'package:flutter_project/presentation/profile/pages/profile.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/configs/assets/app_vectors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState(){
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    // Получаем яркость темы (темная или светлая)
    // final brightness = Theme.of(context).brightness;

    return Scaffold(
      // body: Container(
      //   color: brightness == Brightness.dark ? Colors.black : Colors.white, // Цвет фона в зависимости от темы
      // ),
      appBar: BasicAppbar(
        hideBack: true,
        action: IconButton(
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (BuildContext context) => const ProfilePage())
              );
            },
            icon: const Icon(
              Icons.person
            )
        ),
        title: SvgPicture.asset(
          AppVectors.logo,
          height: 40,
          width: 40,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _homeTopCard(),
            _tabs(),
            SizedBox(
              height: 260,
              child: TabBarView(
                controller: _tabController,
                children:[
                  const NewsSongs(),
                  Container(),
                  Container(),
                  Container()
                ],
              ),
            ),
            const PlayList()
          ],
        ),
      ),
    );
  }

  Widget _homeTopCard(){
    return Center(
      child: SizedBox(
        height: 165,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: SvgPicture.asset(
                AppVectors.homeTopCard,
                width: 390,
              ),
            ),

            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(
                    right: 60
                ),
                child: Image.asset(
                    AppImages.homeArtist
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _tabs(){
    return TabBar(
      controller: _tabController,
      isScrollable: true,
      labelColor: context.isDarkMode ? Colors.white : Colors.black,
      indicatorColor: AppColors.primary,
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 1,
      ),

      tabs: const [
        Text(
          'News',
          style: TextStyle(
              fontSize: 19,
            fontWeight: FontWeight.w500
          ),
        ),
        Text(
          'Videos',
          style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w500
          ),
        ),
        Text(
          'Artists',
          style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w500
          ),
        ),
        Text(
          'Podcasts',
          style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w500
          ),
        ),
      ],
    );
  }
}