import 'package:flutter/material.dart';
import 'package:flutterbluetothdevices/presentation/home/home_page_controller.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return controller.obx((s) => Builder(builder: (context) {
          return SafeArea(
            child: Scaffold(
              body: _body(context),
            ),
          );
        }));
  }

  Widget _body(BuildContext context) {
    return GetX<HomeController>(builder: (context) {
      return ListView.builder(
          padding: EdgeInsets.all(20),
          itemCount: controller.models.length,
          itemBuilder: (c, i) {
            var model = controller.models[i];
            return Text(
                "rssid: ${model.rssi} remootId: ${model.device.remoteId}");
          });
    });
  }
}
