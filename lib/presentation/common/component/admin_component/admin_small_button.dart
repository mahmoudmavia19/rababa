import 'package:flutter/material.dart';

class AdminSmallButtonStyle {
  double? height ;
  double? width ;
  double? radius ;

  AdminSmallButtonStyle({this.height, this.width, this.radius});
}
class AdminSmallButton extends StatelessWidget {
  AdminSmallButton({Key? key , required this.title , required this.onTap , this.adminSmallButtonStyle , this.enable = true } ) : super(key: key);
  Widget title ;
  AdminSmallButtonStyle? adminSmallButtonStyle ;
  VoidCallback onTap ;
  bool enable ;
  @override
  Widget build(BuildContext context) {
    return  Container(
      height:adminSmallButtonStyle?.height??24,
      width:adminSmallButtonStyle?.width,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(adminSmallButtonStyle?.radius??30.0),
          color:enable ?  const Color(0xFFCFB2C1) : const Color(0xFFCFB2C1)
      ),
      child: MaterialButton(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          onPressed:enable ?  onTap : onTap,
          child: Center(child: title)) ,
    );
  }
}
