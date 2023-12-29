
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:rababa/app/end_points/constant.dart';
import 'package:rababa/presentation/resources/color_manager.dart';
import 'package:rababa/presentation/splach/view/splach_screen.dart';
import '../../app/di.dart';
import 'admin/main/view/admin_main_screen.dart';

class MyApp extends StatefulWidget {
  MyApp._internal();
  static final MyApp _instance =
  MyApp._internal(); // singleton or single instance

  factory MyApp() => _instance; //
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  _bind() async{
    await initAppModule();
    await initRegisterModule();
    await initLoginModule();
    await initStudentProfileModule();
    await initCreatePostModule() ;
    await initGetAllUsersModule();
    await initUserPostsModule();
    await initUpdateProfileModule();
    await initAdmin();
    await initTeacher();
  }
  @override
  void initState() {
    _bind() ;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rababa',
      localizationsDelegates: const [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales:const [
        Locale("ar", "DZ")
      ] ,
      locale:const Locale("ar", "DZ") ,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme:  const AppBarTheme(
          titleTextStyle: TextStyle(color: Colors.black , fontSize: 18.0 ,fontWeight: FontWeight.bold ,  fontFamily: AppConstant.fontFamilyRoboto),
          iconTheme: IconThemeData(color: Colors.black) ,
          backgroundColor: AppColor.scaffoldBackgroundColor ,
          elevation: 0.5,
        ) ,
        primarySwatch: AppColor.primary,
        fontFamily: 'Arabic_Typesetting',
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          showSelectedLabels: false ,
          showUnselectedLabels: false ,
        ),
         scaffoldBackgroundColor:AppColor.scaffoldBackgroundColor ,
        textTheme:   TextTheme(
          titleSmall: const TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              color: Colors.black
          ) ,
          titleLarge: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              letterSpacing: 0,
          ),
          titleMedium: const TextStyle(
            fontSize: 24.0,
        fontWeight: FontWeight.bold,
        color:  Color(0xFF675896)
        ),
          bodyLarge:  TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF000000).withOpacity(0.72)
          ),
          bodySmall: const TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color:  Color(0xFF656262)
          ),
          bodyMedium:  const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color:  Color(0xFF6C6A6A),
            fontStyle: FontStyle.normal
          ),
      )
      ) ,
      home:const SplashScreen() ,
     /* const AdminMainScreen(),*/
    );
  }
}