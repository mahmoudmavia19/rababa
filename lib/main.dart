import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:rababa/app/di.dart';
import 'package:rababa/app/fire_base_dynamic_link.dart';
import 'package:rababa/firebase_options.dart';
import 'package:rababa/presentation/screens/myapp.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:timeago/timeago.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized() ;
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );


  DynamicLinkProvider().initDynamicLink();
   setLocaleMessages('ar',ArMessages()) ;
  runApp(Phoenix(child: MyApp()));
}
Future<void> handleDynamicLink() async {

  final PendingDynamicLinkData? data = await FirebaseDynamicLinks.instance.getInitialLink();
  final Uri? deepLink = data?.link;

  if (deepLink != null) {
    // Handle the deep link in your app as per your requirements.
    // Example: navigate to a specific screen based on the deep link.
  }

  FirebaseDynamicLinks.instance.onLink.listen((event) {
    final Uri deepLink = event.link;
    print(deepLink.path);
  });
}




