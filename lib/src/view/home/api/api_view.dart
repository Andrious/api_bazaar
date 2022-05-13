// Copyright 2022 Andrious Solutions Ltd. All rights reserved.
// Use of this source code is governed by a Apache license that can be
// found in the LICENSE file.

import 'package:api_bazaar/src/controller.dart';

import 'package:api_bazaar/src/view.dart';

/// List of API's
class APIsList extends StatefulWidget {
  ///
  const APIsList({Key? key, this.title = "List of API's"}) : super(key: key);

  /// Title of the screen.
  final String title;

  @override
  State createState() => _APIsListState();
}

class _APIsListState extends StateMVC<APIsList> {
  _APIsListState() : super(APIsController()) {
    con = controller as APIsController;
  }
  late APIsController con;

  @override
  void initState() {
    super.initState();
    _title = App.title!;
  }

  String? _title;

  @override
  Widget build(BuildContext context) =>
      App.useMaterial ? _buildAndroid(this) : _buildiOS(this);
}

/// The Android version of the interface.
Widget _buildAndroid(_APIsListState state) {
  //
  final con = state.con;
  return Scaffold(
    appBar: AppBar(
      title: Text(state._title ?? state.widget.title),
      actions: [
        TextButton(
          onPressed: con.sort,
          child: const Icon(Icons.sort_by_alpha, color: Colors.white),
        ),
        PopMenu().popupMenuButton,
      ],
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () async {
        await Navigator.of(con.state!.context).push(MaterialPageRoute<void>(
          builder: (_) => const AddAPIs(),
        ));
        //     .then((_) {
        //   con.refresh();
        // });
        /// Either use the 'then' clause or the 'async await' command.
        await con.refresh();
      },
      child: const Icon(Icons.add),
    ),
    body: SafeArea(
      child: con.items == null
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: con.items?.length ?? 0,
              itemBuilder: (_, int index) {
                final api = con.itemAt(index);
                return Container(
                  decoration: const BoxDecoration(
                    border: Border(),
                  ),
                  child: ListTile(
                    onTap: () async {
                      await Navigator.of(con.state!.context)
                          .push(MaterialPageRoute<void>(
                        builder: (_) => APIsDetails(api: api!),
                      ));
                      await con.getAPIs();
                      con.state!.setState(() {});
                    },
                    title: api!.description.text,
                    subtitle: api.url.text,
                  ),
                );
              },
            ),
    ),
  );
}

/// The iOS version of the interface.
Widget _buildiOS(_APIsListState state) {
  //
  final con = state.con;
  final widget = state.widget;
  final _theme = App.themeData;
  return CupertinoPageScaffold(
    child: CustomScrollView(
      semanticChildCount: 5,
      slivers: <Widget>[
        CupertinoSliverNavigationBar(
          largeTitle: Text(state._title ?? widget.title),
          leading: Material(
            child: IconButton(
              icon: const Icon(Icons.sort_by_alpha),
              onPressed: con.sort,
            ),
          ),
          middle: Material(
            child: IconButton(
              icon: const Icon(Icons.add),
              onPressed: () async {
                await Navigator.of(con.state!.context)
                    .push(MaterialPageRoute<void>(
                  builder: (_) => const AddAPIs(),
                ));
                await con.refresh();
              },
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              PopMenu().popupMenuButton,
            ],
          ),
        ),
        if (con.items == null)
          const Center(
            child: CircularProgressIndicator(),
          )
        else
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, int index) {
                final api = con.itemAt(index);
                return api?.description.onDismissible(
                  child: Container(
                    decoration: BoxDecoration(
                      color: _theme?.canvasColor,
                      border: Border(
                        bottom: BorderSide(color: _theme!.dividerColor),
                      ),
                    ),
                    child: CupertinoListTile(
                      title: api.description.text,
                      subtitle: api.url.text,
                      onTap: () async {
                        await Navigator.of(con.state!.context)
                            .push(MaterialPageRoute<void>(
                          builder: (_) => APIsDetails(api: api),
                        ));
                        await con.getAPIs();
                        con.state!.setState(() {});
                      },
                    ),
                  ),
                  dismissed: (DismissDirection direction) {
                    con.deleteItem(index);
                    final action = (direction == DismissDirection.endToStart)
                        ? 'deleted'
                        : 'archived';
                    App.snackBar(
                      duration: const Duration(milliseconds: 8000),
                      content: Text('You $action an item.'),
                      action: SnackBarAction(
                          label: 'UNDO',
                          onPressed: () {
                            api.undelete();
                            state.refresh();
                          }),
                    );
                  },
                );
              },
              childCount: con.items?.length,
              semanticIndexCallback: (Widget widget, int localIndex) {
                if (localIndex.isEven) {
                  return localIndex ~/ 2;
                }
                return null;
              },
            ),
          ),
      ],
    ),
  );
}
