import 'package:health/health.dart';

class StepData {
  HealthFactory health = HealthFactory();
  int _nofSteps = 0;

  Future<int?> fetchStepData() async {
    int? steps;
    final now = DateTime.now();
    final midnight = DateTime(now.year, now.month, now.day);

    bool requested = await health.requestAuthorization([HealthDataType.STEPS]);
    if (requested) {
      try {
        steps = await health.getTotalStepsInInterval(midnight, now);
      } catch (error) {
        print("Caught exception in getTotalStepsInInterval: $error");
      }
      print('Numero de pasos: $steps');
      return steps;
    } else {
      print("Authorization not granted - error in authorization");
    }
  }
}
