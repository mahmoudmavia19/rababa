import 'package:flutter/material.dart';
import 'package:rababa/data/model/user_model.dart';

class ShowCertificatesScreen extends StatelessWidget {
   ShowCertificatesScreen({Key? key,required this.user}) : super(key: key);
  UserModel user ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
        title: Text(user.username??''),
      ) ,
      body:   Column(
        children: [
          const SizedBox(height: 10.0,) ,
          Text(user.certificate??'') ,
          const Divider(),
          Expanded(
            child: ListView.separated(itemBuilder: (context, index) =>
                Image.network(user.certificates![index],),
                separatorBuilder: (context, index) => const SizedBox(height: 10.0,),
                itemCount: user.certificates!.length),
          )
        ],
      ),
    );
  }
}
