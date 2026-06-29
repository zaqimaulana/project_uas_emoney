import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/router/app_router.dart';
import 'core/services/notification_service.dart';
import 'core/services/deeplink_service.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/app_bloc_observer.dart';
import 'firebase_options.dart';
import 'injection/injection_container.dart' as di;

@pragma('vm:entry-point')
Future<void> _fcmBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

// Top-level variable — mencegah DeeplinkService di-garbage collect selama
// proses berjalan sehingga uriLinkStream tetap aktif untuk in-app deeplinks.
late final DeeplinkService _deeplinkService;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = const AppBlocObserver();

  // Initialize Firebase dengan opsi dari firebase_options.dart (project e-money-b97f9)
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // FCM setup
  FirebaseMessaging.onBackgroundMessage(_fcmBackgroundHandler);
  await FirebaseMessaging.instance.requestPermission(alert: true, badge: true, sound: true);

  // Notification channel (Android 8+)
  await initNotificationService();
  FirebaseMessaging.onMessage.listen(showLocalNotification);

  // Initialize dependency injection
  await di.init();

  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Status bar style
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
  ));

  // Simpan instance agar tidak di-GC — stream subscription harus tetap hidup
  // untuk menerima in-app deeplinks via onNewIntent (Android singleTop).
  _deeplinkService = DeeplinkService(AppRouter.router);
  await _deeplinkService.init();

  runApp(const DompetKampusApp());
}

class DompetKampusApp extends StatelessWidget {
  const DompetKampusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'daqi',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      routerConfig: AppRouter.router,
    );
  }
}
