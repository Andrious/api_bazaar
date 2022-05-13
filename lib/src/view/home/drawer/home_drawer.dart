// Copyright 2022 Andrious Solutions Ltd. All rights reserved.
// Use of this source code is governed by a Apache license that can be
// found in the LICENSE file.

import 'package:api_bazaar/src/controller.dart' as c;

import 'package:api_bazaar/src/view.dart' hide HomeDrawer;

///
class HomeDrawer extends StatelessWidget {
  ///
  const HomeDrawer({Key? key, required this.state}) : super(key: key);

  ///
  final HomePageState state;

  @override
  Widget build(BuildContext context) {
    final c.HomeDrawer con = state.controllerByType<c.HomeDrawer>()!;
    return Drawer(
      child: ListView(
        children: <Widget>[
          con.header,
          con.darkmode,
          con.account,
          con.apis,
          con.settings,
          con.about,
          con.contact,
          con.logout,
        ],
      ),
    );
  }
}
