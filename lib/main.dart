import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: HomePage()));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isStart = true;
  String _stopwatchText = '00:00:00';
  final _stopWatch = new Stopwatch();
  final _timeout = const Duration(seconds: 1);

  void _startTimeout() {
    new Timer(_timeout, _handleTimeout);
  }

  void _handleTimeout() {
    if (_stopWatch.isRunning) {
      _startTimeout();
    }
    setState(() {
      _setStopwatchText();
    });
  }

  void _startStopButtonPressed() {
    setState(() {
      if (_stopWatch.isRunning) {
        _isStart = true;
        _stopWatch.stop();
      } else {
        _isStart = false;
        _stopWatch.start();
        _startTimeout();
      }
    });
  }

  void _resetButtonPressed() {
    if (_stopWatch.isRunning) {
      _startStopButtonPressed();
    }
    setState(() {
      _stopWatch.reset();
      _setStopwatchText();
    });
  }

  void _setStopwatchText() {
    _stopwatchText = _stopWatch.elapsed.inHours.toString().padLeft(2, '0') +
        ':' +
        (_stopWatch.elapsed.inMinutes % 60).toString().padLeft(2, '0') +
        ':' +
        (_stopWatch.elapsed.inSeconds % 60).toString().padLeft(2, '0');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cronometro", textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
          child: Container(
        color: Colors.white,
        child: Center(
          child: Column(
          children: [
            Text(_stopwatchText,
                style: TextStyle(color: Colors.black45, fontSize: 40),
                textDirection: TextDirection.ltr),
            TextButton(
              style: TextButton.styleFrom(
                primary: Colors.blue,
              ),
              onPressed: _resetButtonPressed,
              child: Text('RESETAR'),
            )
          ],
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
        )),
      )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: Icon(
          _isStart ? Icons.play_arrow : Icons.stop,
          color: Colors.red,
          size: 40,
        ),
        onPressed: _startStopButtonPressed,
      ),
    );
  }
}
