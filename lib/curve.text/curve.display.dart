import 'package:flutter/material.dart';
import 'package:flutter_arc_text/flutter_arc_text.dart';

import 'package:google_fonts/google_fonts.dart';

class CurveDisplay extends StatelessWidget {
  const CurveDisplay({Key? key}) : super(key: key);
 final  String title = "Selamat Datang Ke Buku Teks Digital Sejarah Tingkatan 3";
  final String subtitle = "Nilai, Patriotisme, Iktibar, Jom Belajar!";

  @override
  Widget build(BuildContext context) {
    var lebar = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/Malaysian_History.png"))),
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
                            fontSize: 48, fontWeight: FontWeight.w700),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 700,
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Center(
                            child: ArcText(
                                radius: 210,
                                text: subtitle,
                                textStyle: const TextStyle(
                                    fontSize: 18, color: Colors.black),
                                startAngle: 2.37,
                                startAngleAlignment: StartAngleAlignment.end,
                                placement: Placement.outside,
                                direction: Direction.counterClockwise),
                          ),
                        ),
                      ),
                    ],
                  )),

              // SizedBox(height: 60,),

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
                        onPressed: () {},
                        child: Text("Mulakan",
                            style: GoogleFonts.poppins(
                              fontSize: 27,
                              color: Colors.white,
                            ))),
                    CircleAvatar(
                        backgroundColor: Colors.white,
                        child: IconButton(
                            onPressed: () {},
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
