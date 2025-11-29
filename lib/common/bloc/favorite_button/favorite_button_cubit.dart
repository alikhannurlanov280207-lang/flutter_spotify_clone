import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/domain/usecases/song/add_or_remove_favorite_song.dart';
import 'package:flutter_project/service_locator.dart';
import 'favorite_button_state.dart';

class FavoriteButtonCubit extends Cubit<FavoriteButtonState> {
  FavoriteButtonCubit() : super(FavoriteButtonInitial());

  Future<void> favoriteButtonUpdated(String songId) async {
    try {
      // Вызов use-case для добавления или удаления песни из избранного
      var result = await sl<AddOrRemoveFavoriteSongUseCase>().call(params: songId);

      // Обработка результата (успех или ошибка)
      result.fold(
            (failure) {
          // Лог или обработка ошибок, если необходима
          print('Error updating favorite: $failure');
        },
            (isFavorite) {
          // Эмитим новое состояние с обновленным статусом избранного
          emit(FavoriteButtonUpdated(isFavorite: isFavorite));
        },
      );
    } catch (e) {
      // В случае ошибки выбрасываем состояние неудачи, если есть
      print('Exception in favoriteButtonUpdated: $e');
    }
  }
}
