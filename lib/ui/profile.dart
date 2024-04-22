import 'package:firebase_auth/firebase_auth.dart';
import 'package:floating_snackbar/floating_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:idleread/modals/colors.dart';
import 'package:idleread/ui/signinscreens.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    myColors mcol = myColors();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            title: Text(
          "My Profile",
          style: GoogleFonts.poppins(fontSize: 32, fontWeight: FontWeight.w500),
        )),
        body: SafeArea(
          child: SizedBox(
            width: size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(200),
                  child: Image.asset(
                    "assets/profile.jpeg",
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30.0, bottom: 40),
                  child: Container(
                    width: size.width * 0.9,
                    height: size.height * 0.15,
                    decoration: BoxDecoration(
                        color: mcol.lightwhite,
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Name: ",
                                  style: GoogleFonts.poppins(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  width: size.width * 0.55,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Text(
                                      FirebaseAuth
                                          .instance.currentUser!.displayName!,
                                      style: GoogleFonts.poppins(
                                        fontSize: 30,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Email: ",
                                  style: GoogleFonts.poppins(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  width: size.width * 0.55,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Text(
                                      FirebaseAuth.instance.currentUser!.email!,
                                      style: GoogleFonts.poppins(
                                        fontSize: 30,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ]),
                    ),
                  ),
                ),
                SizedBox(
                  width: size.width * 0.9,
                  height: 60,
                  child: ElevatedButton(
                      onPressed: () async {
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                alignment: Alignment.bottomCenter,
                                content: SizedBox(
                                  width: size.width,
                                  child: Text(
                                    "Are you sure to sign out?",
                                    style: GoogleFonts.poppins(
                                        fontSize: 28,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                actionsAlignment: MainAxisAlignment.center,
                                actions: [
                                  SizedBox(
                                    width: size.width * 0.3,
                                    height: 40,
                                    child: ElevatedButton(
                                        onPressed: () async {
                                          await FirebaseAuth.instance
                                              .signOut()
                                              .then((value) {
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        SignInPage()));
                                            FloatingSnackBar(
                                                message:
                                                    "Successfully Signed Out!",
                                                context: context,
                                                textStyle: GoogleFonts.poppins(
                                                    fontSize: 24));
                                          }).catchError((e) {
                                            FloatingSnackBar(
                                                message: "Error Signing out",
                                                context: context,
                                                textStyle: GoogleFonts.poppins(
                                                    fontSize: 24));
                                          });
                                        },
                                        style: ElevatedButton.styleFrom(
                                            foregroundColor: mcol.black,
                                            backgroundColor: mcol.lightorange,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10))),
                                        child: Text(
                                          "Yes",
                                          style: GoogleFonts.poppins(
                                              fontSize: 34,
                                              fontWeight: FontWeight.w700),
                                        )),
                                  ),
                                  SizedBox(
                                    width: size.width * 0.3,
                                    height: 40,
                                    child: ElevatedButton(
                                        onPressed: () async {
                                          Navigator.pop(context);
                                        },
                                        style: ElevatedButton.styleFrom(
                                            foregroundColor: mcol.black,
                                            backgroundColor: mcol.lightwhite,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10))),
                                        child: Text(
                                          "No",
                                          style: GoogleFonts.poppins(
                                              fontSize: 34,
                                              fontWeight: FontWeight.w700),
                                        )),
                                  ),
                                ],
                              );
                            });
                      },
                      style: ElevatedButton.styleFrom(
                          foregroundColor: mcol.black,
                          backgroundColor: mcol.lightorange,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      child: Text(
                        "Sign Out",
                        style: GoogleFonts.poppins(
                            fontSize: 34, fontWeight: FontWeight.w700),
                      )),
                ),
                SizedBox(
                  height: 100,
                )
              ],
            ),
          ),
        ));
  }
}
