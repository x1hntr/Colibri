import 'package:health/health.dart';

class StepData {
  HealthFactory health = HealthFactory();
  int _nofSteps = 10;
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

      /*setState(() {
        _nofSteps = (steps == null) ? 0 : steps;
        _state = (steps == null) ? AppState.NO_DATA : AppState.STEPS_READY;
      }
      );*/
      return steps;
    } else {
      print("Authorization not granted - error in authorization");

      //setState(() => _state = AppState.DATA_NOT_FETCHED);
    }
  }
}
