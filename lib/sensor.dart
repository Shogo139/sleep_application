import 'dart:math';
import 'package:sensors_plus/sensors_plus.dart';

class SleepSensor {
  double acceleration = 0.0;  //加速度
  double threshold = 1.0;   //閾値設定
  bool isLightSleep = false;    //浅い眠りか
//眠りの深さの判定
  void listenToSensor(void Function(double, bool) onData) {
    accelerometerEvents.listen((AccelerometerEvent event) {
      //加速度計算
      acceleration = sqrt(event.x * event.x + event.y * event.y + event.z * event.z);
      //眠りの深さの判定
      isLightSleep = acceleration > threshold;
      //コールバックでデータを返す
      onData(acceleration, isLightSleep);
    });
  }
}
