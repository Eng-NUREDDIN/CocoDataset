
import 'package:cocodatasetwebexp/GlobalUtilities/AppColors.dart';
import 'package:flutter/material.dart';

import '../../Data/Model/ImagesModel.dart';
import 'CurvePainter.dart';

class ImageWidget extends StatefulWidget {
  final ImagesModel image;
   const ImageWidget({required this.image,Key? key}) : super(key: key);

  @override
  State<ImageWidget> createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageWidget> {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      child: imageContainer(),
    );
  }
  Widget imageContainer(){
    Size size=MediaQuery.of(context).size;
    return Container(child: SingleChildScrollView(scrollDirection: Axis.horizontal,
      child: Stack(
        children: [
          Image.network(widget.image.cocoUrl!),
          Container(child: CustomPaint(
            painter: CurvePainter(widget.image.segment!,size),

          ), ),
        ],
      ),
    ));
  }
}
