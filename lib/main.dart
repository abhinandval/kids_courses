import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'components/common_course_container.dart';

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
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: const Color(0xff96C8F8),
          child: Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 32),
                height: 300,
                transform: Matrix4.translationValues(0, 100, 0),
                decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(),
                  color: Colors.lightBlue,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                color: Colors.white,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          "Rom's Courses",
                          style: context.getTextTheme.headline5,
                        ),
                      ),
                    ),
                    Center(
                      child: SizedBox(
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
                              Neumorphic(
                                child: const Text(
                                  "Active",
                                  style: TextStyle(color: Colors.white),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 32, vertical: 14),
                                style: const NeumorphicStyle(
                                  color: Color(0xff388AFA),
                                  disableDepth: false,
                                  boxShape: NeumorphicBoxShape.stadium(),
                                ),
                              ),
                              Neumorphic(
                                child: const Text(
                                  "Completed",
                                  style: TextStyle(color: Colors.white),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 32, vertical: 14),
                                style: const NeumorphicStyle(
                                  color: Colors.transparent,
                                  disableDepth: true,
                                  boxShape: NeumorphicBoxShape.stadium(),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CommonCourseStatus(
                      contentTitle: "Hip Hop",
                      completedSessionsCount: 4,
                      remainingSessionsCount: 8,
                      courseCount: 24,
                      favoriteCount: 18,
                      primaryColor: Color(0xff66B4FF),
                      secondaryColor: Color(0xff399AFF),
                    ),
                    CommonCourseStatus(
                      contentTitle: "Painting",
                      completedSessionsCount: 4,
                      remainingSessionsCount: 8,
                      courseCount: 24,
                      favoriteCount: 18,
                      primaryColor: Color(0xffFFB700),
                      secondaryColor: Color(0xffFFAD00),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

extension on BuildContext {
  TextTheme get getTextTheme => Theme.of(this).textTheme;
}
