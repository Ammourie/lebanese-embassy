import 'package:flutter/material.dart';
import 'waiting_widget.dart';


class LoadingOverlay {
  BuildContext _context;

  void hide() {
    Navigator.of(_context).pop();
  }

  void show() async {
    await showDialog(
      context: _context,
      barrierDismissible: false,
      barrierColor: Colors.white.withAlpha(150),
      builder: (BuildContext context) => _FullScreenLoader(),
    );
  }

  Future<T> during<T>(Future<T> future) {
    show();
    return future.whenComplete(() => hide());
  }

  LoadingOverlay._create(this._context);

  factory LoadingOverlay.of(BuildContext context) => LoadingOverlay._create(context);
}

class _FullScreenLoader extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FullScreenLoaderState();
}

class _FullScreenLoaderState extends State<_FullScreenLoader> {
  @override
  Widget build(BuildContext context) => WaitingWidget();
}
