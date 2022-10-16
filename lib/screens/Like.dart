import 'package:flutter/material.dart';
import 'package:quotes_app/modal/like_modal.dart';
import 'package:quotes_app/modal/quotes_modal.dart';

// import 'package:quotes_app/screens/homescreenList.dart';

import '../helper/like_db_helper.dart';
import 'homescreen.dart';

String title = "";

class AllLike extends StatefulWidget {
  const AllLike({Key? key}) : super(key: key);

  @override
  State<AllLike> createState() => _AllLikeState();
}

class _AllLikeState extends State<AllLike> {
  int Counter = 0;

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
                  future: dblike ,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      Center(
                        child: Text("${snapshot.error}"),
                      );
                    } else if (snapshot.hasData) {
                      List<Like>? Alllike = snapshot.data ;
                      print("s>>>>>>>>>>>${snapshot.data?.length}");
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                          itemCount: Alllike?.length,
                          itemBuilder: (context, i) {
                            return Padding(
                              padding: EdgeInsets.only(top: 20, bottom: 20),
                              child: Container(
                                height: 440,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    boxShadow: const [
                                      BoxShadow(blurRadius: 10, color: Colors.grey)
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
                                                  "${Alllike?[i].image}"),
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
                                              "${Alllike?[i].quote}",
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
                                              Alllike?[i].image =
                                                  Alllike[Counter].image;
                                              if (Counter < 40) {
                                                Counter++;
                                              }
                                            });
                                          },
                                          child: Image(
                                              image: AssetImage(
                                                  "asserts/image/chang.jpg"),
                                              height: 30),
                                        ),
                                        // Image(image: AssetImage("asserts/image/copy.jpg"),height: 30),
                                        Icon(
                                          Icons.copy_rounded,
                                          color: Colors.blueAccent,
                                        ),

                                        Icon(
                                          Icons.share,
                                          color: Colors.red,
                                        ),
                                        Icon(
                                          Icons.download_rounded,
                                          color: Colors.green,
                                        ),
                                        InkWell(onTap: (){
                                          setState(() {

                                            LikeDbHelper.likeDbHelper.deletData(id: Alllike![i].id.toString());
                                            dblike = LikeDbHelper.likeDbHelper.fetchlikeData();

                                          });
                                        },
                                          child: Icon(
                                            Icons.star_border_outlined,
                                            size: 26,
                                            color: Colors.blue,
                                          )

                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }
                    return  Center(
                      child: Text("No Data...."),
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
