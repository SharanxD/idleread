import 'dart:ui';

import 'package:floating_snackbar/floating_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:idleread/modals/articles.dart';
import 'package:idleread/modals/colors.dart';
import 'package:idleread/services/chatgptApi.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ReadScreen extends StatefulWidget {
  const ReadScreen({super.key, required this.current});
  final Articles current;

  @override
  State<ReadScreen> createState() => _ReadScreenState();
}

class _ReadScreenState extends State<ReadScreen> {
  String meaning = "";
  String prev = "";
  late PdfViewerController _pdfViewerController;

  @override
  void initState() {
    _pdfViewerController = PdfViewerController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    myColors mcol = myColors();
    Future<void> showMeaning(String selected) async {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return StatefulBuilder(builder: (context, setState) {
              return AlertDialog(
                backgroundColor: mcol.white,
                title: Text(
                  "Your Assistant",
                  style: GoogleFonts.poppins(
                      fontSize: 40,
                      color: mcol.black,
                      fontWeight: FontWeight.bold),
                ),
                content: SizedBox(
                  width: size.width,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(selected[0].toUpperCase() + selected.substring(1),
                          style: GoogleFonts.poppins(
                              fontSize: 32,
                              color: mcol.orange,
                              fontWeight: FontWeight.w800)),
                      Text("Meaning: ",
                          style: GoogleFonts.poppins(
                              fontSize: 28,
                              color: mcol.black,
                              fontWeight: FontWeight.w600)),
                      Text(meaning.isNotEmpty ? meaning : "Fetching...",
                          style: GoogleFonts.poppins(
                            fontSize: 24,
                            color: mcol.black,
                          )),
                    ],
                  ),
                ),
                actions: [
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
                                borderRadius: BorderRadius.circular(10))),
                        child: Text(
                          "Okayy",
                          style: GoogleFonts.poppins(
                              fontSize: 34, fontWeight: FontWeight.w700),
                        )),
                  ),
                ],
              );
            });
          });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.current.name),
      ),
      body: SfPdfViewer.network(
        widget.current.link,
        onDocumentLoadFailed: (details) {
          FloatingSnackBar(message: "Error Loading", context: context);

          Navigator.pop(context);
        },
        canShowPageLoadingIndicator: false,
        onTextSelectionChanged: (PdfTextSelectionChangedDetails details) {
          if (details.selectedText != null &&
              details.selectedText.toString() != prev) {
            setState(() {
              prev = details.selectedText.toString();
            });
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Meaning(word: prev)));
            //myApi.test("immaculate");
            // setState(() {
            //   meaning = temp;
            // });
            //showMeaning(details.selectedText.toString());
          }
        },
        controller: _pdfViewerController,
      ),
      // floatingActionButton: FloatingActionButton(

      // ),
    );
  }
}

class Meaning extends StatefulWidget {
  const Meaning({super.key, required this.word});
  final String word;

  @override
  State<Meaning> createState() => _MeaningState();
}

class _MeaningState extends State<Meaning> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: Column(
        children: [
          Text(widget.word),
          ElevatedButton(
              onPressed: () {
                gptApi myApi = gptApi();
                myApi.test("test");
              },
              child: Text("Press me"))
        ],
      )),
    );
  }
}
