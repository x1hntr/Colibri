import 'package:health/health.dart';

class StepData {
  HealthFactory health = HealthFactory();

  final allTypes = [
    HealthDataType.STEPS,
    HealthDataType.SLEEP_IN_BED,
    HealthDataType.ACTIVE_ENERGY_BURNED
  ];

  Future<bool> initRequest() async {
    try {
      bool requested = false;
      requested = await health.requestAuthorization(allTypes);
      return requested;
    } catch (e) {
      return false;
    }
  }

  Future<int?> fetchStepData(bool requested) async {
    int? steps;
    double? sleep = 0;
    final now = DateTime.now();
    final midnight = DateTime(now.year, now.month, now.day);
    // bool requested = await health.requestAuthorization([
    //   HealthDataType.STEPS,
    //   HealthDataType.SLEEP_IN_BED,
    //   HealthDataType.ACTIVE_ENERGY_BURNED
    // ]);
    if (requested) {
      try {
        steps = await health.getTotalStepsInInterval(midnight, now);
      } catch (error) {
        print("Error getTotalStepsInInterval: $error");
      }
      print('Numero de pasos: $steps');
      return steps;
    } else {
      print("Error de autorizacion");
    }
    return null;
  }
}

class SleepData {
  HealthFactory health = HealthFactory();
  Future<double?> fetchStepData(bool requested) async {
    double? sleep = 0;
    String sleep2 = 'hi';
    final types = [
      HealthDataType.SLEEP_IN_BED,
      HealthDataType.ACTIVE_ENERGY_BURNED,
    ];
    List<HealthDataPoint> healthData = [];
    final now = DateTime.now();
    final from = DateTime.now().subtract(const Duration(days: 1));
    // bool requested = await health.requestAuthorization(types);
    if (requested) {
      try {
        healthData = await health.getHealthDataFromTypes(from, now, types);
      } catch (error) {
        print("Error getTotalStepsInInterval: $error");
      }
      sleep2 = "${healthData[0].value}";
      sleep = double.parse(sleep2);
      print("CALORIAS ${healthData[1].value}");
      return sleep;
    } else {
      print("Error de autorizacion");
    }
    return null;
  }
}

class CalData {
  HealthFactory health = HealthFactory();
  Future<double?> fetchStepData(bool requested) async {
    double? calories = 0;
    String sleep2 = 'hi';
    final types = [
      HealthDataType.ACTIVE_ENERGY_BURNED,
    ];
    List<HealthDataPoint> healthData = [];
    final now = DateTime.now();
    final from = DateTime.now().subtract(const Duration(days: 1));
    // bool requested = await health.requestAuthorization(types);
    if (requested) {
      try {
        healthData = await health.getHealthDataFromTypes(from, now, types);
      } catch (error) {
        print("Error getTotalStepsInInterval: $error");
      }

      sleep2 = "${healthData[0].value}";
      calories = double.parse(sleep2);
      print("CALORIAS ${healthData[0].value}");
      return calories;
    } else {
      print("Error de autorizacion");
    }
    return null;
  }
}
