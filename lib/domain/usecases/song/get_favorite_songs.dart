import 'package:dartz/dartz.dart';
import 'package:flutter_project/core/usecase/usecase.dart';
import 'package:flutter_project/domain/repository/song/song.dart';

import '../../../service_locator.dart';

class GetFavoriteSongsUseCase implements UseCase<Either, void> {
  final SongsRepository repository;

  GetFavoriteSongsUseCase(this.repository);

  @override
  Future<Either> call({void params}) async {
    return await sl<SongsRepository>().getUserFavoriteSongs();
  }
}
