import 'package:circle/main.dart';
import 'package:circle/unit_circle_painter.dart';
import 'package:flutter/material.dart';
import 'package:circle/angle_descriptor_table.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  late Animation<double> animation;

  bool fast = false;

  @override
  void initState() {
    super.initState();
    //animate();
    //controller.forward();
  }

  void animate() {
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds:10));
    animation = Tween<double>(begin: 0, end: 360).animate(controller)
      ..addListener(() => setState(() {}))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.repeat();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });
  }

  void changeSpeed(){
    setState((){
      fast = !fast;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.indigo,
        centerTitle: true,
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.run_circle_outlined),
            onPressed: changeSpeed,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 5.0),
        child: Center(child: PageContentWidget(cycleDuration: fast ? 30 : 60)),
      ),
      bottomNavigationBar: SizedBox(
        height: 50,
        width: double.infinity,
        child: Center(
            child: GestureDetector(
                onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
              return const Branding();
            })) ,
                child: const Text('made with love by Eakeur', style: TextStyle(color: Colors.white),
                ),
            ),
        ),
      ),
    );
  }
}

class PageContentWidget extends StatefulWidget {
  final int cycleDuration;

  const PageContentWidget({Key? key, required this.cycleDuration}) : super(key: key);

  @override
  _PageContentWidgetState createState() => _PageContentWidgetState();
}

class _PageContentWidgetState extends State<PageContentWidget> with TickerProviderStateMixin {

  late AnimationController controller;

  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    animate();
    controller.forward();
  }

  @override
  void didUpdateWidget(covariant PageContentWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    var stop = animation.value;
    controller.dispose();
    animate();
    controller.forward(from: stop);
  }

  void animate() {
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: widget.cycleDuration));
    animation = Tween<double>(begin: 0, end: 360).animate(controller)
      ..addListener(() => setState(() {}))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.repeat();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 0.5;
    final height = MediaQuery.of(context).size.height * 0.5;
    final size = Size(
        width >= height ? height : width, height >= width ? width : height);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MouseRegion(
          onEnter: (ev) => controller.stop(),
          onExit: (ev) => controller.forward(),
          child: CustomPaint(
            painter:
            UnitCirclePainter(value: animation.value, size: size),
            size: size,
          ),
        ),
        AngleDescriptorTable(
          angle: (animation.value),
        ),
      ],
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
