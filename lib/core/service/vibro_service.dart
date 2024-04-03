import 'package:vibration/vibration.dart';

class VibroService {
  int _lastDurationValue = 0;
  void execVibration([int value = -1]) async {
    bool hasVibration = await Vibration.hasVibrator() ?? false;
    if (_lastDurationValue != value || _lastDurationValue == -1) {
      _lastDurationValue = value;
      if (hasVibration) {
            if (await Vibration.hasCustomVibrationsSupport() ?? false) {
              if (await Vibration.hasAmplitudeControl() ?? false) {
                Vibration.vibrate(duration: 500, amplitude: 50);
                Vibration.vibrate(duration: 500, amplitude: 100);
                Vibration.vibrate(duration: 500, amplitude: 50);
                Vibration.vibrate(duration: 500, amplitude: 200);
              }else{
                Vibration.vibrate(duration: 2000);
              }
            }else{
              for(int i = 0; i < 2; i++){
                Vibration.vibrate();
                Future.delayed(const Duration(milliseconds: 500));
              }
            }
          }
    }
  }
}
