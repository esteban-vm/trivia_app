import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:html_unescape/html_unescape.dart';

class GamePageProvider extends ChangeNotifier {
  final Dio _dio = Dio();
  final HtmlUnescape _unescape = HtmlUnescape();
  final int _maxQuestions = 10;
  final BuildContext context;
  final String difficulty;
  int _questionIndex = 0;
  int _playerScore = 0;
  List? questions;

  GamePageProvider({required this.context, required this.difficulty}) {
    _dio.options.baseUrl = 'https://opentdb.com';
    _loadQuestions();
  }

  String get currentQuestion {
    return _unescape.convert(questions![_questionIndex]['question']);
  }

  Future<void> _loadQuestions() async {
    Response response = await _dio.get(
      '/api.php',
      queryParameters: {
        'amount': _maxQuestions,
        'type': 'boolean',
        'difficulty': difficulty,
      },
    );

    Map data = jsonDecode(response.toString());
    questions = data['results'];
    notifyListeners();
  }

  Future<void> _gameOver() async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.blue,
          title: const Text(
            'Game Over!',
            style: TextStyle(
              fontSize: 25.0,
              color: Colors.white,
            ),
          ),
          content: Text('Score: $_playerScore/$_maxQuestions'),
        );
      },
    );
    await Future.delayed(
      const Duration(seconds: 3),
      () {
        Navigator.pop(context);
        Navigator.pop(context);
      },
    );
  }

  Future<void> checkAnswer(String answer) async {
    bool isCorrect = questions![_questionIndex]['correct_answer'] == answer;
    if (isCorrect) _playerScore++;
    _questionIndex++;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: isCorrect ? Colors.green : Colors.red,
        title: Icon(
          isCorrect ? Icons.check_circle : Icons.cancel_sharp,
          color: Colors.white,
        ),
      ),
    );
    await Future.delayed(
      const Duration(seconds: 1),
      () {
        Navigator.pop(context);
      },
    );
    if (_questionIndex == _maxQuestions) {
      _gameOver();
    } else {
      notifyListeners();
    }
  }
}
