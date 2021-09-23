import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';

class UnitCirclePainter extends CustomPainter {
  final Color sinColor;

  final Color cosColor;

  final Color tanColor;

  final double value;

  final Size size;

  double get angle => (math.pi * value) / 180;

  double get sin => math.sin(angle);

  double get cos => math.cos(angle);

  double get tan => math.tan(angle);

  double get radius => size.width / 2;

  Offset get point => Offset((cos * radius) + radius, (sin * -radius) + radius);

  Offset get zeroPoint => Offset((0 * radius) + radius, (0 * -radius) + radius);

  const UnitCirclePainter(
      {this.value = 0,
      required this.size,
      this.sinColor = Colors.green,
      this.cosColor = Colors.red,
      this.tanColor = Colors.blue});

  @override
  void paint(Canvas canvas, Size size) {
    drawCircleLines(canvas);
    drawTrigonometricalLines(canvas);
  }

  void drawCircleLines(Canvas canvas) {
    final Paint paint = Paint()
      ..strokeWidth = 5.0
      ..style = PaintingStyle.stroke
      ..color = Colors.white;

    double degToRad(double deg) => deg * (math.pi / 180.0);

    final path = Path()
      ..arcTo(
          Rect.fromCenter(
            center: Offset(size.height / 2, size.width / 2),
            height: size.height,
            width: size.width,
          ),
          degToRad(359),
          degToRad(360),
          false);
    canvas.drawPath(path, paint);

    var horizontalLineCoordinateBase = size.height / 2;
    var verticalLineCoordinateBase = size.width / 2;
    var horizontalLineOffset = <Offset>[
      Offset(0, horizontalLineCoordinateBase),
      Offset(size.width, horizontalLineCoordinateBase)
    ];
    var verticalLineOffset = <Offset>[
      Offset(verticalLineCoordinateBase, 0),
      Offset(verticalLineCoordinateBase, size.width)
    ];

    canvas.drawLine(
        horizontalLineOffset.first, horizontalLineOffset.last, paint);
    canvas.drawLine(verticalLineOffset.first, verticalLineOffset.last, paint);
  }

  void drawTrigonometricalLines(Canvas canvas) {
    canvas.drawPoints(
        PointMode.points,
        [point],
        Paint()
          ..strokeWidth = 5.0
          ..strokeCap = StrokeCap.round
          ..style = PaintingStyle.stroke
          ..color = Colors.black);
    drawIdentifiers(canvas, cosColor, Offset(point.dx, zeroPoint.dy));
    drawIdentifiers(canvas, sinColor, Offset(zeroPoint.dx, point.dy));
    drawIdentifiers(canvas, tanColor, zeroPoint);
  }

  void drawIdentifiers(Canvas canvas, Color color, Offset offset) {
    canvas.drawLine(
        offset,
        point,
        Paint()
          ..strokeWidth = 4
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round
          ..color = color);
    canvas.drawPoints(
        PointMode.points,
        [offset],
        Paint()
          ..strokeWidth = 5
          ..strokeCap = StrokeCap.round
          ..style = PaintingStyle.stroke
          ..color = color);
  }

  @override
  bool shouldRepaint(UnitCirclePainter oldDelegate) {
    return true;
  }
}
