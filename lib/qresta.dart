// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

/// The qresta library.
///
/// This is an awesome library. More dartdocs go here.
library qresta;

// TODO: Export any libraries intended for clients of this package.

export 'src/qresta_base.dart';

import 'dart:io';
main() {
  HttpServer.bind('127.0.0.1', 3000).then((server) {
    server.listen((HttpRequest request) {
      request.response.write('Hello, Welcome to Dart');
      request.response.close();
    });
  });
}
