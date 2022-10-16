import 'dart:io';
import 'dart:typed_data';

import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quotes_app/screens/allquotes.dart';
import 'package:share_plus/share_plus.dart';

import '../modal/imageList.dart';

class Quotesview extends StatefulWidget {
  Quotesview(
      {Key? key,
      required this.quotes,
      required this.image,
      required this.index})
      : super(key: key);
  String quotes;
  String image;
  int index;

  @override
  State<Quotesview> createState() => _QuotesviewState();
}

class _QuotesviewState extends State<Quotesview> {
  int fontcount = 0;
  bool fstyle = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(alignment: Alignment.center, children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(widget.image), fit: BoxFit.cover),
              color: Colors.black38),
          child: Center(
            child: Text("${widget.quotes}", style: font[fontcount]),
          ),
        ),
        Positioned(
            top: 670,
            bottom: 50,
            right: 10,
            left: 10,
            child: Container(
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                          onTap: () {
                            setState(() {
                              widget.image = AllQuotesImage[Counter];
                              if (Counter < 40) {
                                Counter++;
                              }
                            });
                          },
                          child: Icon(
                            Icons.change_circle_rounded,
                            color: Colors.red,
                          )),
                      // Image(image: AssetImage("asserts/image/copy.jpg"),height: 30),
                       InkWell(
                         onTap: (){
                           setState(() {
                             fstyle = !fstyle;
                           });
                         },
                         child: Icon(
                          Icons.text_fields,
                          color: Colors.green,
                      ),
                       ),
                      InkWell(
                        onTap: () {
                          FlutterClipboard.copy(widget.quotes);
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text("Copy")));
                        },
                        child: Icon(
                          Icons.copy_rounded,
                          color: Colors.blueAccent,
                        ),
                      ),

                      InkWell(
                        onTap: () async {
                          final byte = await screenshotController
                              .captureFromWidget(Material(
                            child: SSContainer(),
                          ));
                          final temp = await getTemporaryDirectory();
                          final path = '${temp.path}/image.jpg';
                          File(path).writeAsBytesSync(byte);

                          await Share.shareFiles([path]);
                        },
                        child: Icon(
                          Icons.share,
                          color: Colors.red,
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          Uint8List? imageBytes =
                              await screenshotController.captureFromWidget(
                            Material(
                              child: SSContainer(),
                            ),
                          );
                          saveImage(imageBytes);
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Dowoload..")));
                        },
                        child: Icon(
                          Icons.download_rounded,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ))),
        if (fstyle) ...[
          Positioned(
            top: 610,
            bottom: 120,
            right: 10,
            left: 10,
            child: Container(
              height: 30,
              width: 50,
              color: Colors.blue,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, i) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                         fontcount = i;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      height: 26,
                      width: 50,
                      color: Colors.transparent,
                      child: Center(
                        child: Text(
                          "Style",
                          style: fontstyle[i]
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          )
        ]
      ]),
    );
  }

  SSContainer() {
    return Stack(alignment: Alignment.center, children: [
      Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(widget.image), fit: BoxFit.cover)),
        child: Center(
          child: Text(
            "${widget.quotes}",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    ]);
  }
}

List<TextStyle> font = [
  GoogleFonts.italiana(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    letterSpacing: 1,
    color: Colors.white,
  ),
  GoogleFonts.bakbakOne(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    letterSpacing: 1,
    color: Colors.white,
  ),
  GoogleFonts.adamina(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    letterSpacing: 1,
    color: Colors.white,
  ),
  GoogleFonts.roboto(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    letterSpacing: 1,
    color: Colors.white,
  ),
  GoogleFonts.abel(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    letterSpacing: 1,
    color: Colors.white,
  )
];
List<TextStyle> fontstyle = [
  GoogleFonts.italiana(
    fontSize: 13,
    fontWeight: FontWeight.bold,
    letterSpacing: 1,
    color: Colors.white,
  ),
  GoogleFonts.bakbakOne(
    fontSize: 13,
    fontWeight: FontWeight.bold,
    letterSpacing: 1,
    color: Colors.white,
  ),
  GoogleFonts.adamina(
    fontSize: 13,
    fontWeight: FontWeight.bold,
    letterSpacing: 1,
    color: Colors.white,
  ),
  GoogleFonts.roboto(
    fontSize: 13,
    fontWeight: FontWeight.bold,
    letterSpacing: 1,
    color: Colors.white,
  ),
  GoogleFonts.abel(
    fontSize: 13,
    fontWeight: FontWeight.bold,
    letterSpacing: 1,
    color: Colors.white,
  )
];
