import 'dart:io';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:el_red/business/network/api_handler.dart';
import 'package:el_red/business/providers/file_provider.dart';
import 'package:el_red/business/providers/zoom_provider.dart';
import 'package:el_red/business/utils/el_colors.dart';
import 'package:el_red/presentation/image_oper_views/select_category_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

///entry point of the application.
void main() {
  ///widgets binding.
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  ///overriding of ssl-certificate for entire app.
  HttpOverrides.global = MyHttpOverrides();

  ///to set tool bar color and brightness.
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: ElColors.whiteColor,
      statusBarBrightness: Brightness.dark,
      systemNavigationBarColor: ElColors.blackColor,
      statusBarIconBrightness: Brightness.dark));
  runApp(const ElRedApp());
  FlutterNativeSplash.remove();
}

class ElRedApp extends StatelessWidget {
  const ElRedApp({super.key});

  @override
  Widget build(BuildContext context) {
    ///injecting providers
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FileUploadProvider(), lazy: true),
        ChangeNotifierProvider(create: (_) => ZoomProvider(), lazy: true)
      ],
      child: MaterialApp(
        title: 'El Red',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: ElColors.whiteColor),
          useMaterial3: true,
        ),
        home: SelectCategoryScreen(),
      ),
    );
  }
}
