
import 'dart:async';

import 'package:rxdart/rxdart.dart';

class PublishSubject<T> extends Subject<T> {
  PublishSubject._(StreamController<T> controller, Observable<T> observable)
      : super(controller, observable);
  factory PublishSubject(
      {void onListen(), Future<dynamic> onCancel(), bool sync: false}) {
    final StreamController<T> controller = new StreamController<T>.broadcast(
      onListen: onListen,
      onCancel: onCancel,
      sync: sync,
    );
    return new PublishSubject<T>._(
      controller,
      new Observable<T>(controller.stream),
    );
  }
}
