import 'package:health/health.dart';

class SleepData {
  HealthFactory health = HealthFactory();

  Future<double?> fetchStepData() async {
    double? sleep = 0;
    String sleep2 = 'hi';
    final types = [
      HealthDataType.SLEEP_IN_BED,
    ];
    List<HealthDataPoint> healthData = [];

    final now = DateTime.now();

    final from = DateTime.now().subtract(const Duration(days: 1));

    bool requested = await health.requestAuthorization(types);

    if (requested) {
      try {
        healthData = await health.getHealthDataFromTypes(from, now, types);
        //healthData.addAll(healthData);
        print('Permiso');
      } catch (error) {
        print("Caught exception in getTotalStepsInInterval: $error");
      }

      sleep2 = "${healthData[0].value}";
      sleep = double.parse(sleep2);
      print('Horas dormidas: $sleep');
      return sleep;
    } else {
      print("Authorization not granted - error in authorization");
    }
  }
}
