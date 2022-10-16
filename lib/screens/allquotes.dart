import 'dart:io';
import 'dart:typed_data';
// import 'package:image_gallery_saver/image_gallery_saver.dart';

import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quotes_app/modal/quotes_modal.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

// import 'package:quotes_app/screens/homescreenList.dart';

import '../helper/like_db_helper.dart';
import 'editqoutes.dart';
import 'homescreen.dart';

String title = "";
List<bool> starList = List.generate(20, (index) => false);
ScreenshotController screenshotController = ScreenshotController();
Future saveImage(Uint8List bytes) async {

  await ImageGallerySaver.saveImage(
      bytes,
      name: "data",
      quality: 100);

}
int Counter = 0;
class AllQuotes extends StatefulWidget {
  const AllQuotes({Key? key}) : super(key: key);

  @override
  State<AllQuotes> createState() => _AllQuotesState();
}

class _AllQuotesState extends State<AllQuotes> {

  ScreenshotController screenshotController = ScreenshotController();
  Future saveImage(Uint8List bytes) async {

    await ImageGallerySaver.saveImage(
        bytes,
        name: "data",
        quality: 100);

  }
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.arrow_back, size: 30),
              ),
              Text(
                "   ${title}",
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
          // const SizedBox(
          //   height: 30,
          // ),
          Expanded(
            child: FutureBuilder(
              future: dbquotes,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  Center(
                    child: Text("${snapshot.error}"),
                  );
                } else if (snapshot.hasData) {
                  List<Quotes>? AllQuotes = snapshot.data;
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      itemCount: AllQuotes?.length,
                      itemBuilder: (context, i) {
                        return Padding(
                          padding: EdgeInsets.only(top: 20, bottom: 20),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return Quotesview(quotes: AllQuotes![i].quote.toString(), image:AllQuotes[i].image.toString(),index: i,);
                                },
                              ));
                            },
                            child: Container(
                              height: 440,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  boxShadow: const [
                                    BoxShadow(
                                        blurRadius: 10, color: Colors.grey)
                                  ],
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white),
                              child: Column(
                                children: [
                                  Container(
                                    height: 380,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                "${AllQuotes?[i].image}"),
                                            fit: BoxFit.cover),
                                        borderRadius: BorderRadius.circular(0),
                                        color: Colors.black38),
                                    child: Container(
                                      height: 440,
                                      color: Colors.black.withOpacity(0.45),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20, right: 20),
                                        child: Center(
                                          child: Text(
                                            "${AllQuotes?[i].quote}",
                                            style: const TextStyle(
                                                fontSize: 18,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            AllQuotes?[i].image =
                                                AllQuotes[Counter].image;
                                            if (Counter < 40) {
                                              Counter++;
                                            }
                                          });
                                        },
                                        child:Icon(Icons.change_circle_rounded,color: Colors.red,)
                                      ),

                                      InkWell(
                                        onTap: () {
                                          FlutterClipboard.copy(
                                            AllQuotes![i].quote.toString(),

                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text("Copy")));
                                        },
                                        child: Icon(
                                          Icons.copy_rounded,
                                          color: Colors.blueAccent,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: ()async{
                                          final byte = await screenshotController.captureFromWidget(
                                            Material(
                                              child:SSContainer(image:AllQuotes![i].image.toString(),quote:AllQuotes[i].quote.toString() ),
                                            ),
                                          );
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
                                        onTap: ()async{
                                          Uint8List? imageBytes = await screenshotController.captureFromWidget(
                                            Material(
                                              child:SSContainer(image:AllQuotes![i].image.toString(),quote:AllQuotes[i].quote.toString() ),
                                            ),

                                          );
                                          saveImage(imageBytes);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                              content: Text("Dowoload..")));
                                        },
                                        child: Icon(
                                          Icons.download_rounded,
                                          color: Colors.green,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            starList[i] = !starList[i];
                                          });
                                          LikeDbHelper.likeDbHelper
                                              .insertlikeData(
                                                  quotes: AllQuotes![i]
                                                      .quote
                                                      .toString(),
                                                  image: AllQuotes[i]
                                                      .image
                                                      .toString());
                                        },
                                        child: (starList[i])
                                            ? const Icon(
                                                Icons.star,
                                                size: 26,
                                                color: Colors.black,
                                              )
                                            : const Icon(
                                                Icons.star_border_outlined,
                                                size: 26,
                                                color: Colors.black,
                                              ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ],
      ),
    ));
  }
Widget SSContainer({required String image,required String quote}){
return Container(
  height: 440,
  width: double.infinity,
  decoration: BoxDecoration(
      boxShadow: const [
        BoxShadow(
            blurRadius: 10, color: Colors.grey)
      ],
      borderRadius: BorderRadius.circular(20),
      color: Colors.white),
  child: Column(
    children: [
      Container(
        height: 440,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    image),
                fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(0),
            color: Colors.black38),
        child: Container(
          height: 440,
          color: Colors.black.withOpacity(0.45),
          child: Padding(
            padding: const EdgeInsets.only(
                left: 20, right: 20),
            child: Center(
              child: Text(
                quote,
                style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white),
              ),
            ),
          ),
        ),
      ),

    ],
  ),
);
}
}
