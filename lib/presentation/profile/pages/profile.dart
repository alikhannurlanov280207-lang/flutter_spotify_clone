import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/common/helpers/is_dark_mode.dart';
import 'package:flutter_project/common/widgets/appbar/app_bar.dart';
import 'package:flutter_project/common/widgets/favorite_button/favorite_button.dart';
import 'package:flutter_project/core/app_colors.dart';
import 'package:flutter_project/presentation/profile/bloc/favorite_songs_cubit.dart';
import 'package:flutter_project/presentation/profile/bloc/favorite_songs_state.dart';
import 'package:flutter_project/presentation/profile/bloc/profile_info_cubit.dart';
import 'package:flutter_project/presentation/song_player/pages/song_player.dart';
import '../../../core/configs/constants/app_urls.dart';
import '../bloc/profile_info_state.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppbar(
        backgroundColor: context.isDarkMode ? const Color(0xff2C2B2B) : Colors.white,
        title: const Text('Profile'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _profileInfo(context),
          const SizedBox(height: 30),
          _favoriteSongs(),
        ],
      ),
    );
  }

  Widget _profileInfo(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileInfoCubit()..getUser(),
      child: Container(
        height: MediaQuery.of(context).size.height / 4.1,
        width: double.infinity,
        decoration: BoxDecoration(
          color: context.isDarkMode ? const Color(0xff2C2B2B) : Colors.white,
          borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(50),
            bottomLeft: Radius.circular(50),
          ),
        ),
        child: BlocBuilder<ProfileInfoCubit, ProfileInfoState>(
          builder: (context, state) {
            if (state is ProfileInfoLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is ProfileInfoLoaded) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(state.userEntity.imageURL!),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    state.userEntity.email!,
                    style: const TextStyle(fontSize: 19),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    state.userEntity.fullName!,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              );
            }
            if (state is ProfileInfoFailure) {
              return const Text('Please try again');
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget _favoriteSongs() {
    return BlocProvider(
      create: (context) => FavoriteSongsCubit()..getFavoriteSongs(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('FAVORITE SONGS'),
            const SizedBox(height: 20),
            BlocBuilder<FavoriteSongsCubit, FavoriteSongsState>(
              builder: (context, state) {
                if (state is FavoriteSongsLoading) {
                  return const CircularProgressIndicator();
                }
                if (state is FavoriteSongsLoaded) {
                  return ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final song = state.favoriteSongs[index];
                      String imageUrl;

                      switch (song.title.toLowerCase()) {
                        case 'lovely':
                          imageUrl = AppURLs.firestorage1;
                          break;
                        case 'in my feelings':
                          imageUrl = AppURLs.firestorage2;
                          break;
                        case 'shape of you':
                          imageUrl = AppURLs.firestorage3;
                          break;
                        case 'tonight':
                          imageUrl = AppURLs.firestorage4;
                          break;
                        case 'diamonds':
                          imageUrl = AppURLs.firestorage5;
                          break;
                        case 'one kiss':
                          imageUrl = AppURLs.firestorage6;
                          break;
                        default:
                          imageUrl = AppURLs.defaultImage;
                      }

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  SongPlayerPage(songEntity: state.favoriteSongs[index]),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 75,
                                  width: 75,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                      image: NetworkImage(imageUrl),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      song.title,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      song.artist,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  song.duration.toString().replaceAll('.', ':'),
                                ),
                                const SizedBox(width: 20),
                                FavoriteButton(
                                  songEntity: song,
                                  key: UniqueKey(),
                                  function: () {
                                    context.read<FavoriteSongsCubit>().removeSong(index);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(height: 20),
                    itemCount: state.favoriteSongs.length,
                  );
                }
                if (state is FavoriteSongsFailure) {
                  return const Text('Please try again');
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
