import 'package:flutter/material.dart';

const Color scoreTextColor = Color(0xFF00FF01);
const Color foulTextColor = Color(0xFFFCFD13);

enum Team { first, second }

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _score1 = 0;
  int _score2 = 0;
  int _foul1 = 0;
  int _foul2 = 0;

  void _reset() {
    setState(() {
      _score1 = 0;
      _score2 = 0;
      _foul1 = 0;
      _foul2 = 0;
    });
  }

  void _addScore(Team team, int score) {
    switch (team) {
      case Team.first:
        setState(() {
          _score1 += score;
        });
        break;
      case Team.second:
        setState(() {
          _score2 += score;
        });
        break;
    }
  }

  void _addFoul(Team team) {
    switch (team) {
      case Team.first:
        setState(() {
          _foul1++;
        });
        break;
      case Team.second:
        setState(() {
          _foul2++;
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                _scoreItem(
                  title: 'Team 1',
                  score: _score1,
                  addScore: (score) => _addScore(Team.first, score),
                ),
                _scoreItem(
                  title: 'Team 2',
                  score: _score2,
                  addScore: (score) => _addScore(Team.second, score),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () => _addFoul(Team.first),
                  child: const Text('+1'),
                ),
                Text(
                  '$_foul1',
                  style: const TextStyle(color: foulTextColor, fontSize: 24),
                ),
                const Text(
                  'Fouls',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                Text(
                  '$_foul2',
                  style: const TextStyle(color: foulTextColor, fontSize: 24),
                ),
                ElevatedButton(
                  onPressed: () => _addFoul(Team.second),
                  child: const Text('+1'),
                ),
              ],
            ),
            ElevatedButton(onPressed: _reset, child: const Text('Reset'))
          ],
        ),
      ),
    );
  }
}

Widget _scoreItem({
  required String title,
  required int score,
  required Function(int) addScore,
}) {
  return Expanded(
    child: Column(
      children: [
        Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 30),
        ),
        const SizedBox(height: 24),
        Text(
          '$score',
          style: const TextStyle(color: scoreTextColor, fontSize: 40),
        ),
        const SizedBox(height: 24),
        ElevatedButton(onPressed: () => addScore(1), child: const Text('+1')),
        ElevatedButton(onPressed: () => addScore(2), child: const Text('+2')),
        ElevatedButton(onPressed: () => addScore(3), child: const Text('+3')),
      ],
    ),
  );
}
