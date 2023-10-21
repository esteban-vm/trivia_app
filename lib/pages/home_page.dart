import 'package:flutter/material.dart';
import 'package:trivia_app/pages/game_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> difficulties = ['Easy', 'Medium', 'Hard'];
  late String _difficulty;
  late double _deviceWidth;
  late double _deviceHeight;
  int _difficultyIndex = 0;

  @override
  void initState() {
    super.initState();
    _difficulty = difficulties[0];
  }

  @override
  Widget build(context) {
    _deviceWidth = MediaQuery.of(context).size.width;
    _deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: _deviceWidth * 0.10,
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _appTitle(),
                _difficultySlider(),
                _startButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _appTitle() {
    return Column(
      children: <Widget>[
        const Text(
          'Trivia App',
          style: TextStyle(
            color: Colors.white,
            fontSize: 50.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          _difficulty,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _difficultySlider() {
    return Slider(
      min: 0.0,
      max: 2.0,
      divisions: 2,
      label: 'Difficulty',
      value: _difficultyIndex.toDouble(),
      onChanged: (value) {
        setState(() {
          _difficultyIndex = value.toInt();
          _difficulty = difficulties[_difficultyIndex];
        });
      },
    );
  }

  Widget _startButton() {
    return MaterialButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GamePage(
              difficulty: _difficulty.toLowerCase(),
            ),
          ),
        );
      },
      color: Colors.blue,
      minWidth: _deviceWidth * 0.80,
      height: _deviceHeight * 0.10,
      child: const Text(
        'Start',
        style: TextStyle(
          color: Colors.white,
          fontSize: 25.0,
        ),
      ),
    );
  }
}
