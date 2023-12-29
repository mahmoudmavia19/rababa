import 'package:flutter/material.dart';
import 'package:rababa/presentation/resources/assets_manager.dart';
import 'package:rababa/presentation/resources/strings_manager.dart';

class ChatDesignScreen  extends StatelessWidget {
  const ChatDesignScreen ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset(AppIcons.logo),
      ),
      body:Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(itemBuilder: (context, index) => Container(),
                  separatorBuilder: (context, index) => Container(), itemCount: 2),
            ),
            SizedBox(
              height: 70.0,
              child: TextFormField(
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(13.0)) ,
                    focusedBorder:  OutlineInputBorder(borderRadius: BorderRadius.circular(13.0)) ,
                    hintText:AppStrings.write ,
                    suffixIcon: const Padding(
                      padding:  EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 23.0,
                        child: Icon(Icons.arrow_forward_ios),
                      ),
                    )

                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
