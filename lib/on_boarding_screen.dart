// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:csnapp/menu.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController _pageController = PageController();
  int currentPageIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            onPageChanged: (i) {
              setState(() {
                currentPageIndex = i;
              });
            },
            controller: _pageController,
            children: [
              Container(
                color: Colors.white,
                child: _page("assets/icone1.png", "Page 1 ",
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip"),
              ),
              Container(
                color: Colors.white,
                child: _page("assets/icone2.png", "Page 2 ",
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip"),
              ),
              Container(
                color: Colors.white,
                child: _page("assets/icone3.png", "Page 3 ",
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip"),
              ),
              Container(
                color: Colors.white,
                child: _page("assets/icone4.png", "Page 4 ",
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip"),
              ),
            ],
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 32),
                child: SmoothPageIndicator(
                  controller: _pageController,
                  effect: const JumpingDotEffect(
                    activeDotColor: Colors.green,
                    dotColor: Colors.black54,
                  ),
                  count: 4,
                  onDotClicked: (index) {
                    _pageController.jumpToPage(index);
                  },
                ),
              )),
          if (currentPageIndex == 3)
            Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(64),
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Menu(),
                            ));
                      },
                      style: ButtonStyle(backgroundColor:
                      MaterialStateProperty.all(Colors.green)
                      ),
                      child: Text("TERMINER")
                  ),
                ))
        ],
      ),
    );
  }

  Widget _page(String imagePath, String title, String subtitle) {
    return Container(
      margin: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            height: 300,
          ),
          SizedBox(
            height: 100,
          ),
          Text(title,
              style: TextStyle(
                  fontSize: 32,
                  color: Colors.green,
                  fontWeight: FontWeight.bold)),
          SizedBox(
            height: 20,
          ),
          Text(subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              )),
        ],
      ),
    );
  }
}
