import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trivia_app/providers/game_page_provider.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key, required this.difficulty});
  final String difficulty;

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  late GamePageProvider _gamePageProvider;
  late double _deviceWidth;
  late double _deviceHeight;

  @override
  Widget build(context) {
    _deviceWidth = MediaQuery.of(context).size.width;
    _deviceHeight = MediaQuery.of(context).size.height;

    return ChangeNotifierProvider(
      create: (_) => GamePageProvider(
        context: context,
        difficulty: widget.difficulty,
      ),
      child: Builder(
        builder: (context) {
          _gamePageProvider = context.watch<GamePageProvider>();
          if (_gamePageProvider.questions != null) {
            return _gameUI();
          } else {
            return _progressIndicator();
          }
        },
      ),
    );
  }

  Widget _gameUI() {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: _deviceHeight * 0.05,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _currentQuestion(),
              Column(
                children: <Widget>[
                  _answerButton('True', Colors.green),
                  _spaceSeparator(),
                  _answerButton('False', Colors.red),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _currentQuestion() {
    return Text(
      _gamePageProvider.currentQuestion,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 25.0,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget _spaceSeparator() {
    return SizedBox(height: _deviceHeight * 0.01);
  }

  Widget _progressIndicator() {
    return const Center(
      child: CircularProgressIndicator(color: Colors.white),
    );
  }

  Widget _answerButton(String text, Color color) {
    return MaterialButton(
      color: color,
      onPressed: () {
        _gamePageProvider.checkAnswer(text);
      },
      minWidth: _deviceWidth * 0.80,
      height: _deviceHeight * 0.10,
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 25.0,
        ),
      ),
    );
  }
}
