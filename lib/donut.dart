import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'dart:math' as math;
import 'package:google_fonts/google_fonts.dart';

class Donut extends StatefulWidget {
  const Donut({Key? key}) : super(key: key);
  @override
  State<Donut> createState() => _DonutState();
}

class _DonutState extends State<Donut> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    _ticker = createTicker((elapsed) {
      donutFunction();
    });
    _ticker.start();
  }

  late final Ticker _ticker;
  double A = 0, B = 0;

  Color background = Colors.deepPurple.shade50;
  Color front = Colors.deepPurple.shade800;

  List<dynamic> b = List.generate(1761, (index) => ' ');
  List<double> z = List.generate(1761, (index) => 0);

  String value = '';

  @override
  Widget build(BuildContext context) {
    value = "";
    for (var k = 0; k < 1761; k++) {
      value = value + ((k % 80) > 0 ? b[k] : '\n').toString();
    }

    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.deepPurple.shade200,
        elevation: 1,
        title: Text(
          '3D Donut',
          style: GoogleFonts.robotoMono().copyWith(
            color: front,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                InteractiveViewer(
                  child: RotatedBox(
                    quarterTurns: 1,
                    child: FittedBox(
                      child: Text(
                        value,
                        style: GoogleFonts.robotoMono().copyWith(
                          color: front,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Calculations for the rotation and designing of the donut
  donutFunction() async {
    double i, j;
    b = List.generate(1760, (index) => ' ');
    z = List.generate(1760, (index) => 0);
    for (j = 0; 6.28 > j; j += 0.07) {
      for (i = 0; 6.28 > i; i += 0.02) {
        double c = math.sin(i),
            d = math.cos(j),
            e = math.sin(A),
            f = math.sin(j),
            g = math.cos(A),
            h = d + 2,
            D = 1 / (c * h * e + f * g + 5),
            l = math.cos(i),
            m = math.cos(B),
            n = math.sin(B),
            t = c * h * g - f * e;
        int x = (40 + 30 * D * (l * h * m - t * n)).toInt(),
            y = (12 + 15 * D * (l * h * n + t * m)).toInt(),
            o = x + 80 * y,
            N = (8 * ((f * e - c * d * g) * m - c * d * e - f * g - l * d * n))
                .toInt();
        if (22 > y && y > 0 && x > 0 && 80 > x && D > z[o]) {
          z[o] = D;
          b[o] = [
            '.',
            ',',
            '-',
            '~',
            ':',
            ';',
            '=',
            '!',
            '*',
            '#',
            '\$',
            '@'
          ][math.max(N, 0)];
        }
      }
    }
    A += 0.04;
    B += 0.02;
    setState(() {});
  }
}
