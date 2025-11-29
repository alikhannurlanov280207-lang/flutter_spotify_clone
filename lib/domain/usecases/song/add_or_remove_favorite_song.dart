import 'package:dartz/dartz.dart';
import 'package:flutter_project/core/usecase/usecase.dart';
import 'package:flutter_project/domain/repository/song/song.dart';

import '../../../service_locator.dart';

class AddOrRemoveFavoriteSongUseCase implements UseCase<Either, String> {
  final SongsRepository repository;

  AddOrRemoveFavoriteSongUseCase(this.repository);

  @override
  Future<Either> call({String ? params}) async {
    return await sl<SongsRepository>().addOrRemoveFavoriteSongs(params!);
  }
}
