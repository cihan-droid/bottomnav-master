import 'package:bottomnav/FabIkon.dart';
import 'package:bottomnav/bloc/fab_icon_bloc.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Kesfet.dart';
import 'BanaOzel.dart';
import 'Secenekler.dart';
import 'Harita.dart';
import 'Dahasi.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

int selectedPage = 2;
GlobalKey<ConvexAppBarState> _appBarKey = GlobalKey<ConvexAppBarState>();

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  FabIkonBloc _fabIkonBloc;
  PageController _pageController = PageController(
    //PageController Başlangıç indexi
    initialPage: 2,
  );

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays(
        [SystemUiOverlay.bottom]); //alt butonları gizle
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    _fabIkonBloc = FabIkonBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: _fabIkonBloc.fabIkonStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return PageView(
              controller: _pageController,
              onPageChanged: (page) {
                setState(() {
                  _appBarKey.currentState.animateTo(
                      page); //Sayfa sağa-sola swipe yapıldığında ConvexAppBar'ın seçili olduğu index'i değiştirir.
                });
              },
              children: <Widget>[
                //PageView içersinde bulunan sayfalar
                Kesfet(),
                BanaOzel(),
                Harita(),
                Secenekler(),
                Dahasi(),
              ],
            );
          } else {
            return Container();
          }
        },
      ),
      bottomNavigationBar: ConvexAppBar(
        //BottomNavBar
        items: [
          TabItem(
              icon: Image(
                image: AssetImage('icons/Discovery.png'),
              ),
              title: 'Keşfet'),
          TabItem(
              icon: Image(
                image: AssetImage('icons/Profile.png'),
              ),
              title: 'Bana Özel'),
          TabItem(
              icon: Image(
                image: AssetImage('icons/Location.png'),
              ),
              title: 'Harita'),
          TabItem(
              icon: Image(
                image: AssetImage('icons/Setting.png'),
              ),
              title: 'Seçenekler'),
          TabItem(
            icon: Image(
              image: AssetImage('icons/More-Circle.png'),
            ),
            title: 'Dahası',
          )
        ],
        initialActiveIndex: selectedPage,
        key:
            _appBarKey, //PageView tarafından index'i kontrol edebilmek için GlobalKey tanımlandı.
        onTap: (int i) {
          //BottomNavigationBar ikonlarına tıklanıldığında PageView animasyonu ile sayfa geçişi sağlanıyor.
          _pageController.animateToPage(i,
              duration: Duration(milliseconds: 200), curve: Curves.easeInQuart);
          setState(
            () {
              selectedPage = i;
              _fabIkonBloc.fabIkonEkleSinki.add(null);
            },
          );
        },
        color: Color.fromARGB(255, 77, 77, 77),
        activeColor: Color.fromARGB(255, 3, 114, 156),
        style: TabStyle.fixed,
        backgroundColor: Colors.white,
      ),
      floatingActionButton: FabIkon(),
    );
  }
}
