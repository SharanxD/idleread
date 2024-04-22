import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:idleread/modals/articles.dart';
import 'package:idleread/modals/colors.dart';
import 'package:idleread/services/pdfview.dart';
import 'package:idleread/ui/profile.dart';
import 'package:idleread/ui/readScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String displayName = "";
  @override
  Widget build(BuildContext context) {
    myColors mcol = myColors();
    Size size = MediaQuery.of(context).size;
    setState(() {
      if (FirebaseAuth.instance.currentUser != null)
        displayName = FirebaseAuth.instance.currentUser!.displayName!;
    });
    print(displayName);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Welcome ",
                              style: GoogleFonts.poppins(fontSize: 30),
                            ),
                            Text(
                              (displayName.isNotEmpty
                                  ? displayName[0].toUpperCase() +
                                      displayName.substring(1)
                                  : "Loading"),
                              style: GoogleFonts.poppins(
                                  fontSize: 30, color: mcol.orange),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProfilePage()));
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.asset(
                              "assets/profile.jpeg",
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: size.width * 0.4,
                            height: 180,
                            decoration: BoxDecoration(
                                color: mcol.lightorange,
                                gradient: LinearGradient(
                                    begin: Alignment.center,
                                    end: Alignment.bottomRight,
                                    colors: [mcol.lightorange, mcol.white]),
                                borderRadius: BorderRadius.circular(40)),
                            child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    listarticles.length.toString(),
                                    style: GoogleFonts.poppins(
                                        fontSize: 100, color: mcol.white),
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "Articles",
                                        style: GoogleFonts.poppins(
                                            fontSize: 24,
                                            color: mcol.black,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        "Acquired",
                                        style: GoogleFonts.poppins(
                                            fontSize: 24,
                                            color: mcol.black,
                                            fontWeight: FontWeight.w600),
                                      )
                                    ],
                                  ),
                                ]),
                          ),
                          Container(
                            width: size.width * 0.4,
                            height: 180,
                            decoration: BoxDecoration(
                                color: mcol.lightorange,
                                gradient: LinearGradient(
                                    begin: Alignment.center,
                                    end: Alignment.bottomRight,
                                    colors: [mcol.lightorange, mcol.white]),
                                borderRadius: BorderRadius.circular(40)),
                            child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "2",
                                    style: GoogleFonts.poppins(
                                        fontSize: 100, color: mcol.white),
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "Articles",
                                        style: GoogleFonts.poppins(
                                            fontSize: 24,
                                            color: mcol.black,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        "Completed",
                                        style: GoogleFonts.poppins(
                                            fontSize: 24,
                                            color: mcol.black,
                                            fontWeight: FontWeight.w600),
                                      )
                                    ],
                                  ),
                                ]),
                          )
                        ],
                      ),
                    )
                  ]),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: size.height * 0.65,
                width: size.width,
                decoration: BoxDecoration(
                    color: mcol.lightorange,
                    gradient: LinearGradient(
                        begin: Alignment.center,
                        end: Alignment.bottomCenter,
                        colors: [mcol.lightorange, Colors.black]),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "My Articles",
                              style: GoogleFonts.poppins(
                                  fontSize: 30, fontWeight: FontWeight.w500),
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              child: Text(
                                "+  Add Article",
                                style: GoogleFonts.poppins(fontSize: 20),
                              ),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: mcol.black,
                                  foregroundColor: mcol.white),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        SizedBox(
                          height: size.height * 0.5,
                          width: size.width,
                          child: ListView.builder(
                              itemCount: listarticles.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => ReadScreen(
                                                  current:
                                                      listarticles[index])));
                                    },
                                    child: Container(
                                      width: size.width * 0.9,
                                      height: 80,
                                      decoration: BoxDecoration(
                                          color: mcol.white,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                      width:
                                                          size.width * 0.9 - 80,
                                                      child:
                                                          SingleChildScrollView(
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        child: Text(
                                                          listarticles[index]
                                                              .name,
                                                          style: GoogleFonts
                                                              .poppins(
                                                                  fontSize: 25,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: mcol
                                                                      .black),
                                                        ),
                                                      )),
                                                  Container(
                                                    width:
                                                        size.width * 0.9 - 100,
                                                    height: 2,
                                                    color: mcol.black,
                                                  ),
                                                  SizedBox(
                                                      width:
                                                          size.width * 0.9 - 80,
                                                      child:
                                                          SingleChildScrollView(
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        child: Text(
                                                          listarticles[index]
                                                              .authors,
                                                          style: GoogleFonts
                                                              .poppins(
                                                                  fontSize: 20,
                                                                  color: mcol
                                                                      .black),
                                                        ),
                                                      ))
                                                ],
                                              ),
                                              Icon(
                                                Icons.keyboard_arrow_right,
                                                size: 50,
                                              )
                                            ]),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        )
                      ]),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
