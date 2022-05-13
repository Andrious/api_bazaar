// Copyright 2022 Andrious Solutions Ltd. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
///
///  The 'Image' State Object Controller.
///
import 'dart:async';
import 'dart:convert' show json;

import 'package:api_bazaar/src/controller.dart';
import 'package:api_bazaar/src/view.dart';

import 'package:http/http.dart' as http;

/// This is the 'image API' State Object Controller.
class ImageAPIController extends ControllerMVC {
  /// Not a factory constructor and so multiple instances of this class is possible.
  ImageAPIController([StateMVC? state]) : super(state);

  /// The resulting url
  String? url;

  /// The resulting image from the API.
  Image? image;

  ///
  void onTap() => state?.setState(() {});

  /// The number of images loading using this class.
  static int imageCount = 0;

  /// The number of images currently loading
  static int loadingCount = 0;

  /// Contains all the asynchronous operations that must complete before proceeding.
  @override
  Future<bool> initAsync() async {
    // Call the API
    /// The List of data returned by the API.
    final List<String> _data = await _getURIData(retry: 5);

    final init = _data.isNotEmpty;

    if (init) {
      url = _data[0];
      image = Image.network(url!);
      final imageStream = image!.image.resolve(const ImageConfiguration());
      final completer = Completer<void>();
      imageCount++;
      loadingCount++;
      final listener = ImageStreamListener((ImageInfo info, bool syncCall) {
        // Error if called again and so test if completed.
        if (!completer.isCompleted) {
          completer.complete();
          loadingCount--;
          if (loadingCount == 0) {
            /// All the image(s) have completed loading.
          }
        }
      });
      imageStream.addListener(listener);
      await completer.future;
      // No need anymore. Best to remove in case triggered again.
      imageStream.removeListener(listener);
    }
    return init;
  }

  /// Retrieve the data
  Future<List<String>> _getURIData({int? retry}) async {
    // Retry in number of time in case of error.
    retry ??= 0;

    //
    final List<String> data = [];

    // Cast to the abstract class with the two properties.
    final _api = state as ImageAPIState;

    final key = _api.key;

    final uri = _api.uri;

    if (uri != null) {
      //
      http.Response? response;

      dynamic jsonResponse;

      int cnt = -1;

      while (cnt < retry) {
        cnt++;
        try {
          //
          response = await http.get(uri);
          jsonResponse = json.decode(response.body);
          if (jsonResponse == null) {
            continue;
          }
          break;
        } catch (ex) {
          if (cnt >= retry) {
            rethrow;
          }
        }
      }

      dynamic dataItem;

      if (jsonResponse is List) {
        int index;
        if (key == null || key.isEmpty || double.tryParse(key) == null) {
          index = 0;
        } else {
          index = int.parse(key);
          if (index < 0 || index >= jsonResponse.length) {
            index = 0;
          }
        }
        dataItem = jsonResponse[index];
      } else if (jsonResponse is Map) {
        if (key == null || key.isEmpty) {
          // Just the first entry
          dataItem = jsonResponse.entries.first;
        } else {
          dataItem = jsonResponse[key];
        }
      }

      // It was successful
      if (response != null && response.statusCode == 200) {
        if (dataItem != null) {
          switch (dataItem.runtimeType) {
            case List:
              dataItem.forEach(data.add);
              break;
            case MapEntry<String, dynamic>:
              final value = (dataItem as MapEntry).value;
              if (value is String) {
                data.add(value);
              }
              break;
            case String:
              data.add(dataItem);
              break;
          }
        }
      } else {
        //
        var message = '${uri.scheme}://${uri.host}${uri.path}';

        if (jsonResponse != null) {
          //
          switch (jsonResponse.runtimeType) {
            case List:
              message = '$message\r\n${jsonResponse[0]}';
              break;
            case String:
              message = '$message\r\n$jsonResponse';
              break;
            default:
              if (jsonResponse is Map) {
                final buffer = StringBuffer();
                buffer.write(message);
                for (final map in jsonResponse.entries) {
                  buffer.write('\r\n${map.key}:${map.value}');
                }
                message = buffer.toString();
              }
          }
        }
        throw Exception(message);
      }
    }
    return data;
  }

  /// Supply an 'error handler' routine if something goes wrong
  /// in the corresponding initAsync() routine.
  @override
  bool onAsyncError(FlutterErrorDetails details) => false;
}
