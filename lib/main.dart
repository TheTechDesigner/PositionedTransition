import 'package:flutter/material.dart';
import 'package:positioned_transition/images.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color(0xFF832685),
        primaryColorLight: Color(0xFFC81379),
        accentColor: Colors.black,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  String title = 'Positioned Transition';

  Animation<RelativeRect> _animation;
  AnimationController _controller;
  Animation _curve;
  RelativeRect _animationValue;
  AnimationStatus _state;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: Duration(seconds: 2), vsync: this);

    _curve = CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn);

    _animation = RelativeRectTween(
            begin: RelativeRect.fromLTRB(200.0, 200.0, 200.0, 200.0),
            end: RelativeRect.fromLTRB(20.0, 20.0, 20.0, 20.0))
        .animate(_curve)
          ..addListener(() {
            setState(() {
              _animationValue = _animation.value;
            });
          })
          ..addStatusListener((AnimationStatus state) {
            if (state == AnimationStatus.completed) {
              _controller.reverse();
            } else if (state == AnimationStatus.dismissed) {
              _controller.forward();
            }
            setState(() {
              _state = state;
            });
          });
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: Stack(
              children:<Widget>[ PositionedTransition(
            rect: _animation,
            child: Image(
                height: 300.0,
                width: 300.0,
                image: AssetImage(spiderMan),
              ),
          ),
              ],
      ),
      // body: Stack(
      //   children: <Widget>[
      //     AnimatorTransition(
      //       animation: _animation,
      //       child: Image(
      //         height: 300.0,
      //         width: 300.0,
      //         image: AssetImage(spiderMan),
      //       ),
      //     ),
      //     Padding(
      //       padding: const EdgeInsets.all(16.0),
      //       child: Text(
      //         'Animation Value :' + _animationValue.toString(),
      //         style: TextStyle(fontSize: 18.0),
      //       ),
      //     ),
      //     Padding(
      //       padding: const EdgeInsets.only(
      //           top: 75.0, bottom: 16.0, left: 16.0, right: 16.0),
      //       child: Text(
      //         'Animation Status :' + _state.toString(),
      //         style: TextStyle(fontSize: 18.0),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}

// class AnimatorTransition extends StatelessWidget {
//   final Widget child;
//   final Animation<RelativeRect> animation;

//   AnimatorTransition({this.child, this.animation});

//   @override
//   Widget build(BuildContext context) {
//     // Animation of Absolute Position needs Stack
//     return Stack(
//       children: <Widget>[
//         PositionedTransition(
//           rect: animation,
//           child: this.child,
//         ),
//       ],
//     );
//   }
// }
