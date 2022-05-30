
import 'package:flutter/material.dart';
import 'package:shop_app/login/shop_login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/styles/themes.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<BoardingModel>? boarding = [
    BoardingModel(
      image: "assets/images/onboard.jpg",
      title: "Boarding Title 1",
      body: "Boarding Body 1",
    ),
    BoardingModel(
      image: "assets/images/onboard.jpg",
      title: "Boarding Title 2",
      body: "Boarding Body 2",
    ),
    BoardingModel(
      image: "assets/images/onboard.jpg",
      title: "Boarding Title 3",
      body: "Boarding Body 3",
    )
  ];

  var boardingController = PageController();

  bool? last = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Shop App",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
          ),
          actions: [
            defaultTextButton(
                text: "Skip",
                fun: () {
                  submit(context);
                },
                weight: FontWeight.bold)
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(30, 0, 30, 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: PageView.builder(
                  onPageChanged: (index) {
                    if (index == boarding!.length - 1) {
                      last = true;

                      // setState(() {
                      //   last = true;
                      // });
                    } else {
                      last = false;
                      // setState(() {
                      //   last = false;
                      // });
                    }
                  },
                  controller: boardingController,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return buildBoardingItem(boarding![index]);
                  },
                  itemCount: boarding!.length,
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              Row(
                children: [
                  SmoothPageIndicator(
                    controller: boardingController,
                    count: boarding!.length,
                    effect: ExpandingDotsEffect(
                      activeDotColor: defaultColor,
                      dotColor: Colors.grey,
                      dotHeight: 10.0,
                      dotWidth: 10,
                      expansionFactor: 4,
                      spacing: 5.0,
                    ),
                  ),
                  const Spacer(),
                  FloatingActionButton(
                    onPressed: () {
                      if (last == true) {
                        submit(context);
                        /*Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context){
                          return ShopLoginScreen();
                        }), (route) => false);*/
                      } else {
                        boardingController.nextPage(
                            duration: const Duration(
                              milliseconds: 700,
                            ),
                            curve: Curves.fastLinearToSlowEaseIn);
                      }
                    },
                    child: const Icon(Icons.arrow_forward_outlined),
                  )
                ],
              )
            ],
          ),
        ));
  }
}

Widget buildBoardingItem(BoardingModel model) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Image(image: AssetImage(model.image)),
      ),
      Text(
        model.title,
        style: const TextStyle(
            fontSize: 24,
            fontFamily: "TimesNewRoman",
            fontWeight: FontWeight.bold),
      ),
      const SizedBox(
        height: 15.0,
      ),
      Text(
        model.body,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          fontFamily: "TimesNewRoman",
        ),
      )
    ],
  );
}

void submit(context) {
  CacheHelper.saveData(key: "onBoarding", value: true).then((value){
    if(value){
      navigateTo(context, ShopLoginScreen());
    }
  });

}
