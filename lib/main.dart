import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'utils/navigation_bar.dart';
import 'pages/welcome_pg.dart';
import 'pages/result_pg.dart';

late List<CameraDescription> cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();

  runApp(HemoCycleApp());
}

class HemoCycleApp extends StatelessWidget {
  const HemoCycleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomePage(cameras: cameras),
      title: 'HemoCycleApp',
      theme: ThemeData(primarySwatch: Colors.red),
      routes: {
        '/results': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
          return ResultPage(resultData: args);
        },
      }
      ,
    );
  }
}
