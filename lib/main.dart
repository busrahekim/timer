import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(textTheme: GoogleFonts.ralewayTextTheme()),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Timer _timer;
  int _seconds = 0;
  String _timerText = '';

  @override
  Widget build(BuildContext context) {
    final duration = Duration(seconds: _seconds);
    _timerText = duration.toString().split('.').first.padLeft(8, '0');

    return Scaffold(
      body: SafeArea(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          color: _isTimerActive
              ? const Color(0xFFE7626C)
              : const Color(0xFF232B55),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 32),
              child: Column(
                children: [
                  Text(
                    'Elapsed Time',
                    style: GoogleFonts.raleway(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 50,
                    ),
                  ),
                  Text(
                    '$_timerText',
                    style: GoogleFonts.raleway(
                      color: Colors.white,
                      fontSize: 44,
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: InkWell(
                        onTap: () {
                          if (_isTimerActive) {
                            setState(() {
                              _timer.cancel();
                              _seconds = 0;
                            });
                          } else {
                            _timer =
                                Timer.periodic(Duration(seconds: 1), (timer) {
                              setState(() {
                                _seconds++;
                              });
                            });
                          }
                        },
                        child: Container(
                          child: Icon(
                            _isTimerActive ? Icons.stop : Icons.play_arrow,
                            size: 150,
                            color: Colors.white,
                          ),
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(100)),
                            color: _isTimerActive
                                ? const Color(0xFF232B55)
                                : const Color(0xFFE7626C),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool get _isTimerActive => (_timer != null && _timer.isActive);
}
