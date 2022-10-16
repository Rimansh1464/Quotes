import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quotes_app/helper/like_db_helper.dart';
import 'package:quotes_app/helper/quotesd_db_helper.dart';
import 'package:quotes_app/modal/like_modal.dart';
import 'package:quotes_app/screens/Like.dart';

import '../modal/imageList.dart';
import '../modal/quotes_modal.dart';

List<Quotes> image = [];
Future<List<Quotes>>? dbquotes;
Future<List<Like>>? dblike;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

List<String> dumyimage = [
  "asserts/image/Screenshot_2022-10-13-10-14-35-27_42a012ddd4c144fea4c38d3dbaa492df.jpg",
  "asserts/image/Screenshot_2022-10-13-10-14-54-15_42a012ddd4c144fea4c38d3dbaa492df.jpg",
  "asserts/image/Screenshot_2022-10-13-10-15-17-79_42a012ddd4c144fea4c38d3dbaa492df.jpg",
  "asserts/image/Screenshot_2022-10-13-10-15-41-71_42a012ddd4c144fea4c38d3dbaa492df.jpg",
];

class _HomeScreenState extends State<HomeScreen> {
  Future<List<Quotes>?> AddData() async {
    dbquotes = QuotesDbHelper.quotesDbHelper.fetchData();
  }

  Future<List<Like>?> AddLikeData() async {
    dblike = LikeDbHelper.likeDbHelper.fetchlikeData();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      String jasonDta = await rootBundle.loadString("asserts/json/quotes.json");
      List<Quotes> quotesDataList = quotesFromJson(jasonDta);
      await QuotesDbHelper.quotesDbHelper.insertData(quotesDataList);
      // image =  QuotesDbHelper.quotesDbHelper.fetchData();
      print("===============================");
      await AddData();
      print("${dbquotes}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.menu),
                  Text(
                    "Life Quotes",
                    style: TextStyle(fontSize: 25),
                  ),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          dblike = LikeDbHelper.likeDbHelper.fetchlikeData();

                        });
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return AllLike();
                          },
                        ));
                      },
                      icon: Icon(Icons.favorite)),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              CarouselSlider.builder(
                itemCount: 5,
                options: CarouselOptions(
                  height: 190,
                  aspectRatio: 0,
                  viewportFraction: 0.8,
                  enlargeCenterPage: true,
                  //enableInfiniteScroll: true,
                  autoPlay: true,
                  autoPlayCurve: Curves.easeInOut,
                ),
                itemBuilder: (context, i, pageViewIndex) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(sliderimage[i]),
                      ),
                    ),
                    child: Center(
                      child: Container(
                        padding: EdgeInsets.all(20),
                        height: 190,
                        width: 300,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.45),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            sliderqouts[i],
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 15),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              // Container(
              //   height: 200,
              //   width: double.infinity,
              //   decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(20), color: Colors.grey),
              // ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Container(
                        height: 55,
                        width: 55,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xffa25684)),
                        child: const Center(
                          child: Icon(
                            Icons.now_widgets_outlined,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        "Categories",
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        height: 55,
                        width: 55,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xff7589c8)),
                        child: const Center(
                          child: Icon(
                            Icons.image_outlined,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        "Pic Quotes",
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        height: 55,
                        width: 55,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xffb98f41)),
                        child: const Center(
                          child: Icon(
                            Icons.settings,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        "Latest Quotes",
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        height: 55,
                        width: 55,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xff6c9978)),
                        child: const Center(
                          child: Icon(
                            Icons.menu_book_outlined,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        "Articles",
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Most Popular",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            dbquotes = QuotesDbHelper.quotesDbHelper
                                .likecategory(val: "happiness");
                            // title = "happiness";
                          });
                          Navigator.pushNamed(context, "AllQuotes");
                        },
                        child: Container(
                          height: 120,
                          width: 155,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                    "${dumyimage[0]}",
                                  ),
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        "Happiness Quotes",
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            dbquotes = QuotesDbHelper.quotesDbHelper
                                .likecategory(val: "life");
                            // title = "life";
                          });
                          Navigator.pushNamed(context, "AllQuotes");
                        },
                        child: Container(
                          height: 120,
                          width: 155,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                    "${dumyimage[1]}",
                                  ),
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        "Life Quotes",
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        dbquotes = QuotesDbHelper.quotesDbHelper
                            .likecategory(val: "love");
                        // title = "love";
                      });
                      Navigator.pushNamed(context, "AllQuotes");
                    },
                    child: Column(
                      children: [
                        InkWell(
                          child: Container(
                            height: 120,
                            width: 155,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                      "${dumyimage[2]}",
                                    ),
                                    fit: BoxFit.cover),
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        const Text(
                          "Love Quotes",
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            dbquotes = QuotesDbHelper.quotesDbHelper
                                .likecategory(val: "success");
                            // title = "success";
                          });
                          Navigator.pushNamed(context, "AllQuotes");
                        },
                        child: Container(
                          height: 120,
                          width: 155,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                    "${dumyimage[3]}",
                                  ),
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      const Text(
                        "Success Quotes",
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
