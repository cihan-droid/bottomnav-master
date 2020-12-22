import 'package:bottomnav/bloc/fab_icon_bloc.dart';
import 'package:bottomnav/bloc/fab_icon_bloc_provider.dart';
import 'package:flutter/material.dart';

class FabIkon extends StatefulWidget {
  final Function() onPressed;
  final String tooltip;
  final IconData icon;

  FabIkon({this.onPressed, this.tooltip, this.icon});

  @override
  _FabIkonState createState() => _FabIkonState();
}

class _FabIkonState extends State<FabIkon> with SingleTickerProviderStateMixin {
  bool isOpened = false;
  AnimationController _animationController;
  Animation<double> _animateIcon;
  Animation<double> _translateButton;
  Curve _curve = Curves.easeOut;
  double _fabHeight = 56.0;
  FabIkonBloc _fabIkonBloc;

  @override
  initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500))
          ..addListener(() {
            setState(() {});
          });
    _animateIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);

    _translateButton = Tween<double>(
      begin: _fabHeight + 16,
      end: -14.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.0,
        0.75,
        curve: _curve,
      ),
    ));
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fabIkonBloc = FabIkonBlocProvider.of(context).fabIkonBlocc;
  }

  @override
  dispose() {
    _animationController.dispose();
    _fabIkonBloc.dispose();
    super.dispose();
  }

  animate() {
    if (!isOpened) {
      _animationController.forward();
      _fabIkonBloc.fabIkonEkleSinki.add(true);
    } else {
      _animationController.reverse();
      _fabIkonBloc.fabIkonEkleSinki.add(false);
    }
    isOpened = !isOpened;
  }

  Widget marker() {
    return Container(
      padding: EdgeInsets.only(right: 24.0, bottom: 16.0),
      child: FloatingActionButton(
        onPressed: null,
        tooltip: 'Add',
        child: Image(
          image: AssetImage('icons/marker.png'),
        ),
        backgroundColor: Color.fromARGB(255, 129, 216, 208),
      ),
    );
  }

  Widget heart() {
    return Container(
      padding: EdgeInsets.only(right: 24.0, bottom: 16.0),
      child: FloatingActionButton(
        onPressed: null,
        tooltip: 'Image',
        child: Icon(Icons.favorite_outline),
        backgroundColor: Color.fromARGB(255, 129, 216, 208),
      ),
    );
  }

  Widget tag() {
    return Container(
      padding: EdgeInsets.only(right: 24.0, bottom: 16.0),
      child: FloatingActionButton(
        onPressed: null,
        tooltip: 'Inbox',
        child: Icon(Icons.bookmark_border),
        backgroundColor: Color.fromARGB(255, 129, 216, 208),
      ),
    );
  }

  Widget toggle() {
    return Container(
      padding: EdgeInsets.only(
        bottom: 28.0,
        right: 24.0,
      ),
      child: AnimatedBuilder(
        animation: _animateIcon,
        child: FloatingActionButton(
          backgroundColor: Color.fromARGB(255, 129, 216, 208),
          onPressed: animate,
          tooltip: 'Toggle',
          child: Icon(Icons.add),
        ),
        builder: (context, child) {
          return Transform.rotate(
            angle: _animateIcon.value * 2.28,
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value * 3.0,
            0.0,
          ),
          child: marker(),
        ),
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value * 2.0,
            0.0,
          ),
          child: heart(),
        ),
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value,
            0.0,
          ),
          child: tag(),
        ),
        toggle(),
      ],
    );
  }
}
