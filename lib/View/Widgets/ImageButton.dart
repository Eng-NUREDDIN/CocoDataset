
import 'package:flutter/material.dart';

class ImageButton extends StatelessWidget {
  void Function()? onTap;
  String ?imagePath;
   ImageButton({this.onTap,this.imagePath,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Image.asset(imagePath!,width: 40,height: 40,),
    );
  }
}
