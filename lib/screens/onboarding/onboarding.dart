import 'package:flutter/material.dart';
import 'package:holy_quran_app/provider/on_board_provider.dart';
import 'package:holy_quran_app/utils/routes/route_name.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../utils/assets.dart';
import '../home/home_screen.dart';
import 'widget/onboarded_widget.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => OnboardingScreenState();
}

class OnboardingScreenState extends State<OnboardingScreen> {
  List<Widget> pages = [
    const OnBoardingPage(
      image: StaticAssets.gradLogo,
      text:
          "The Holy Qur'an\n\n\"Indeed, It is We who sent down the Qur'an and indeed, We will be its Guardian\"\n",
    ),
    const OnBoardingPage(
      image: StaticAssets.ui,
      text:
          "With sleek & awesome User Interface to keep you in love with this amazing app and the Book.\n\nHope you will like our efforts!\n",
    ),
    const OnBoardingPage(
      image: StaticAssets.easyNav,
      text:
          "Now with Surah & Juz Index you can find your required Surahs & Juzs easily.\n\nWith Bookmark option you can access your daily readings.\n",
    ),
    const OnBoardingPage(
      image: StaticAssets.drawer3d,
      text:
          "For the first time ever, we introduced a very unique experience for our users with 3D Drawer.\n\nCan't wait for your reviews :)\n",
    ),
  ];
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        margin: const EdgeInsets.only(left: 12.0, right: 12.0),
        child: Row(
          children: [
            const Spacer(),
            TextButton(
                onPressed: () {
                  pageController.animateToPage(
                    pages.length - 1,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                  );
                },
                child: Text(
                  "Skip",
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: const Color(0xffee8f8b),
                      ),
                )),
            const Spacer(),
            SmoothPageIndicator(
                controller: pageController, // PageController
                count: pages.length,
                effect: const WormEffect(
                    dotHeight: 12,
                    dotWidth: 12,
                    activeDotColor: Color(0xffee8f8b)), // your preferred effect
                onDotClicked: (index) {
                  pageController.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                  );
                }),
            const Spacer(),
            Consumer<OnBoarddingProvider>(
              builder: (context, value, _) => TextButton(
                  onPressed: value.index == pages.length - 1
                      ? () async {
                          SharedPreferences sharedPreference =
                              await SharedPreferences.getInstance();
                          sharedPreference.setBool("onboard", true);
                          Navigator.pushNamedAndRemoveUntil(
                              context, RouteName.home, (route) => false);
                        }
                      : () {
                          pageController.nextPage(
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeInOut,
                          );
                        },
                  child: Text(
                    value.index == pages.length - 1 ? "Let's Go" : "Next",
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: const Color(0xffee8f8b)),
                  )),
            ),
            const Spacer(),
          ],
        ),
      ),
      body: SafeArea(
        child: Consumer<OnBoarddingProvider>(
          builder: (context, value, _) => PageView.builder(
            onPageChanged: (value2) => value.index = value2,
            controller: pageController,
            itemBuilder: (context, index) {
              return pages[index];
            },
            itemCount: pages.length,
          ),
        ),
      ),
    );
  }
}
