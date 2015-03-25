// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

// TODO: Put public facing types in this file.

library qresta.base;

import 'dart:io';
import 'dart:async';
import 'dart:isolate';
import 'dart:mirrors';

part "front_controller.dart";
part "annotation/resource.dart";
part "core/annotation_resource_manager.dart";

@Resource("vamosver")
class Teste {
  
  @Resource("new")
  void teste() {
    
  }
}

void main() {
  AnnotationResourceManager annotationManager = new AnnotationResourceManager();
  annotationManager.initialize();
}




//void CostlyProcess(SendPort replyTo) {
//  var port = new ReceivePort();
//  replyTo.send(port.sendPort);
//  port.listen((msg) {
//    var data = msg[0];
//    replyTo = msg[1];
//    if (data == "START") {
//      replyTo.send("Running costly process....");
//// Costly stuff here
//      replyTo.send("END");
//      port.close();
//    }
//  });
//}
//void main() {
//  HttpServer.bind('127.0.0.1', 3000).then((server) {
//    FrontController frontController = new FrontController();
//    ReceivePort reply = new ReceivePort();
//
//
//
//
//    server.listen((HttpRequest request) {
//      Future<Isolate> iso = Isolate.spawn(CostlyProcess, reply.sendPort);
//      iso.then((_) => reply.first).then((port) {
//// Once we've created the Isolate, we send the start message process and
//// we're waiting to receive a reply from the costly process.
//        reply = new ReceivePort();
//        port.send(["START", reply.sendPort]);
//        reply.listen((msg) {
//          print('Message received from isolate: $msg');
//          if (msg == "END") {
//            print('Costly process completed successfully !!!');
//            reply.close();
//          }
//        });
//      });
//
//
//
//    });
//  });