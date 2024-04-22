import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:idleread/modals/colors.dart';
import 'package:idleread/ui/signinscreens.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    myColors mcol = myColors();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Image.asset(
            "assets/welcomebooks.jpg",
            width: size.width,
            height: size.height,
            fit: BoxFit.cover,
          ),
          Positioned(
              bottom: 0,
              child: Container(
                width: size.width,
                height: size.height * 0.3,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40), color: mcol.white),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            width: size.width * 0.5,
                            height: 10,
                            decoration: BoxDecoration(
                                color: mcol.black,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 20.0),
                              child: Row(
                                children: [
                                  Text(
                                    "Welcome to ",
                                    style: GoogleFonts.poppins(
                                        fontSize: 40,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    "IDLEREAD",
                                    style: GoogleFonts.poppins(
                                        color: mcol.darkorange,
                                        fontSize: 40,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              "\"where knowledge meets convenience\"",
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                              ),
                            ),
                          ],
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                            child: SizedBox(
                              width: size.width * 0.8,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SignInPage()));
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: mcol.orange,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    foregroundColor: mcol.black),
                                child: Text(
                                  "GET STARTED",
                                  style: GoogleFonts.poppins(
                                      fontSize: 34,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        )
                      ]),
                ),
              ))
        ],
      ),
    );
  }
}
