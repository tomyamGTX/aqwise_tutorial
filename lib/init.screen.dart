import 'package:aqwise_stripe_payment/authentication/home.dart';
import 'package:aqwise_stripe_payment/widgets/constant.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_arc_text/flutter_arc_text.dart';

import 'package:google_fonts/google_fonts.dart';

class InitScreen extends StatelessWidget {
  InitScreen({Key? key}) : super(key: key);
  String title = "Selamat Datang Ke AQ Wise Tutorial Flutter";
  String subtitle = "Learn, Understand, Implement, Let's Coding!";

  @override
  Widget build(BuildContext context) {
    var lebar = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      "https://static.vecteezy.com/system/resources/previews/001/849/553/original/modern-gold-background-free-vector.jpg"))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              SizedBox(
                  width: lebar * 0.75,
                  child: Stack(
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.poppins(
                            color: Colors.white70,
                            fontSize: 48,
                            fontWeight: FontWeight.w700),
                        textAlign: TextAlign.center,
                      ),
                      if (!kIsWeb)
                        SizedBox(
                          height: 600,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Center(
                              child: ArcText(
                                  radius: 210,
                                  text: subtitle,
                                  textStyle: const TextStyle(
                                      fontSize: 18, color: Colors.white),
                                  startAngle: 2.27,
                                  startAngleAlignment: StartAngleAlignment.end,
                                  placement: Placement.outside,
                                  direction: Direction.counterClockwise),
                            ),
                          ),
                        ),
                    ],
                  )),
              if (kIsWeb)
                Center(
                  child: Text(
                    subtitle,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              if (kIsWeb) const Spacer(),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            fixedSize: Size(lebar * 0.7, 50),
                            side: const BorderSide(color: Colors.white),
                            backgroundColor: Colors.transparent,
                            shape: const StadiumBorder()),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MyHomePage(
                                      title: 'AQ WISE - Tutorial App')));
                        },
                        child: Text("Mulakan",
                            style: GoogleFonts.poppins(
                              fontSize: 27,
                              color: Colors.white,
                            ))),
                    CircleAvatar(
                        backgroundColor: Colors.white,
                        child: IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const MyHomePage(
                                          title: 'AQ WISE - Tutorial App')));
                            },
                            icon: const Icon(
                              Icons.arrow_forward,
                              color: Colors.black,
                            )))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
