import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:floating_snackbar/floating_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:idleread/modals/colors.dart';
import 'package:idleread/ui/homescreen.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool loading = false;
  bool namevalid = false;
  bool pwdvalid = false;
  bool showpwd = false;
  final mailcontroller = TextEditingController();
  final pwdcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    myColors mcol = myColors();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Text(
              "Sign In",
              style: GoogleFonts.poppins(
                  fontSize: 34, fontWeight: FontWeight.w500),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Container(
              width: size.width * 0.5,
              height: 10,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [mcol.orange, mcol.black],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight),
                  color: mcol.orange,
                  borderRadius: BorderRadius.circular(10)),
            ),
          ),
          SizedBox(
            height: size.height * 0.05,
          ),
          Center(
            child: Container(
              width: size.width * 0.9,
              height: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: mcol.lightorange),
                  color: mcol.white),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: size.width * 0.7,
                      height: 60,
                      child: TextField(
                        controller: mailcontroller,
                        obscureText: false,
                        style: GoogleFonts.poppins(fontSize: 24),
                        onChanged: (text) {
                          setState(() {
                            namevalid = EmailValidator.validate(text);
                          });
                        },
                        decoration: InputDecoration(
                            hintText: "Email Address",
                            hintStyle: GoogleFonts.poppins(fontSize: 30),
                            border: InputBorder.none),
                      ),
                    ),
                    Icon(
                      Icons.mail,
                      size: 30,
                      color: mcol.black,
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0),
            child: Center(
              child: Container(
                width: size.width * 0.9,
                height: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: mcol.lightorange),
                    color: mcol.white),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: size.width * 0.7,
                        height: 60,
                        child: TextField(
                          controller: pwdcontroller,
                          obscureText: !showpwd,
                          style: GoogleFonts.poppins(fontSize: 24),
                          decoration: InputDecoration(
                              hintText: "Password",
                              hintStyle: GoogleFonts.poppins(fontSize: 30),
                              border: InputBorder.none),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            showpwd = !showpwd;
                          });
                        },
                        child: Icon(
                          showpwd ? Icons.visibility_off : Icons.visibility,
                          size: 30,
                          color: mcol.black,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ForgotPassword()));
            },
            child: Text(
              "Forgot Password?",
              style: GoogleFonts.poppins(fontSize: 24, color: mcol.lightorange),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Center(
              child: SizedBox(
                width: size.width * 0.9,
                height: 60,
                child: ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      loading = true;
                    });
                    if (mailcontroller.text.isNotEmpty &&
                        pwdcontroller.text.isNotEmpty) {
                      await FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: mailcontroller.text,
                              password: pwdcontroller.text)
                          .then((value) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()));
                      }).catchError((e) {
                        if (e.toString() ==
                            "[firebase_auth/invalid-credential] The supplied auth credential is incorrect, malformed or has expired.") {
                          FloatingSnackBar(
                              message: "Wrong Email/password",
                              context: context,
                              textStyle: GoogleFonts.poppins(fontSize: 24));
                        }
                        print(e.toString());
                      });
                    } else {
                      FloatingSnackBar(
                          message: "Please enter all details",
                          context: context,
                          textStyle: GoogleFonts.poppins(fontSize: 24));
                    }

                    setState(() {
                      loading = false;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: mcol.orange,
                      foregroundColor: mcol.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  child: loading
                      ? SpinKitThreeBounce(
                          size: 40,
                          color: mcol.black,
                        )
                      : Text(
                          "Sign In",
                          style: GoogleFonts.poppins(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: size.width * 0.4,
                  height: 10,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [mcol.orange, mcol.black],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight),
                      color: mcol.orange,
                      borderRadius: BorderRadius.circular(10)),
                ),
                Text(
                  "OR",
                  style: GoogleFonts.poppins(
                      fontSize: 24, fontWeight: FontWeight.w500),
                ),
                Container(
                  width: size.width * 0.4,
                  height: 10,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [mcol.orange, mcol.black],
                          begin: Alignment.centerRight,
                          end: Alignment.centerLeft),
                      color: mcol.orange,
                      borderRadius: BorderRadius.circular(10)),
                ),
              ],
            ),
          ),
          SizedBox(
              width: size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Dont have an account?",
                    style: GoogleFonts.poppins(fontSize: 20),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => SignUp()));
                      },
                      child: Text(
                        "Sign Up",
                        style: GoogleFonts.poppins(
                            fontSize: 24, color: mcol.darkorange),
                      ))
                ],
              ))
        ]),
      )),
    );
  }
}

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool loading = false;
  bool namevalid = false;
  bool pwdvalid = false;
  bool cnfvalid = false;
  bool showpwd = false;
  bool showcnf = false;
  bool mailvalid = false;
  final namecontroller = TextEditingController();
  final pwdcontroller = TextEditingController();
  final cnfcontroller = TextEditingController();
  final mailcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    myColors mcol = myColors();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Text(
              "Sign Up",
              style: GoogleFonts.poppins(
                  fontSize: 34, fontWeight: FontWeight.w500),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Container(
              width: size.width * 0.5,
              height: 10,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [mcol.orange, mcol.black],
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft),
                  color: mcol.orange,
                  borderRadius: BorderRadius.circular(10)),
            ),
          ),
          SizedBox(
            height: size.height * 0.05,
          ),
          Center(
            child: Container(
              width: size.width * 0.9,
              height: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: mcol.lightorange),
                  color: mcol.white),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: size.width * 0.7,
                      height: 60,
                      child: TextField(
                        controller: namecontroller,
                        obscureText: false,
                        style: GoogleFonts.poppins(fontSize: 24),
                        onChanged: (text) {
                          setState(() {
                            namevalid = text.isNotEmpty;
                          });
                        },
                        decoration: InputDecoration(
                            hintText: "Enter Username",
                            hintStyle: GoogleFonts.poppins(fontSize: 30),
                            border: InputBorder.none),
                      ),
                    ),
                    Icon(
                      Icons.mail,
                      size: 30,
                      color: namevalid ? Colors.green : mcol.black,
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Center(
              child: Container(
                width: size.width * 0.9,
                height: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: mcol.lightorange),
                    color: mcol.white),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: size.width * 0.7,
                        height: 60,
                        child: TextField(
                          controller: mailcontroller,
                          obscureText: false,
                          style: GoogleFonts.poppins(fontSize: 24),
                          onChanged: (text) {
                            setState(() {
                              mailvalid = EmailValidator.validate(text);
                            });
                          },
                          decoration: InputDecoration(
                              hintText: "Email Address",
                              hintStyle: GoogleFonts.poppins(fontSize: 30),
                              border: InputBorder.none),
                        ),
                      ),
                      Icon(
                        Icons.mail,
                        size: 30,
                        color: mailvalid ? Colors.green : mcol.black,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0),
            child: Center(
              child: Container(
                width: size.width * 0.9,
                height: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: mcol.lightorange),
                    color: mcol.white),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: size.width * 0.7,
                        height: 60,
                        child: TextField(
                          controller: pwdcontroller,
                          obscureText: !showpwd,
                          onChanged: (text) {
                            setState(() {
                              pwdvalid = (pwdcontroller.text.length >= 8);
                            });
                          },
                          style: GoogleFonts.poppins(fontSize: 24),
                          decoration: InputDecoration(
                              hintText: "Password",
                              hintStyle: GoogleFonts.poppins(fontSize: 30),
                              border: InputBorder.none),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            showpwd = !showpwd;
                          });
                        },
                        child: Icon(
                          showpwd ? Icons.visibility_off : Icons.visibility,
                          size: 30,
                          color: pwdvalid ? Colors.green : mcol.black,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 30.0),
            child: Center(
              child: Container(
                width: size.width * 0.9,
                height: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: mcol.lightorange),
                    color: mcol.white),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: size.width * 0.7,
                        height: 60,
                        child: TextField(
                          controller: cnfcontroller,
                          obscureText: !showcnf,
                          onChanged: (text) {
                            setState(() {
                              cnfvalid = (pwdcontroller.text == text);
                            });
                          },
                          style: GoogleFonts.poppins(fontSize: 24),
                          decoration: InputDecoration(
                              hintText: "Confirm Password",
                              hintStyle: GoogleFonts.poppins(fontSize: 30),
                              border: InputBorder.none),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            showcnf = !showcnf;
                          });
                        },
                        child: Icon(
                          showcnf ? Icons.visibility_off : Icons.visibility,
                          size: 30,
                          color: cnfvalid ? Colors.green : mcol.black,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Center(
              child: SizedBox(
                width: size.width * 0.9,
                height: 60,
                child: ElevatedButton(
                  onPressed: () async {
                    if (!pwdvalid) {
                      FloatingSnackBar(
                          message: "Pwd should be alteast 8 characters",
                          context: context,
                          textStyle: GoogleFonts.poppins(fontSize: 18));
                    } else if (namevalid &&
                        mailvalid &&
                        pwdvalid &&
                        namecontroller.text.isNotEmpty) {
                      setState(() {
                        loading = true;
                      });
                      await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                              email: mailcontroller.text,
                              password: pwdcontroller.text);
                      await FirebaseAuth.instance.currentUser!
                          .updateDisplayName(namecontroller.text);
                      await FirebaseAuth.instance.signOut().then((value) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignInPage()));
                      });
                      setState(() {
                        loading = false;
                      });
                      FloatingSnackBar(
                          message: "User Registered",
                          context: context,
                          textStyle: GoogleFonts.poppins(fontSize: 24));
                    } else {
                      FloatingSnackBar(
                          message: "Please enter all details",
                          context: context,
                          textStyle: GoogleFonts.poppins(fontSize: 24));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: mcol.orange,
                      foregroundColor: mcol.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  child: loading
                      ? SpinKitThreeBounce(
                          color: mcol.black,
                          size: 40,
                        )
                      : Text(
                          "Register",
                          style: GoogleFonts.poppins(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: size.width * 0.4,
                  height: 10,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [mcol.orange, mcol.black],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight),
                      color: mcol.orange,
                      borderRadius: BorderRadius.circular(10)),
                ),
                Text(
                  "OR",
                  style: GoogleFonts.poppins(
                      fontSize: 24, fontWeight: FontWeight.w500),
                ),
                Container(
                  width: size.width * 0.4,
                  height: 10,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [mcol.orange, mcol.black],
                          begin: Alignment.centerRight,
                          end: Alignment.centerLeft),
                      color: mcol.orange,
                      borderRadius: BorderRadius.circular(10)),
                ),
              ],
            ),
          ),
          SizedBox(
              width: size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Have an account?",
                    style: GoogleFonts.poppins(fontSize: 20),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignInPage()));
                      },
                      child: Text(
                        "Sign In",
                        style: GoogleFonts.poppins(
                            fontSize: 24, color: mcol.darkorange),
                      ))
                ],
              ))
        ]),
      )),
    );
  }
}

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  bool loading = false;
  bool namevalid = false;
  final mailcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    myColors mcol = myColors();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Text(
              "Forgot password",
              style: GoogleFonts.poppins(
                  fontSize: 34, fontWeight: FontWeight.w500),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Container(
              width: size.width * 0.5,
              height: 10,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [mcol.orange, mcol.black],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight),
                  color: mcol.orange,
                  borderRadius: BorderRadius.circular(10)),
            ),
          ),
          Text(
            "If you need help resetting your password,we can help by sending you a link to reset it",
            style:
                GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.w200),
          ),
          SizedBox(
            height: size.height * 0.05,
          ),
          Center(
            child: Container(
              width: size.width * 0.9,
              height: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: mcol.lightorange),
                  color: mcol.white),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: size.width * 0.7,
                      height: 60,
                      child: TextField(
                        controller: mailcontroller,
                        obscureText: false,
                        style: GoogleFonts.poppins(fontSize: 24),
                        onChanged: (text) {
                          setState(() {
                            namevalid = EmailValidator.validate(text);
                          });
                        },
                        decoration: InputDecoration(
                            hintText: "Email Address",
                            hintStyle: GoogleFonts.poppins(fontSize: 30),
                            border: InputBorder.none),
                      ),
                    ),
                    Icon(
                      Icons.mail,
                      size: 30,
                      color: mcol.black,
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0),
            child: Center(
              child: SizedBox(
                width: size.width * 0.9,
                height: 60,
                child: ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      loading = true;
                    });
                    if (namevalid) {
                      await FirebaseAuth.instance
                          .sendPasswordResetEmail(email: mailcontroller.text)
                          .then((value) {
                        FloatingSnackBar(
                            message: "Mail sent",
                            context: context,
                            textStyle: GoogleFonts.poppins(fontSize: 24));
                      }).catchError((e) {
                        print(e.toString());
                      });
                    } else {
                      FloatingSnackBar(
                          message: "Please enter a valid email",
                          context: context,
                          textStyle: GoogleFonts.poppins(fontSize: 24));
                    }

                    setState(() {
                      loading = false;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: mcol.orange,
                      foregroundColor: mcol.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  child: loading
                      ? SpinKitThreeBounce(
                          size: 40,
                          color: mcol.black,
                        )
                      : Text(
                          "Send Mail",
                          style: GoogleFonts.poppins(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: size.width * 0.4,
                  height: 10,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [mcol.orange, mcol.black],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight),
                      color: mcol.orange,
                      borderRadius: BorderRadius.circular(10)),
                ),
                Text(
                  "OR",
                  style: GoogleFonts.poppins(
                      fontSize: 24, fontWeight: FontWeight.w500),
                ),
                Container(
                  width: size.width * 0.4,
                  height: 10,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [mcol.orange, mcol.black],
                          begin: Alignment.centerRight,
                          end: Alignment.centerLeft),
                      color: mcol.orange,
                      borderRadius: BorderRadius.circular(10)),
                ),
              ],
            ),
          ),
          SizedBox(
              width: size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Have an account?",
                    style: GoogleFonts.poppins(fontSize: 20),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignInPage()));
                      },
                      child: Text(
                        "Sign In",
                        style: GoogleFonts.poppins(
                            fontSize: 24, color: mcol.darkorange),
                      ))
                ],
              ))
        ]),
      )),
    );
  }
}
