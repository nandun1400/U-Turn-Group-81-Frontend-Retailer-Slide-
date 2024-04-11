import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:goal_setting/pages/app_drawer.dart';
import 'package:goal_setting/pages/authentication/login/login_page.dart';
import 'package:goal_setting/pages/authentication/signup/signup_page.dart';
import 'package:goal_setting/pages/home_page.dart';
import 'package:goal_setting/pages/homepage/createVehicleModelPage.dart';
import 'data_classes/vehicle_dummy_data.dart';
import 'global/global_settings.dart';
import 'pages/splash/splash_screen.dart';
import 'package:provider/provider.dart';
import 'utils/theme.dart';

void main() {
  // if(globalData.recreateDummy) sendDataToBackend(DummyData);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // System UI Configuration
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.bottom,
    ]);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
      ),
    );
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.immersiveSticky,
    );

    return MaterialApp(
      theme: AppTheme.themeData,
      // home: SplashScreen(), // Set SplashScreen as the initial route
      // initialRoute:'/home',
      initialRoute:'/splash',
      routes: {
        '/splash': (context) => SplashScreen(),

        '/login': (context) => LoginPage(),
        '/signup': (context) => SignUpPage(),
        '/home': (context) => HomePage(),

        '/page1': (context) => Page2(),
        '/page2': (context) => Page2(),
        '/page3': (context) => NewVehiclePage(),
        '/page4': (context) => Page4(),

        '/AppDrawerpage1': (context) => AppDrawerPage2(),
        '/AppDrawerpage2': (context) => AppDrawerPage2(),
        '/AppDrawerpage3': (context) => AppDrawerPage3(),
        '/AppDrawerpage4': (context) => AppDrawerPage4(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
