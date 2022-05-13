import 'dart:convert';


import 'package:flutter/material.dart';
class CurvePainter extends CustomPainter {
   final List points;
   Size size;
  CurvePainter(this.points,this.size);

  void drawShape(Canvas canvas,List ofSetList){
    for(var e in ofSetList){
      List<Offset> ofSetsPoints = [];
      var paint = Paint();
      var paint2 = Paint();
      paint.strokeWidth=2;
      paint.color = const Color.fromRGBO(0, 0, 0, 1);
      paint2.color = const Color.fromRGBO(255, 0, 0, 0.4);
      paint.style=PaintingStyle.stroke;
      paint2.style = PaintingStyle.fill;
      var path = Path();
      Offset offset = Offset(0, 0);
      try {
        for (int i = 0; i < e.length / 2; i++) {
          int j = i * 2;
          offset = Offset(e[j], e[j + 1]);
          ofSetsPoints.add(offset);
        }
      } catch (e) {
        print(e);
      }
      path.addPolygon(ofSetsPoints, true);
      canvas.drawPath(path, paint);
      canvas.drawPath(path, paint2);
    }
  }
  @override
  void paint(Canvas canvas, Size size) {
   for(var item in points) {
     var decoded = json.decode(item);
     List numbers = [];
     for (var items in decoded) {
       numbers.add(items);
     }
     drawShape(canvas, numbers);
   }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}