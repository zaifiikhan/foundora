import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme.dart';
import 'nav.dart';
// import 'firebase_options.dart'; // Uncomment this line after connecting Firebase

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Uncomment the following lines after connecting Firebase in the Dreamflow panel
  // try {
  //   await Firebase.initializeApp(
  //     options: DefaultFirebaseOptions.currentPlatform,
  //   );
  // } catch (e) {
  //   debugPrint("Firebase initialization failed: $e");
  // }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // You must have at least one provider here.
        // If you don't have a real one, use a dummy one like this:
        Provider.value(value: 'dummy'),
      ],
      child: MaterialApp.router(
        title: 'Foundora',
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.system,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
