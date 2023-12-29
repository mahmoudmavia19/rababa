import 'package:flutter/material.dart';

import '../../resources/assets_manager.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(50.0),
          child: Column(
            children: [
              const SizedBox(
                height: 70.0,
              ),
              Image.asset(AppIcons.people),
              Text(
                textAlign: TextAlign.center,
                'نحن (رَبَابَة) تطبيق مختص لتعليم الآلات الموسيقية العربية يجمع بين معلم لديه خبرة وطالب لديه فضول وشغف في تعلم الموسيقى العربية بإتصال مباشر .',
                style: Theme.of(context).textTheme.titleLarge,
              ),

            ],
          ),
        ));
  }
}
