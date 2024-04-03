import 'package:just_audio/just_audio.dart';

String tickerPath = 'assets/match/timer_beat.wav';
String whistlePath = 'assets/match/whistle.wav';

class TickerPlayer extends AudioService {
  TickerPlayer() : super(assetPath: tickerPath, mode: LoopMode.one);
}

class WhistlePlayer extends AudioService {
  WhistlePlayer() : super(assetPath: whistlePath);
}

abstract class AudioService {
  final AudioPlayer _audioPlayer;
  final String _assetPath;

  AudioService({required String assetPath, LoopMode mode = LoopMode.off})
      : _assetPath = assetPath,
        _audioPlayer = AudioPlayer() {
    _audioPlayer.setLoopMode(mode);
  }

  void play() {
    _audioPlayer.setAsset(_assetPath);
    _audioPlayer.play();
  }

  void stop() async {
    _audioPlayer.dispose();
  }
}
