import 'package:flutter/material.dart';
import '../models/hydroponic_plant.dart';

class HeightChart extends StatelessWidget {
  final List<HeightPoint> points;
  const HeightChart({super.key, required this.points});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: CustomPaint(
        painter: _ChartPainter(points),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: points
                .map((e) => Text(_month(e.date.month), style: Theme.of(context).textTheme.bodySmall))
                .toList(),
          ),
        ),
      ),
    );
  }

  String _month(int m) {
    const mm = ['Jan','Feb','Mar','Apr','Mei','Jun','Jul','Agu','Sep','Okt','Nov','Des'];
    return mm[m-1];
  }
}

class _ChartPainter extends CustomPainter {
  final List<HeightPoint> points;
  _ChartPainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    final paintLine = Paint()
      ..color = Colors.green
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;
    final paintAxis = Paint()
      ..color = Colors.green.withValues(alpha: 0.2)
      ..strokeWidth = 1;
    final maxVal = points.map((e) => e.cm).reduce((a, b) => a > b ? a : b);
    final minVal = points.map((e) => e.cm).reduce((a, b) => a < b ? a : b);
    final range = (maxVal - minVal).abs() == 0 ? 1 : (maxVal - minVal);
    final dx = size.width / (points.length - 1);
    for (int i = 0; i < 4; i++) {
      final y = i * (size.height / 3);
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paintAxis);
    }
    final path = Path();
    for (int i = 0; i < points.length; i++) {
      final x = i * dx;
      final y = size.height - ((points[i].cm - minVal) / range) * size.height;
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    canvas.drawPath(path, paintLine);
    final dotPaint = Paint()..color = Colors.green;
    for (int i = 0; i < points.length; i++) {
      final x = i * dx;
      final y = size.height - ((points[i].cm - minVal) / range) * size.height;
      canvas.drawCircle(Offset(x, y), 4, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _ChartPainter oldDelegate) => oldDelegate.points != points;
}