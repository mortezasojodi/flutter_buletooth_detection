import 'package:flutter_blue_plus/flutter_blue_plus.dart' as model;
import 'package:flutterbluetothdevices/common/abstraction/failure.dart';
import 'package:flutterbluetothdevices/common/abstraction/result.dart';
import 'package:flutterbluetothdevices/common/service/bluetooth/bluetooth_service.dart';
import 'package:get/get.dart';
import 'package:dartz/dartz.dart';

class HomeController extends GetxController with StateMixin {
  final models = <model.ScanResult>[].obs;
  @override
  void onInit() {
    init();
    super.onInit();
  }

  init() async {
    trunOnBluetooth();
  }

  trunOnBluetooth() async {
    var result = await BluetoothService.instance.turnOnBluetooth();
    result.fold((l) => change('error', status: RxStatus.empty()), (r) {
      scanDevices();
    });
  }

  chechData(Either<Failure, Result<List<model.ScanResult>>> result) {
    result.fold((l) => change('error', status: RxStatus.empty()), (r) {
      change('', status: RxStatus.success());
      successStates(r);
    });
  }

  scanDevices() async {
    BluetoothService.instance.deviceStream.stream.listen((result) {
      chechData(result);
    });
    await BluetoothService.instance.listenDevices();
  }

  successStates(Result<List<model.ScanResult>> result) {
    if (result is Fetching) {
      models(result.data ?? []);
    }
  }
}
