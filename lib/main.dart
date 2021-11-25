import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'components/common_course_container.dart';
import 'components/path_bg.dart';
import 'cubits/courseSessions/course_session_cubit.dart';
import 'models/course_status_data.dart';
import 'models/profile_sessions.dart';
import 'res/images.dart';

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
        fontFamily: 'Nexa-Bold',
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
      child: BlocProvider(
        create: (context) => CourseSessionCubit()..fetchData(),
        child: Scaffold(
          backgroundColor: const Color(0xff96C8F8),
          body: BlocBuilder<CourseSessionCubit, CourseSessionState>(
            builder: (context, state) {
              if (state is CourseSessionSuccess) {
                return ProfileWidget(state.profileSessions);
              } else if (state is CourseSessionFailed) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text("Failed to load data, Please retry"),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () {
                          context.read<CourseSessionCubit>().fetchData();
                        },
                        child: const Text("Retry"),
                      )
                    ],
                  ),
                );
              }
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CircularProgressIndicator(),
                    const SizedBox(height: 8),
                    Text((state as CourseSessionLoading).message)
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class ProfileWidget extends StatelessWidget {
  ProfileWidget(
    this.mentorProfiles, {
    Key? key,
  })  : selectedMentorProfile = ValueNotifier(mentorProfiles[0]),
        super(key: key);

  final List<MentorProfileData> mentorProfiles;
  final ValueNotifier<MentorProfileData> selectedMentorProfile;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<MentorProfileData>(
      valueListenable: selectedMentorProfile,
      builder: (context, mentorProfile, _) => Stack(
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
          Positioned(
            top: 70,
            left: 0,
            right: 0,
            child: MentorButton(
              initialData: mentorProfile,
              items: mentorProfiles,
              onChange: (value) {
                if (value != null) {
                  selectedMentorProfile.value = value;
                }
              },
            ),
          ),
          Positioned.fill(
            top: 290,
            child: UserCoursesAndSessions(mentorProfile),
          )
        ],
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
    required this.initialData,
    required this.items,
    required this.onChange,
  }) : super(key: key);

  final MentorProfileData initialData;
  final List<MentorProfileData> items;
  final ValueChanged<MentorProfileData?> onChange;

  Widget buildSelectedItem(String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          ImageRes.buttonBird,
          height: 32,
        ),
        const SizedBox(width: 8),
        Text(
          text.length > 6 ? text.substring(0, 6) + "..." : text,
          style: const TextStyle(
            color: Color(0xff777777),
            fontFamily: 'Nexa-Bold',
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Neumorphic(
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
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: DropdownButton<MentorProfileData>(
            value: initialData,
            items: items.toDropdownMenuItems,
            onChanged: onChange,
            underline: Container(),
            isDense: true,
            selectedItemBuilder: (context) {
              return items
                  .map(
                    (item) => buildSelectedItem(
                      item.profileInfo.firstName,
                    ),
                  )
                  .toList();
            },
          ),
        ),
      ),
    );
  }
}

extension on List<MentorProfileData> {
  List<DropdownMenuItem<MentorProfileData>> get toDropdownMenuItems {
    return map((mentorProfile) => DropdownMenuItem<MentorProfileData>(
          child: Text(
              "${mentorProfile.profileInfo.firstName} ${mentorProfile.profileInfo.lastName}"),
          value: mentorProfile,
        )).toList();
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
  UserCoursesAndSessions(
    this.mentorProfileData, {
    Key? key,
  })  : _currentCoursesList = ValueNotifier(mentorProfileData.activeSessions),
        super(key: key);

  final MentorProfileData mentorProfileData;
  final ValueNotifier<List<CourseStatusData>> _currentCoursesList;

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
                  "${mentorProfileData.profileInfo.firstName}'s Courses",
                  textAlign: TextAlign.center,
                  style: context.getTextTheme.headline5,
                ),
              ),
            ),
            CourseFilterToggle(
              valueChanged: (isActive) {
                _currentCoursesList.value = isActive
                    ? mentorProfileData.activeSessions
                    : mentorProfileData.completedSessions;
              },
            ),
            const SizedBox(
              height: 16,
            ),
            Expanded(
              child: ValueListenableBuilder<List<CourseStatusData>>(
                  valueListenable: _currentCoursesList,
                  builder: (context, data, _) {
                    return ListView.builder(
                      primary: false,
                      itemCount: _currentCoursesList.value.length,
                      itemBuilder: (context, index) =>
                          CommonCourseStatus(_currentCoursesList.value[index]),
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
