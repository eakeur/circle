import 'package:flutter/material.dart';
import 'dart:math' as math;

class AngleDescriptorTable extends StatelessWidget {
  final double angle;

  double get _radians => (math.pi * angle) / 180;

  double get sin => math.sin(_radians);

  double get cos => math.cos(_radians);

  double get tan => math.tan(_radians);

  final Color sinColor;
  final Color cosColor;
  final Color tanColor;

  const AngleDescriptorTable(
      {Key? key,
      required this.angle,
      this.sinColor = Colors.green,
      this.cosColor = Colors.red,
      this.tanColor = Colors.blue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(angle.toStringAsFixed(2) + 'º',
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 18)),
        DataTable(
          columns: [
            DataColumn(
                label: Text('sen',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: sinColor))),
            DataColumn(
                label: Text('cos',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: cosColor))),
            DataColumn(
                label: Text('tan',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: tanColor))),
          ],
          rows: [
            DataRow(
                cells: [
              Text(sin.toStringAsFixed(2),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: sinColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 14)),
              Text(cos.toStringAsFixed(2),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: cosColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 14)),
              Text(tan.toStringAsFixed(2),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: tanColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 14)),
            ].map((e) => DataCell(e)).toList())
          ],
        )
      ],
    );
  }
}
