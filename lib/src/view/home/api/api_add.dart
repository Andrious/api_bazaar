// Copyright 2022 Andrious Solutions Ltd. All rights reserved.
// Use of this source code is governed by a Apache license that can be
// found in the LICENSE file.

import 'package:api_bazaar/src/model.dart';

import 'package:api_bazaar/src/view.dart';

/// Add the API screen.
class AddAPIs extends StatefulWidget {
  ///
  const AddAPIs({this.api, this.title, Key? key}) : super(key: key);

  ///
  final APIs? api;

  ///
  final String? title;
  @override
  State createState() => _AddAPIsState();
}

/// Should always keep your State class 'hidden' with the leading underscore
class _AddAPIsState extends StateMVC<AddAPIs> {
  @override
  void initState() {
    super.initState();
    api = widget.api ?? APIs();
    //Link to this State object
    api.pushState(this);
  }

  // Either an 'empty' contact or a contact passed to class, AddContact
  late APIs api;

  @override
  void dispose() {
    // Detach from the State object.
    api.popState();
    super.dispose();
  }

  // Use the appropriate interface depending on the platform.
  // Called everytime the setState() function is called.
  @override
  Widget build(BuildContext context) =>
      App.useMaterial ? _BuildAndroid(state: this) : _BuildiOS(state: this);
}

/// The Android interface.
class _BuildAndroid extends StatelessWidget {
  const _BuildAndroid({Key? key, required this.state}) : super(key: key);
  final _AddAPIsState state;

  @override
  Widget build(BuildContext context) {
    final widget = state.widget;
    final contact = state.api;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title ?? 'Add a contact'.tr),
        actions: [
          TextButton(
            onPressed: () async {
              final pop = await contact.onPressed();
              if (pop) {
                await contact.model.getAPIs();
                Navigator.of(context).pop();
              }
            },
            child: const Icon(Icons.save, color: Colors.white),
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: contact.formKey,
          child: ListView(
            children: [
              contact.description.textFormField,
            ],
          ),
        ),
      ),
    );
  }
}

/// The iOS interface
class _BuildiOS extends StatelessWidget {
  const _BuildiOS({Key? key, required this.state}) : super(key: key);
  final _AddAPIsState state;

  @override
  Widget build(BuildContext context) {
    final widget = state.widget;
    final contact = state.api;
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: CupertinoNavigationBarBackButton(
          previousPageTitle: 'Home',
          onPressed: () {
            Navigator.of(context).maybePop();
          },
        ),
        middle: Text(widget.title ?? 'Add a contact'.tr),
        trailing: Material(
          child: TextButton(
            onPressed: () async {
              final pop = await contact.onPressed();
              if (pop) {
                await contact.model.getAPIs();
                Navigator.of(context).pop();
              }
            },
            child: const Icon(Icons.save),
          ),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: contact.formKey,
          child: ListView(
            children: [
              contact.description.textFormField,
            ],
          ),
        ),
      ),
    );
  }
}
