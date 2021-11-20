import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kids_courses/res/images.dart';

import 'components/common_course_container.dart';
import 'components/path_bg.dart';
import 'models/course_status_data.dart';
import 'models/session_tile_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Course Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff96C8F8),
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            const Positioned(
              top: 10,
              left: 0,
              right: 0,
              child: UserButtons(),
            ),
            const Positioned.fill(
              top: 90,
              child: MentorInfo(),
            ),
            const Positioned(
              top: 70,
              left: 0,
              right: 0,
              child: MentorButton(),
            ),
            Positioned.fill(
              top: 290,
              child: UserCoursesAndSessions(),
            )
          ],
        ),
      ),
    );
  }
}

class UserButtons extends StatelessWidget {
  const UserButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          renderUserButton(context, "Stories"),
          const SizedBox(width: 16),
          renderUserButton(context, "Profile"),
        ],
      ),
    );
  }

  Column renderUserButton(BuildContext context, String name) {
    return Column(
      children: [
        NeumorphicButton(
          child: ClipOval(
            child: SvgPicture.asset(ImageRes.buttonBird),
          ),
          padding: const EdgeInsets.all(1),
          style: const NeumorphicStyle(
            boxShape: NeumorphicBoxShape.circle(),
          ),
        ),
        Text(
          name,
          style: context.getTextTheme.caption?.copyWith(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

class MentorButton extends StatelessWidget {
  const MentorButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: NeumorphicButton(
        onPressed: () {},
        style: const NeumorphicStyle(
          color: Colors.white,
          shadowLightColor: Colors.white38,
          shape: NeumorphicShape.flat,
          boxShape: NeumorphicBoxShape.stadium(),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 2.0,
          vertical: 6,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                ImageRes.buttonBird,
                height: 32,
              ),
              const SizedBox(width: 8),
              const Text(
                "Rom Jacob",
                style: TextStyle(
                  color: Color(0xff777777),
                  fontFamily: 'Nexa-Bold',
                ),
              ),
              const Icon(Icons.arrow_drop_down),
            ],
          ),
        ),
      ),
    );
  }
}

class MentorInfo extends StatelessWidget {
  const MentorInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: BlueSecondContainerClip(),
      child: Container(
        padding: const EdgeInsets.only(top: 48),
        alignment: Alignment.topCenter,
        color: Colors.lightBlue,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(ImageRes.trainerImage),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "HipHop: Session 4",
                  style: context.getTextTheme.subtitle2?.copyWith(
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "The Smurf & Kool Moe Dee",
                  style: context.getTextTheme.subtitle2?.copyWith(
                    color: Colors.white,
                  ),
                ),
                Text(
                  "June 19, 2020 | 5:00 pm",
                  style: context.getTextTheme.subtitle2?.copyWith(
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                NeumorphicButton(
                  onPressed: () {},
                  style: const NeumorphicStyle(
                    color: Color(0xff388AFA),
                    shadowLightColor: Colors.white38,
                    shape: NeumorphicShape.flat,
                    boxShape: NeumorphicBoxShape.stadium(),
                  ),
                  padding: const EdgeInsets.all(12.0),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      "Enter Funroom",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Nexa-Bold',
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class UserCoursesAndSessions extends StatelessWidget {
  UserCoursesAndSessions({
    Key? key,
  }) : super(key: key);

  final _currentCoursesList = ValueNotifier(fakeDataActive);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: WhiteBottomContainerClip(),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        color: Colors.white,
        child: Column(
          children: [
            const SizedBox(height: 8),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  "Rom's Courses",
                  style: context.getTextTheme.headline5,
                ),
              ),
            ),
            CourseFilterToggle(
              valueChanged: (isActive) {
                _currentCoursesList.value =
                    isActive ? fakeDataActive : fakeDataCompleted;
              },
            ),
            const SizedBox(
              height: 16,
            ),
            Expanded(
              child: ValueListenableBuilder<List<CourseStatusData>>(
                  valueListenable: _currentCoursesList,
                  builder: (context, data, _) {
                    return ListView(
                      primary: false,
                      children: data.map((e) => CommonCourseStatus(e)).toList(),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

class CourseFilterToggle extends StatelessWidget {
  CourseFilterToggle({
    Key? key,
    required this.valueChanged,
  }) : super(key: key);

  final ValueNotifier<bool> _isActive = ValueNotifier(true);
  final ValueChanged<bool> valueChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 250,
      child: Neumorphic(
        style: const NeumorphicStyle(
          boxShape: NeumorphicBoxShape.stadium(),
          color: Color(0xff96C8F8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                _isActive.value = true;
                valueChanged(_isActive.value);
              },
              child: ValueListenableBuilder<bool>(
                  valueListenable: _isActive,
                  builder: (context, value, _) {
                    return Neumorphic(
                      child: const Text(
                        "Active",
                        style: TextStyle(color: Colors.white),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 14),
                      style: NeumorphicStyle(
                        color: value
                            ? const Color(0xff388AFA)
                            : Colors.transparent,
                        disableDepth: !value,
                        boxShape: const NeumorphicBoxShape.stadium(),
                      ),
                    );
                  }),
            ),
            GestureDetector(
              onTap: () {
                _isActive.value = false;
                valueChanged(_isActive.value);
              },
              child: ValueListenableBuilder<bool>(
                  valueListenable: _isActive,
                  builder: (context, value, _) {
                    return Neumorphic(
                      child: const Text(
                        "Completed",
                        style: TextStyle(color: Colors.white),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 14),
                      style: NeumorphicStyle(
                        color: (!value)
                            ? const Color(0xff388AFA)
                            : Colors.transparent,
                        disableDepth: value,
                        boxShape: const NeumorphicBoxShape.stadium(),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}

extension on BuildContext {
  TextTheme get getTextTheme => Theme.of(this).textTheme;
}

final fakeDataActive = [
  CourseStatusData(
    contentTitle: "Hip Hop",
    completedSessionsCount: 4,
    totalSessionsCount: 12,
    creditCount: 24,
    ratingCount: 18,
    primaryColor: Color(0xff66B4FF),
    secondaryColor: Color(0xff399AFF),
    sessions: [
      SessionTileData(
        sessionNumber: 1,
        sessionDescription: "Quick recap & ATL Stomp",
        creditCount: 5,
        favCount: 1,
        isLocked: false,
      ),
      SessionTileData(
        sessionNumber: 2,
        sessionDescription: "Some Description2",
        creditCount: 10,
        favCount: 20,
        isLocked: true,
      ),
    ],
  ),
  CourseStatusData(
    contentTitle: "Painting",
    completedSessionsCount: 4,
    totalSessionsCount: 8,
    creditCount: 24,
    ratingCount: 18,
    primaryColor: Color(0xffFFB700),
    secondaryColor: Color(0xffFFAD00),
    sessions: [
      SessionTileData(
        sessionNumber: 1,
        sessionDescription: "Some Description",
        creditCount: 10,
        favCount: 20,
        isLocked: true,
      ),
    ],
  ),
  CourseStatusData(
    contentTitle: "Painting",
    completedSessionsCount: 4,
    totalSessionsCount: 8,
    creditCount: 24,
    ratingCount: 18,
    primaryColor: Color(0xffFFB700),
    secondaryColor: Color(0xffFFAD00),
    sessions: [
      SessionTileData(
        sessionNumber: 1,
        sessionDescription: "Some Description",
        creditCount: 10,
        favCount: 20,
        isLocked: true,
      ),
    ],
  ),
];

final fakeDataCompleted = [
  CourseStatusData(
    contentTitle: "Painting",
    completedSessionsCount: 8,
    totalSessionsCount: 8,
    creditCount: 24,
    ratingCount: 18,
    primaryColor: Color(0xffFFB700),
    secondaryColor: Color(0xffFFAD00),
    sessions: [
      SessionTileData(
        sessionNumber: 1,
        sessionDescription: "Some Description",
        creditCount: 10,
        favCount: 20,
        isLocked: true,
      ),
    ],
  ),
  CourseStatusData(
    contentTitle: "Hip Hop",
    completedSessionsCount: 12,
    totalSessionsCount: 12,
    creditCount: 24,
    ratingCount: 18,
    primaryColor: Color(0xff66B4FF),
    secondaryColor: Color(0xff399AFF),
    sessions: [
      SessionTileData(
        sessionNumber: 1,
        sessionDescription: "Quick recap & ATL Stomp",
        creditCount: 5,
        favCount: 1,
        isLocked: false,
      ),
      SessionTileData(
        sessionNumber: 2,
        sessionDescription: "Some Description2",
        creditCount: 10,
        favCount: 20,
        isLocked: true,
      ),
    ],
  ),
  CourseStatusData(
    contentTitle: "Painting",
    completedSessionsCount: 8,
    totalSessionsCount: 8,
    creditCount: 24,
    ratingCount: 18,
    primaryColor: Color(0xffFFB700),
    secondaryColor: Color(0xffFFAD00),
    sessions: [
      SessionTileData(
        sessionNumber: 1,
        sessionDescription: "Some Description",
        creditCount: 10,
        favCount: 20,
        isLocked: true,
      ),
    ],
  ),
];
