import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

abstract class AppColors {
  static const text = Colors.white;
  static const secondaryText = Colors.grey;
  static const background = Color(0xff222222);
  static const avatarBorder = Colors.white24;
}

const String aboutIcon = 'assets/icons/About.svg';
const String hobbiesIcon = 'assets/icons/Hobbies.svg';
const String codeIcon = 'assets/icons/Code.svg';

final Widget about = SvgPicture.asset(
    aboutIcon,
    height: 40, width: 40,
    fit: BoxFit.scaleDown,
    colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
    semanticsLabel: 'About Icon'
);

final Widget hobbies = SvgPicture.asset(
    hobbiesIcon,
    height: 40, width: 40,
    fit: BoxFit.scaleDown,
    colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
    semanticsLabel: 'Hobbies Icon'
);

final Widget code = SvgPicture.asset(
    codeIcon,
    height: 40, width: 40,
    fit: BoxFit.scaleDown,
    colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
    semanticsLabel: 'Code Icon'
);

const radius = 80;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'LTHoop',
      ),
      home: const MainScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CustomAvatar extends StatelessWidget {
  const CustomAvatar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: radius * 2,
      child: Stack(
        children: [
          Container(
            width: radius * 2,
            height: radius * 2,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(radius/4),
              border: Border.all(
                color: AppColors.avatarBorder,
                width: 2.5,
              ),
              image: const DecorationImage(
                image: AssetImage('assets/images/Me.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MainPersonalDataSection extends StatelessWidget {
  const MainPersonalDataSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        CustomAvatar(),
        SizedBox(width: 20),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Yuri Mzhachikh',
                style: TextStyle(
                  fontSize: 22,
                  color: AppColors.text,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 5),
              Text(
                'Beginner Flutter Developer',
                style: TextStyle(
                  fontSize: 15,
                  color: AppColors.secondaryText,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class AboutSection extends StatelessWidget {
  const AboutSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              about,
              const SizedBox(width: 10),
              const Text(
                'About me',
                style: TextStyle(
                  fontSize: 22,
                  color: AppColors.text,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        const SizedBox(height: 10),
        const Text(
          'Guitar player, flutter developer, professional button-masher',
          style: TextStyle(
            fontSize: 15,
            color: AppColors.secondaryText,
            fontWeight: FontWeight.w300,
          ),
        ),
      ],
    );
  }
}

class HobbiesSection extends StatelessWidget {
  const HobbiesSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            hobbies,
            const SizedBox(width: 10),
            const Text(
              'My hobbies',
              style: TextStyle(
                fontSize: 22,
                color: AppColors.text,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        const Text(
          'I love to let my mind wander off while listening to some good'
              ' tunes and playing videogames',
          style: TextStyle(
            fontSize: 15,
            color: AppColors.secondaryText,
            fontWeight: FontWeight.w300,
          ),
        ),
      ],
    );
  }
}

class CodeSection extends StatelessWidget {
  const CodeSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            code,
            const SizedBox(width: 10),
            const Text(
              'Development experience',
              style: TextStyle(
                fontSize: 22,
                color: AppColors.text,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        const Text(
          'Little to none, but I\'m working on it!',
          style: TextStyle(
            fontSize: 15,
            color: AppColors.secondaryText,
            fontWeight: FontWeight.w300,
          ),
        ),
      ],
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: const Text(
          'Wowzy! You\'re on my landing page!',
          style: TextStyle(
            fontSize: 22,
            color: AppColors.text,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: AppColors.background,
      ),
      backgroundColor: AppColors.background,
      body: const Column(
          children: [
            SizedBox(height: 10),
            /// Avatar and Full Name
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: MainPersonalDataSection(),
            ),
            /// About
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  SizedBox(height: 35),
                  AboutSection(),
                ],
              )
            ),
            /// Hobbies
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    SizedBox(height: 35),
                    HobbiesSection(),
                  ],
                )
            ),
            /// Development Experience
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    SizedBox(height: 35),
                    CodeSection(),
                  ],
                )
            ),
          ],
        ),
    );
  }
}
