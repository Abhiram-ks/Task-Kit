import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:todokit/firebase_options.dart';
import 'package:todokit/taskkit/presentation/provider/bloc/splash_bloc/splash_bloc.dart';
import 'package:todokit/taskkit/presentation/provider/cubit/button_progresser/button_progresser_cubit.dart';
import 'package:todokit/taskkit/presentation/screen/splash_screen/splash_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'taskkit/core/themes/app_themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => SplashBloc()..add(SplashEventStart())),
        BlocProvider(create: (_) => ButtonProgressCubit())  
      ],
      child: MaterialApp(
        title: 'Task Kit',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: SplashScreen(),
      ),
    );
  }
}
