import 'package:animated_background/animated_background.dart';
import 'package:aqwise_stripe_payment/quiz/rain.particle.dart';
import 'package:flame_audio/audio_pool.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> with TickerProviderStateMixin {
  get wrongAnswer => () async {
        if (pool != null) {
          await pool!.start();
        }
        setState(() {
          _behaviourIndex = 2;
        });
        if (!mounted) return;
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Wrong answer')));
        Future.delayed(const Duration(seconds: 3), () {
          setState(() {
            _behaviourIndex = 0;
          });
        });
      };

  get correctAnswer => () async {
        await FlameAudio.play('correct.mp3');
        setState(() {
          _behaviourIndex = 1;
        });
        if (!mounted) return;
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Correct answer')));
        Future.delayed(const Duration(seconds: 3), () {
          setState(() {
            _behaviourIndex = 0;
          });
        });
      };
  final bool _showSettings = false;
  int _behaviourIndex = 0;

  var particlePaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1.0;
  AudioPool? pool;

  @override
  void initState() {
    // TODO: implement initState

    loadMusic();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    FlameAudio.bgm.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ParticleOptions particleOptions = ParticleOptions(
      image: _behaviourIndex == 1
          ? Image.asset('assets/images/star_stroke.png')
          : Image.asset('assets/images/water_droplet.png'),
      baseColor: Colors.blue,
      spawnOpacity: 1,
      opacityChangeRate: -0.35,
      minOpacity: 0,
      maxOpacity: 0,
      spawnMinSpeed: 30.0,
      spawnMaxSpeed: 70.0,
      spawnMinRadius: 7.0,
      spawnMaxRadius: 15.0,
      particleCount: 100,
    );
    Behaviour buildBehaviour() {
      switch (_behaviourIndex) {
        case 0:
          return EmptyBehaviour();
        case 1:
          return RandomParticleBehaviour(
            options: particleOptions,
            paint: particlePaint,
          );
        case 2:
          return RainParticleBehaviour(
            options: particleOptions,
            paint: particlePaint,
            enabled: !_showSettings,
          );
      }

      return RandomParticleBehaviour(
        options: particleOptions,
        paint: particlePaint,
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: Text('Quiz Example'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: AnimatedBackground(
            behaviour: buildBehaviour(),
            vsync: this,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                    'Question 1: What is programming language for Flutter??'),
                ElevatedButton(
                    onPressed: correctAnswer, child: const Text('A) Dart')),
                ElevatedButton(
                    onPressed: wrongAnswer, child: const Text('B) PHP')),
                ElevatedButton(
                    onPressed: wrongAnswer, child: const Text('C) Java')),
                ElevatedButton(
                    onPressed: wrongAnswer, child: const Text('D) Phyton')),
              ],
            ),
          ),
        ));
  }

  Future<void> loadMusic() async {
    await FlameAudio.bgm.play('music_bg.mp3');
    pool = await FlameAudio.createPool(
      'wrong.mp3',
      minPlayers: 3,
      maxPlayers: 4,
    );
  }
}
