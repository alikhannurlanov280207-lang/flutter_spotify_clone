import 'package:flutter_project/core/usecase/usecase.dart';
import 'package:flutter_project/domain/repository/song/song.dart';
import '../../../service_locator.dart';

class IsFavoriteSongUseCase implements UseCase<bool, String> {
  final SongsRepository repository;

  IsFavoriteSongUseCase(this.repository);

  @override
  Future<bool> call({String ? params}) async {
    return await sl<SongsRepository>().isFavoriteSong(params!);
  }
}
