import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/domain/entities/song/song.dart';
import 'package:flutter_project/domain/usecases/song/get_favorite_songs.dart';
import 'package:flutter_project/presentation/profile/bloc/favorite_songs_state.dart';

import '../../../service_locator.dart';

class FavoriteSongsCubit extends Cubit<FavoriteSongsState> {
  FavoriteSongsCubit() : super(FavoriteSongsLoading());

  Future<void> getFavoriteSongs() async {
    var result = await sl<GetFavoriteSongsUseCase>().call();

    result.fold(
          (l) {
        emit(FavoriteSongsFailure());
      },
          (r) {
        emit(FavoriteSongsLoaded(favoriteSongs: r));
      },
    );
  }

  // Метод удаления песни из списка избранных
  void removeSong(int index) {
    if (state is FavoriteSongsLoaded) {
      final currentState = state as FavoriteSongsLoaded;
      final updatedSongs = List<SongEntity>.from(currentState.favoriteSongs)
        ..removeAt(index); // Удаляем песню по индексу

      // Эмитируем новое состояние с обновленным списком песен
      emit(FavoriteSongsLoaded(favoriteSongs: updatedSongs));
    }
  }
}
