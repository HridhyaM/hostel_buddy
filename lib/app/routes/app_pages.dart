import 'package:get/get.dart';
import 'package:hostel_buddy/app/routes/app_routes.dart';
import 'package:hostel_buddy/modules/booking/view/booking_page.dart';
import 'package:hostel_buddy/modules/registration/views/registration_view.dart';
import 'package:hostel_buddy/modules/splash/views/splash_view.dart';


class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.splash,
      page: () => SplashView(),
    ),
      GetPage(
      name: AppRoutes.registration,
      page: () => RegistrationForm(),
    ),
      GetPage(
      name: AppRoutes.booking,
      page: () => BookingPage(),
    ),
  ];
}
