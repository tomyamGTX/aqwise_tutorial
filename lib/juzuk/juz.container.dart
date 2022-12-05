import 'package:aqwise_stripe_payment/juzuk/juz.model.dart';
import 'package:aqwise_stripe_payment/juzuk/juz.provider.dart';
import 'package:aqwise_stripe_payment/theme/theme.provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran/quran.dart';

class JuzContainer extends StatefulWidget {
  final Juz juzuk;

  final ThemeProvider themeProvider;

  const JuzContainer(
      {super.key, required this.juzuk, required this.themeProvider});

  @override
  State<JuzContainer> createState() => _JuzContainerState();
}

class _JuzContainerState extends State<JuzContainer> {
  List<String>? range;
  int length = 0;
  bool loading = true;
  @override
  void initState() {
    getSuraRange();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const CircularProgressIndicator()
        : Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: widget.themeProvider.isDarkMode
                    ? const Color(0xff67748E)
                    : const Color.fromRGBO(255, 255, 255, 1),
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
                border: Border.all(
                  color: widget.themeProvider.isDarkMode
                      ? const Color(0xffD2D6DA)
                      : const Color.fromRGBO(231, 111, 0, 1),
                  width: 1.3,
                )),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                      height: 50.0,
                      decoration: BoxDecoration(
                          color: widget.themeProvider.isDarkMode
                              ? const Color(0xff263d4a)
                              : const Color.fromRGBO(255, 238, 176, 1.0),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                          border: Border.all(
                            color: widget.themeProvider.isDarkMode
                                ? const Color(0xff263d4a)
                                : const Color.fromRGBO(255, 238, 176, 1.0),
                            width: 0.01,
                          )),
                      child: Center(
                        child: Text(
                          'Juz ${widget.juzuk.id}',
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              fontFamily: 'Open Sans',
                              fontSize: 24,
                              letterSpacing: -0.38723403215408325,
                              fontWeight: FontWeight.normal,
                              height: 1),
                        ),
                      )),
                  for (var i = 0; i <= length; i++)
                    Container(
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                          color: widget.themeProvider.isDarkMode
                              ? const Color(0xff67748E)
                              : const Color.fromRGBO(255, 255, 255, 1),
                          border: Border.all(
                            color: widget.themeProvider.isDarkMode
                                ? const Color(0xffD2D6DA)
                                : const Color.fromRGBO(231, 111, 0, 1),
                            width: 1,
                          )),
                      child: ListTile(
                        onTap: () async {},
                        leading: Container(
                            width: 33,
                            height: 65,
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                color: widget.themeProvider.isDarkMode
                                    ? const Color(0xff808ab1)
                                    : const Color.fromRGBO(255, 181, 94, 1),
                                border: Border.all(
                                  color: widget.themeProvider.isDarkMode
                                      ? const Color(0xffD2D6DA)
                                      : const Color.fromRGBO(255, 181, 94, 1),
                                  width: 1,
                                )),
                            child: Center(
                              child: Text(
                                "${int.parse(widget.juzuk.suraId!) + i}",
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                    fontFamily: 'Open Sans',
                                    fontSize: 17,
                                    letterSpacing: -0.38723403215408325,
                                    fontWeight: FontWeight.normal,
                                    height: 1),
                              ),
                            )),
                        title: Text(
                          getSurahName(int.parse(widget.juzuk.suraId!) + i),
                          style: const TextStyle(
                            fontFamily: 'Open Sans',
                            fontSize: 18,
                            letterSpacing: -0.38723403215408325,
                            fontWeight: FontWeight.normal,
                            height: 1,
                          ),
                          maxLines: 1,
                        ),
                        subtitle: Text(
                          getSurahNameEnglish(
                              int.parse(widget.juzuk.suraId!) + i),
                          style: const TextStyle(
                            fontFamily: 'Open Sans',
                            fontSize: 17,
                            letterSpacing: -0.38723403215408325,
                            fontWeight: FontWeight.normal,
                            height: 1,
                          ),
                          maxLines: 2,
                        ),
                        trailing: Container(
                            width: 63,
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                color: widget.themeProvider.isDarkMode
                                    ? const Color(0xff263d4a)
                                    : const Color.fromRGBO(255, 238, 176, 1.0),
                                border: Border.all(
                                  color: widget.themeProvider.isDarkMode
                                      ? const Color(0xffD2D6DA)
                                      : const Color.fromRGBO(
                                          255, 238, 176, 1.0),
                                  width: 1,
                                )),
                            child: Center(
                              child: Text(
                                range![i],
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontFamily: 'Open Sans',
                                    letterSpacing: -0.38723403215408325,
                                    fontWeight: FontWeight.normal,
                                    height: 1),
                                maxLines: 1,
                              ),
                            )),
                      ),
                    )
                ],
              ),
            ),
          );
  }

  Future<void> getSuraRange() async {
    length = Provider.of<JuzProvider>(context, listen: false)
        .getTotalSuraUnderJuz(widget.juzuk);
    setState(() {});
    range = await Provider.of<JuzProvider>(context, listen: false)
        .getRange(widget.juzuk);
    setState(() {
      loading = false;
    });
  }
}
