import 'dart:async';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutterbluetothdevices/common/abstraction/failure.dart';
import 'package:flutterbluetothdevices/common/abstraction/result.dart';
import 'package:flutterbluetothdevices/common/service/failure_service.dart';

class BluetoothService {
  StreamController<Either<Failure, Result<List<ScanResult>>>> deviceStream =
      new StreamController.broadcast();

  //Init service
  BluetoothService._privateConstructor();

  static final BluetoothService _instance =
      BluetoothService._privateConstructor();

  static BluetoothService get instance => _instance;
//
  Future<Either<Failure, bool>> turnOnBluetooth() async {
    try {
      // checking the bluetooth is supported by your hardware
      if (await FlutterBluePlus.isSupported == false) {
        return Left(ServiceFailure('not supported'));
      }

// turn on bluetooth
      if (Platform.isAndroid) {
        await FlutterBluePlus.turnOn();
        return Right(true);
      }
      return Left(ServiceFailure('platform does not support'));
    } catch (e) {
      return Left(ServiceFailure('something wrong happend'));
    }
  }

  listenDevices() async {
    StreamSubscription<List<ScanResult>>? subscription;
// // listen to scan results
    subscription = FlutterBluePlus.onScanResults.listen(
      (results) {
// deviceStream
        deviceStream.sink.add(Right(Fetching(results)));
      },
      onError: (e) {
        deviceStream.sink.add(Left(ServiceFailure(e.toString())));
      },
      onDone: () {
        Right(Complete());
        subscription?.cancel();
      },
    );

//     await FlutterBluePlus.adapterState
//         .where((val) => val == BluetoothAdapterState.on)
//         .first;
    await scanDevices();
// // Start scanning
//     await FlutterBluePlus.startScan();

// // Stop scanning
//     await FlutterBluePlus.stopScan();

// // cancel to prevent duplicate listeners
//     subscription.cancel();
  }

  scanDevices() async {
    await FlutterBluePlus.startScan();
  }

  stopScan() async {
    await FlutterBluePlus.stopScan();
  }
}
