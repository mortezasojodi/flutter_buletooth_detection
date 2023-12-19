import 'package:flutterbluetothdevices/presentation/home/home_binding.dart';
import 'package:flutterbluetothdevices/presentation/home/home_page.dart';
import 'package:flutterbluetothdevices/routes/app_routes.dart';
import 'package:get/route_manager.dart';

class AppPages {
  static const INITIAL_ROUTE = AppRoutes.home;
  static final List<GetPage> pages = [
    GetPage(
        name: AppRoutes.home, page: () => HomePage(), binding: HomeBinding())
  ];
}
