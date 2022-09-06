import 'dart:async';

import 'package:flutter/material.dart';
import 'package:interview1/constants.dart';
import 'package:interview1/widgets/drawer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Interview',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Urbanist',
      ),
      home: const MyHomePage(title: 'Interview'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _questions = const [
    {
      'questionText': 'Q1. Who created Flutter?',
      'answers': [
        {'text': 'Facebook', 'score': -2},
        {'text': 'Adobe', 'score': -2},
        {'text': 'Google', 'score': 10},
        {'text': 'Microsoft', 'score': -2},
      ],
    },
    {
      'questionText': 'Q2. What is Flutter?',
      'answers': [
        {'text': 'Android Development Kit', 'score': -2},
        {'text': 'IOS Development Kit', 'score': -2},
        {'text': 'Web Development Kit', 'score': -2},
        {
          'text':
              'SDK to build beautiful IOS, Android, Web & Desktop Native Apps',
          'score': 10
        },
      ],
    },
    {
      'questionText': ' Q3. Which programing language is used by Flutter',
      'answers': [
        {'text': 'Ruby', 'score': -2},
        {'text': 'Dart', 'score': 10},
        {'text': 'C++', 'score': -2},
        {'text': 'Kotlin', 'score': -2},
      ],
    },
    {
      'questionText': 'Q4. Who created Dart programing language?',
      'answers': [
        {'text': 'Lars Bak and Kasper Lund', 'score': 10},
        {'text': 'Brendan Eich', 'score': -2},
        {'text': 'Bjarne Stroustrup', 'score': -2},
        {'text': 'Jeremy Ashkenas', 'score': -2},
      ],
    },
    {
      'questionText':
          'Q5. Is Flutter for Web and Desktop available in stable version?',
      'answers': [
        {
          'text': 'Yes',
          'score': -2,
        },
        {'text': 'No', 'score': 10},
      ],
    },
  ];
  var _questionIndex = 0;
  var _totalScore = 0;
  bool isGameOver = false;

  late Timer _timer;
  int _start = 15;
  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
      _start = 15;
      isGameOver = false;
    });
  }

  String get resultPhrase {
    String resultText;
    if (_totalScore >= 41) {
      resultText = 'You are awesome!';
    } else if (_totalScore >= 31) {
      resultText = 'Pretty likeable! ';
    } else if (_totalScore >= 21) {
      resultText = 'You need to work more! ';
    } else if (_totalScore >= 1) {
      resultText = 'You need to work hard!  ';
    } else {
      resultText = 'This is a poor score!   ';
    }
    return resultText;
  }

  //create function for timer
  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            isGameOver = true;
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  void _onTapHandler(int index) {
    print(index);
    if (index == 0) {
      startTimer();
    } else {
      _resetQuiz();
    }
  }

  void _answerQuestion(int score) {
    _totalScore += score;

    setState(() {
      _questionIndex = _questionIndex + 1;
    });
    // ignore: avoid_print
    print(_questionIndex);
    if (_questionIndex < _questions.length) {
      // ignore: avoid_print
      print('We have more questions!');
    } else {
      // ignore: avoid_print
      print('No more questions!');
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideDrawer(),
      appBar: AppBar(
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: kDarckColor),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              color: kDarckColor,
              size: 30,
            ),
          ),
          //nortification icon with badge
          Stack(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.notifications,
                  color: kDarckColor,
                  size: 30,
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  width: 18,
                  height: 18,
                  decoration: const BoxDecoration(
                    color: kPrimaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      _questions.length.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
        title: const Text(
          "Futter Quiz",
          style: TextStyle(
              color: kDarckColor, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          isGameOver
              ? result(_totalScore, _resetQuiz, true)
              : _questionIndex < _questions.length
                  ? quiz()
                  : result(_totalScore, _resetQuiz, false),
          const SizedBox(
            height: 30,
          ),
          timeCounter(_start)
        ],
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
            canvasColor: kBackColor,
            primaryColor: kPrimaryColor,
            textTheme: Theme.of(context)
                .textTheme
                .copyWith(caption: const TextStyle(color: kDarckColor))),
        child: BottomNavigationBar(
          onTap: _onTapHandler,
          type: BottomNavigationBarType.fixed,
          currentIndex: 0,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.play_arrow_outlined),
              label: "Start",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.restore),
              label: "Reset",
            )
          ],
        ),
      ),
    );
  }

  Widget questionCard(String image, String message) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(image: AssetImage(image))),
        ),
        const SizedBox(
          width: 10,
        ),
        Container(
          width: 250,
          height: 100,
          decoration: const BoxDecoration(
              color: kBackColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10))),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              message,
              style: const TextStyle(
                  color: kDarckColor,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }

  Widget answerCard(String answer, Function selectAnswer) {
    return InkWell(
      onTap: (() => selectAnswer()),
      child: Padding(
        padding: const EdgeInsets.only(right: 20.0, top: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: 250,
              height: 50,
              decoration: const BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  answer,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget quiz() {
    return Column(
      children: [
        questionCard("assets/user.png",
            _questions[_questionIndex]['questionText'].toString()),
        ...(_questions[_questionIndex]['answers'] as List<Map<String, Object>>)
            .map((answer) {
          int score = answer['score'] as int;
          return answerCard(
              answer['text'].toString(), () => _answerQuestion(score));
        }).toList()
      ],
    );
  }

  Widget result(int totalScore, void Function() resetQuiz, bool gameOver) {
    return Column(
      children: [
        questionCard(
            "assets/user.png",
            gameOver
                ? "Time up game over $resultPhrase. Your score is $totalScore"
                : "$resultPhrase. Your score is $totalScore"),
        const SizedBox(
          height: 30,
        ),
        InkWell(
          onTap: (() => resetQuiz()),
          child: Padding(
            padding: const EdgeInsets.only(right: 20.0, top: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 200,
                  height: 50,
                  decoration: const BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10))),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Reset Quiz",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  //create time counter widget
  Widget timeCounter(int time) {
    return InkWell(
      onTap: () {
        time == 15
            ? startTimer()
            : time == 0
                ? _resetQuiz()
                : null;
      },
      child: Container(
        alignment: Alignment.bottomCenter,
        width: 100,
        height: 100,
        decoration: const BoxDecoration(
          color: kBackColor,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: time == 15
              ? const Icon(
                  Icons.play_arrow_outlined,
                  size: 50,
                  color: kDarckColor,
                )
              : time == 0
                  ? const Icon(
                      Icons.replay_10_outlined,
                      size: 50,
                      color: kDarckColor,
                    )
                  : Text(
                      "$time",
                      style: const TextStyle(
                        color: kDarckColor,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
        ),
      ),
    );
  }
}
