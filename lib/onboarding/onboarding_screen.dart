import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:lottie/lottie.dart';

import '../home.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return OnBoardingSlider(
      trailingFunction: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const MyHomePage(
                    title: 'AQWISE Tutorial',
                  ))),
      onFinish: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const MyHomePage(
                    title: 'AQWISE Tutorial',
                  ))),
      headerBackgroundColor: Colors.white,
      finishButtonText: 'Get Started',
      finishButtonStyle: const FinishButtonStyle(
        backgroundColor: Colors.black,
      ),
      skipTextButton: const Text('Skip'),
      trailing: const Text('Home'),
      background: [
        Lottie.asset("assets/json/Animation - 1691386267112.json",
            width: size.width, height: size.height * 0.5),
        Lottie.asset("assets/json/animation_ll0fxv8n.json",
            width: size.width, height: size.height * 0.7),
        Lottie.asset("assets/json/animation_ll0g9u12.json",
            width: size.width, height: size.height * 0.7),
      ],
      totalPage: 3,
      speed: 1.8,
      pageBodies: [
        ///1st page
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 480,
              ),
              Text(
                'Welcome to tutorial AQWise',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                    'You can learn many thing from flutter at this tutorial'),
              ),
            ],
          ),
        ),

        ///2nd page
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 480,
              ),
              Text(
                'Download the code and test it',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'You can download the code from github. Test it and apply to your own project',
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),

        ///3rd page
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 480,
              ),
              Text(
                "Satisy with the content?",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('If you satisfy, like , subscribe and share'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
