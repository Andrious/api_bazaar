// Copyright 2022 Andrious Solutions Ltd. All rights reserved.
// Use of this source code is governed by a Apache license that can be
// found in the LICENSE file.

import 'package:api_bazaar/src/controller.dart' as c;

import 'package:api_bazaar/src/model.dart';

import 'package:api_bazaar/src/view.dart';

// import 'package:carousel_pro/carousel_pro.dart' show Carousel;

import 'package:carousel_slider/carousel_slider.dart';

///
class HomePage extends StatefulWidget {
  ///
  const HomePage({
    Key? key,
    this.searchProdName,
    this.searchProdImage,
    this.searchProdPrice,
  }) : super(key: key);

  ///
  final searchProdName;

  ///
  final searchProdImage;

  ///
  final searchProdPrice;

  @override
  HomePageState createState() => HomePageState();
}

///
class HomePageState extends StateMVC<HomePage> {
  ///
  HomePageState() : super(c.ThemeChanger()) {
    add(c.HomeDrawer());
    add(c.HomeAppBar());
  }

  @override
  void initState() {
    super.initState();
    ran = c.RandomAnimals();
    _categories = ran.loadOfEach(
      count: 1,
      builder: (imageWidget) => InkWell(
        onTap: () {
          ran.reload(api: (imageWidget as RandomAnimal).api);
          // Rebuild dependencies
          APIImages.notifyClients();
        },
        child: imageWidget.controller.image,
      ),
    );
  }

  /// Controls the what data is retrieved.
  late c.RandomAnimals ran;

  /// The category available
  late List<Widget> _categories;

  @override
  Widget build(BuildContext context) {
    final c.HomeAppBar con = c.HomeAppBar();
    return Scaffold(
      // Drawer Start
      drawer: HomeDrawer(state: this),
      appBar: AppBar(
        titleSpacing: 2,
        elevation: 0,
        backgroundColor: const Color(0xFFB33771),
        title: c.Builder(builder: (context) {
          widgetInherited(context);
          return L10n.t('API Bazaar');
        }),
        actions: <Widget>[
          // con.search,
          // con.cart,
          PopMenu().popupMenuButton,
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 200,
            child: CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
              ),
              carouselController: CarouselController(),
              items: _categories,
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(10),
            child: APIImages.setState(
              builder: (context) {
                widgetInherited(context);
                Text? label;
                final String? value = ran.currentAPI?.label.value;
                if (value != null) {
                  label = Text(
                    L10n.s('${value.trim().toUpperCase()} Pictures'),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  );
                }
                return label ?? const SizedBox();
              },
            ),
          ),
          //grid view
          const Flexible(
            child: Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: RecentProducts(),
            ),
          ),
        ],
      ),
    );
  }

  ///
  Widget showList(String s, IconData i) {
    return ListTile(
      leading: Icon(
        i,
        color: Colors.yellow[700],
      ),
      title: Text(s),
    );
  }
}
