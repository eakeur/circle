import 'package:circle/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unit circle',
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: const Branding(),
    );
  }
}


class Branding extends StatefulWidget {
  const Branding({Key? key}) : super(key: key);

  @override
  State<Branding> createState() => _BrandingState();
}

class _BrandingState extends State<Branding> with TickerProviderStateMixin {

  late AnimationController controller;

  late Animation<double> animation;

  @override
  void initState() {
    controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1500));
    animation = Tween<double>(begin: 0, end: 7)
        .animate(CurvedAnimation(parent: controller, curve: Curves.decelerate))
      ..addListener(() => setState(() {}))
    ..addStatusListener((st){
      if (st == AnimationStatus.completed || st == AnimationStatus.dismissed){
        Future.delayed(const Duration(milliseconds: 700), () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
          return const HomePage(title: 'Unit circle');
        })));
      }
    });
    Future.delayed(const Duration(milliseconds: 0), () => controller.forward());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const text = 'Eakeur.';
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.indigo,
        body: Center(
          child: Text(text.substring(0, animation.value.toInt()), style: TextStyle(fontSize: 48, fontWeight: FontWeight.w800, color: Colors.white)),
        ),
      ),
    );
  }
}

