import 'package:flutter_project/data/models/auth/signin_user_req.dart';
import 'package:flutter_project/data/repository/auth/auth_repository_impl.dart';
import 'package:flutter_project/data/repository/song/song_repository_impl.dart';
import 'package:flutter_project/data/sources/auth/auth_firebase_service.dart';
import 'package:flutter_project/domain/repository/auth/auth.dart';
import 'package:flutter_project/domain/repository/song/song.dart';
import 'package:flutter_project/domain/usecases/auth/get_user.dart';
import 'package:flutter_project/domain/usecases/auth/signin.dart';
import 'package:flutter_project/domain/usecases/auth/signup.dart';
import 'package:flutter_project/domain/usecases/song/add_or_remove_favorite_song.dart';
import 'package:flutter_project/domain/usecases/song/get_news_songs.dart';
import 'package:flutter_project/domain/usecases/song/is_favorite_song.dart';
import 'package:flutter_project/domain/usecases/song/get_favorite_songs.dart'; // Импортируем новый use case
import 'package:get_it/get_it.dart';

import 'data/sources/song/song_firebase_service.dart';
import 'domain/usecases/song/get_play_list.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Регистрация сервисов Firebase
  sl.registerSingleton<AuthFirebaseService>(
    AuthFirebaseServiceImpl(),
  );

  sl.registerSingleton<SongFirebaseService>(
    SongFirebaseServiceImpl(),
  );

  // Регистрация репозиториев
  sl.registerSingleton<AuthRepository>(
    AuthRepositoryImpl(),
  );

  sl.registerSingleton<SongsRepository>(
    SongRepositoryImpl(),
  );

  // Регистрация юзкейсов для аутентификации
  sl.registerSingleton<SignupUseCase>(
    SignupUseCase(),
  );

  sl.registerSingleton<SigninUseCase>(
    SigninUseCase(),
  );

  sl.registerSingleton<GetUserUseCase>(
    GetUserUseCase(),
  );

  // Регистрация юзкейсов для песен
  sl.registerSingleton<GetNewsSongsUseCase>(
    GetNewsSongsUseCase(sl<SongsRepository>()),
  );

  sl.registerSingleton<GetPlayListUseCase>(
    GetPlayListUseCase(sl<SongsRepository>()),
  );

  sl.registerSingleton<AddOrRemoveFavoriteSongUseCase>(
    AddOrRemoveFavoriteSongUseCase(sl<SongsRepository>()),
  );

  sl.registerSingleton<IsFavoriteSongUseCase>(
    IsFavoriteSongUseCase(sl<SongsRepository>()),
  );

  // Регистрация use case для получения избранных песен
  sl.registerSingleton<GetFavoriteSongsUseCase>(
    GetFavoriteSongsUseCase(sl<SongsRepository>()),
  );
}
