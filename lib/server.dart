import 'dart:async';
import 'dart:io';
import 'dart:math' as math;

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;

class Server {
  static Cascade? _cascade;
  static int? _port;
  static HttpServer? _server;

  Server();

  static int get _randomPort {
    math.Random rand = math.Random(DateTime.now().millisecondsSinceEpoch);
    return rand.nextInt(8976) + 1024;
  }

  add(FutureOr<Response> Function(Request) handler) {
    _cascade ??= Cascade();
    _cascade!.add(handler);
  }

  serve(int? port) async {
    port ??= _randomPort;
    _port ??= port;
    _cascade ??= Cascade();
    _server ??= await shelf_io.serve(
        logRequests().addHandler(_cascade!.handler),
        InternetAddress.anyIPv4,
        _port!);
  }
}
