import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/presentation/home/bloc/song_player_state.dart';
import 'package:just_audio/just_audio.dart';

class SongPlayerCubit extends Cubit<SongPlayerState> {

  AudioPlayer audioPlayer = AudioPlayer();

  Duration songDuration = Duration.zero;
  Duration songPosition = Duration.zero;

  SongPlayerCubit() : super(SongPlayerLoading()) {

    audioPlayer.positionStream.listen((position) {
      songPosition = position;
      updateSongPlayer();
    });

    audioPlayer.durationStream.listen((duration) {
      songDuration = duration!;
    });
  }

  void updateSongPlayer(){
    emit(
      SongPlayerLoaded()
    );
  }

  Future<void> loadSong(List<String> urls) async {
    try {
      for (var url in urls) {
        await audioPlayer.setUrl(url);
        // Можно добавить логику для обработки нескольких песен
        break; // Удалите это, если хотите загрузить все песни
      }
      emit(SongPlayerLoaded());
    } catch (e) {
      emit(SongPlayerFailure());
    }
  }


  void playOrPauseSong() {
    if(audioPlayer.playing){
      audioPlayer.stop();
    } else{
      audioPlayer.play();
    }
    emit(
      SongPlayerLoaded()
    );
  }

  @override
  Future<void> close(){
    audioPlayer.dispose();
    return super.close();
  }
}