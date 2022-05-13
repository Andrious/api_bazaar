// Copyright 2022 Andrious Solutions Ltd. All rights reserved.
// Use of this source code is governed by a Apache license that can be
// found in the LICENSE file.

import 'package:api_bazaar/src/model.dart';

import 'package:api_bazaar/src/view.dart';

enum AppBarBehavior { normal, pinned, floating, snapping }

/// Display the API's details
class APIsDetails extends StatefulWidget {
  ///
  const APIsDetails({required this.api, Key? key}) : super(key: key);

  ///
  final APIs api;
  @override
  State createState() => _DetailsState();
}

class _DetailsState extends StateMVC<APIsDetails> {
  @override
  void initState() {
    super.initState();
    contact = widget.api;
  }

  late APIs contact;

  @override
  Widget build(BuildContext context) =>
      App.useMaterial ? _BuildAndroid(state: this) : _BuildiOS(state: this);

  // Provide a means to 'edit' the details
  Future<void> editContact(APIs? contact, BuildContext context) async {
    final widget = AddAPIs(api: contact, title: 'Edit a contact'.tr);
    PageRoute<void> route;
    if (App.useMaterial) {
      route =
          MaterialPageRoute<void>(builder: (BuildContext context) => widget);
    } else {
      route =
          CupertinoPageRoute<void>(builder: (BuildContext context) => widget);
    }
    await Navigator.of(context).push(route);
    final contacts = await contact!.model.getAPIs();
    this.contact = contacts
        .firstWhere((contact) => contact.id.value == this.contact.id.value);
    setState(() {});
  }
}

// Android interface
class _BuildAndroid extends StatelessWidget {
  const _BuildAndroid({Key? key, required this.state}) : super(key: key);
  final _DetailsState state;

  @override
  Widget build(BuildContext context) {
    final contact = state.contact;
    // Dart allows for local function declarations
    Future<void> onTap() => state.editContact(contact, context);
    return Scaffold(
      appBar: AppBar(title: contact.description.text, actions: [
        TextButton(
          onPressed: () async {
            // Confirm the deletion
            final delete = await showBox(
                text: 'Delete this contact?'.tr, context: context);

            if (delete) {
              //
              await contact.delete();

              Navigator.of(context).pop();
            }
            // // A 'then' clause implementation.
            // showBox(text: 'Delete this contact?', context: context)
            //     .then((bool delete) {
            //   if (delete) {
            //     contact.delete().then((_) {
            //       Navigator.of(context).pop();
            //     });
            //   }
            // });
          },
          child: const Icon(Icons.delete, color: Colors.white),
        ),
      ]),
      bottomNavigationBar: SimpleBottomAppBar(
        button01: HomeBarButton(onPressed: () {
          Navigator.of(context).pop();
        }),
        button03: EditBarButton(onPressed: onTap),
      ),
      body: CustomScrollView(slivers: [
        SliverList(
          delegate: SliverChildListDelegate([
            contact.description.onListTile(tap: onTap),
          ]),
        )
      ]),
    );
  }
}

// iOS interface
class _BuildiOS extends StatelessWidget {
  const _BuildiOS({Key? key, required this.state}) : super(key: key);
  final _DetailsState state;

  @override
  Widget build(BuildContext context) {
    final contact = state.contact;
    // Dart allows for local function declarations
    Future<void> onTap() => state.editContact(contact, context);
    return CupertinoPageScaffold(
      child: CustomScrollView(slivers: <Widget>[
        CupertinoSliverNavigationBar(
          leading: CupertinoNavigationBarBackButton(
            previousPageTitle: 'Home',
            onPressed: () {
              Navigator.of(context).maybePop();
            },
          ),
          largeTitle: Text('${contact.description.value ?? ''}'),
          trailing: Material(
            child: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                showBox(text: 'Delete this contact?'.tr, context: context)
                    .then((bool delete) {
                  if (delete) {
                    contact.delete().then((_) {
                      Navigator.of(context).maybePop();
                    });
                  }
                });
              },
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(<Widget>[
            contact.description.onListTile(tap: onTap),
          ]),
        ),
      ]),
    );
  }
}
