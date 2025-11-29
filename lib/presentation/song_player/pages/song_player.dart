import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/common/widgets/appbar/app_bar.dart';
import 'package:flutter_project/common/widgets/favorite_button/favorite_button.dart';
import 'package:flutter_project/domain/entities/song/song.dart';
import 'package:flutter_project/presentation/home/bloc/song_player_cubit.dart';
import 'package:flutter_project/presentation/home/bloc/song_player_state.dart';

import '../../../core/app_colors.dart';
import '../../../core/configs/constants/app_urls.dart';

class SongPlayerPage extends StatelessWidget {
  final SongEntity songEntity;

  const SongPlayerPage({
    required this.songEntity,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppbar(
        title: const Text(
          'Now playing',
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.w500,
          ),
        ),
        action: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.more_vert_rounded),
        ),
      ),
      body: BlocProvider(
        create: (_) {
          String songUrl;
          switch (songEntity.title) {
            case 'lovely':
              songUrl = AppURLs.songFirestorage1;
              break;
            case 'Shape of You':
              songUrl = AppURLs.songFirestorage3;
              break;
            case 'In My Feelings':
              songUrl = AppURLs.songFirestorage2;
              break;
            case 'Tonight':
              songUrl = AppURLs.songFirestorage4;
              break;
            case 'Diamonds':
              songUrl = AppURLs.songFirestorage5;
              break;
            case 'One Kiss':
              songUrl = AppURLs.songFirestorage6;
              break;
            default:
              songUrl = AppURLs.songFirestorage1;
          }

          return SongPlayerCubit()..loadSong([songUrl]);
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Column(
            children: [
              _songCover(context),
              const SizedBox(height: 20),
              _songDetail(),
              const SizedBox(height: 30),
              _songPlayer(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _songCover(BuildContext context) {
    String imageUrl;

    switch (songEntity.title) {
      case 'You Know You Like It':
      case 'lovely':
        imageUrl = AppURLs.firestorage1;
        break;
      case 'Shape of You':
        imageUrl = AppURLs.firestorage3;
        break;
      case 'In My Feelings':
        imageUrl = AppURLs.firestorage2;
        break;
      case 'Tonight':
        imageUrl = AppURLs.firestorage4;
        break;
      case 'Diamonds':
        imageUrl = AppURLs.firestorage5;
        break;
      case 'One Kiss':
        imageUrl = AppURLs.firestorage6;
        break;
      default:
        imageUrl = AppURLs.firestorage1;
    }

    return Container(
      height: MediaQuery.of(context).size.height / 2,
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(imageUrl),
        ),
      ),
    );
  }

  Widget _songDetail() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              songEntity.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              songEntity.artist,
              style: const TextStyle(
                fontWeight:FontWeight.w400,
                fontSize: 18,
              ),
            ),
          ],
        ),
        FavoriteButton(songEntity: songEntity),
      ],
    );
  }

  Widget _songPlayer(BuildContext context) {
    return BlocBuilder<SongPlayerCubit, SongPlayerState>(
      builder: (context, state) {
        if (state is SongPlayerLoading) {
          return const CircularProgressIndicator();
        }
        if (state is SongPlayerLoaded) {
          return Column(
            children: [
              Slider(
                value: context.read<SongPlayerCubit>().songPosition.inSeconds.toDouble(),
                min: 0.0,
                max: context.read<SongPlayerCubit>().songDuration.inSeconds.toDouble(),
                onChanged: (value) {},
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(formatDuration(context.read<SongPlayerCubit>().songPosition)),
                  Text(formatDuration(context.read<SongPlayerCubit>().songDuration)),
                ],
              ),
              const SizedBox(height: 20),

              // Кнопки управления воспроизведением
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Кнопка предыдущего трека
                  IconButton(
                    onPressed: () {
                      // Логика для перехода на предыдущий трек
                    },
                    icon: const Icon(Icons.skip_previous),
                    iconSize: 40,
                    color: const Color(0xFF363636),
                  ),

                  const SizedBox(width: 20), // Отступ между кнопками

                  // Кнопка воспроизведения/паузы
                  GestureDetector(
                    onTap: () {
                      context.read<SongPlayerCubit>().playOrPauseSong();
                    },
                    child: Container(
                      height: 70,
                      width: 70,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primary,
                      ),
                      child: Icon(
                        context.read<SongPlayerCubit>().audioPlayer.playing ? Icons.pause : Icons.play_arrow,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  const SizedBox(width: 20), // Отступ между кнопками

                  // Кнопка следующего трека
                  IconButton(
                    onPressed: () {
                      // Логика для перехода на следующий трек
                    },
                    icon: const Icon(Icons.skip_next),
                    iconSize: 40,
                    color: const Color(0xFF363636),
                  ),
                ],
              ),
            ],
          );
        }

        return Container();
      },
    );
  }

  String formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}
