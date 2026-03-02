import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:skims_poc/product_page.dart';
import 'package:skims_poc/try_on_bloc/try_on_bloc.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Skims POC',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFFA78375)),
        canvasColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            foregroundColor: const Color(0xFF787573),
            backgroundColor: const Color(0xFFFAF8F6),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
      ),
      home: MultiBlocProvider(
        providers: [BlocProvider(create: (context) => TryOnBloc())],
        child: const ProductPage(),
      ),
    );
  }
}
