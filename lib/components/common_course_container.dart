import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'common_white_button.dart';

const _colorWhiteBG = Color(0xffFFFAF3);

class CommonCourseStatus extends StatelessWidget {
  const CommonCourseStatus({
    Key? key,
    required this.primaryColor,
    required this.secondaryColor,
    required this.contentTitle,
    required this.completedSessionsCount,
    required this.remainingSessionsCount,
    required this.courseCount,
    required this.favoriteCount,
  }) : super(key: key);

  final Color primaryColor;
  final Color secondaryColor;
  final String contentTitle;
  final int completedSessionsCount;
  final int remainingSessionsCount;
  final int courseCount;
  final int favoriteCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
        ),
        color: primaryColor,
      ),
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          SizedBox(
            height: 168,
            width: double.infinity,
            child: Neumorphic(
              padding: const EdgeInsets.only(
                top: 16,
                bottom: 8,
                left: 16,
                right: 16,
              ),
              style: NeumorphicStyle(
                color: primaryColor,
                shadowLightColor: Colors.white38,
                shape: NeumorphicShape.concave,
                boxShape: NeumorphicBoxShape.roundRect(
                  BorderRadius.circular(24),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    contentTitle,
                    style: context.getTextTheme.headline6
                        ?.copyWith(color: Colors.white),
                  ),
                  const SizedBox(height: 8),
                  const NeumorphicProgress(
                    percent: 0.25,
                    style: ProgressStyle(
                      accent: Colors.white,
                      variant: Colors.white,
                      depth: 0.5,
                      border: NeumorphicBorder(
                        color: Color(0xff389BFF),
                        width: 0.1,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SessionProgressText(
                    completedSessionCount: completedSessionsCount,
                    remainingSessionCount: remainingSessionsCount,
                  ),
                  const SizedBox(height: 8),
                  CourseReward(
                    primaryColor: primaryColor,
                    secondaryColor: secondaryColor,
                    courseCount: courseCount,
                    favoriteCount: favoriteCount,
                  )
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: CommonWhiteButton(
                  text: "Watch Lessons",
                  icon: Icons.play_arrow_rounded,
                  onPressed: () {},
                  primaryColor: primaryColor,
                ),
              ),
              const SizedBox(width: 8),
              CommonWhiteButton(
                text: "Schedule",
                icon: Icons.play_arrow_rounded,
                onPressed: () {},
                primaryColor: primaryColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CourseReward extends StatelessWidget {
  const CourseReward({
    Key? key,
    required this.primaryColor,
    required this.secondaryColor,
    required this.courseCount,
    required this.favoriteCount,
  }) : super(key: key);

  final Color primaryColor;
  final Color secondaryColor;
  final int courseCount;
  final int favoriteCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CourseStatusIndicator(
              primaryColor: primaryColor,
              secondaryColor: secondaryColor,
              rewardCount: courseCount,
              iconData: Icons.check_circle_outline_outlined,
            ),
            const SizedBox(width: 16),
            CourseStatusIndicator(
              primaryColor: primaryColor,
              secondaryColor: secondaryColor,
              rewardCount: favoriteCount,
              iconData: Icons.star,
            ),
          ],
        ),
        Neumorphic(
          padding: const EdgeInsets.all(8),
          style: NeumorphicStyle(
            color: _colorWhiteBG,
            shadowLightColor: secondaryColor,
            boxShape: const NeumorphicBoxShape.circle(),
          ),
          child: Icon(
            Icons.arrow_drop_down,
            color: primaryColor,
          ),
        ),
      ],
    );
  }
}

class CourseStatusIndicator extends StatelessWidget {
  const CourseStatusIndicator({
    Key? key,
    required this.primaryColor,
    required this.secondaryColor,
    required this.iconData,
    required this.rewardCount,
  }) : super(key: key);

  final Color primaryColor;
  final Color secondaryColor;
  final IconData iconData;
  final int rewardCount;

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
        padding: const EdgeInsets.all(8),
        style: NeumorphicStyle(
            shadowLightColor: secondaryColor,
            color: primaryColor,
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(51))),
        child: Row(
          children: [
            Neumorphic(
              padding: const EdgeInsets.all(8),
              style: NeumorphicStyle(
                color: primaryColor,
                shadowLightColor: secondaryColor,
                boxShape: const NeumorphicBoxShape.circle(),
              ),
              child: Icon(
                iconData,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 16),
            Text(
              "$rewardCount",
              style:
                  context.getTextTheme.subtitle2?.copyWith(color: Colors.white),
            ),
            const SizedBox(width: 16),
          ],
        ));
  }
}

class SessionProgressText extends StatelessWidget {
  const SessionProgressText({
    Key? key,
    required this.completedSessionCount,
    required this.remainingSessionCount,
  }) : super(key: key);

  final int completedSessionCount;
  final int remainingSessionCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Completed",
              style:
                  context.getTextTheme.caption?.copyWith(color: Colors.white),
            ),
            Text(
              "$completedSessionCount Sessions",
              style: context.getTextTheme.headline6?.copyWith(
                color: Colors.white,
                fontSize: 14,
              ),
            )
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "Remaining",
              style:
                  context.getTextTheme.caption?.copyWith(color: Colors.white),
            ),
            Text(
              "$remainingSessionCount Sessions",
              style: context.getTextTheme.headline6?.copyWith(
                color: Colors.white,
                fontSize: 14,
              ),
            )
          ],
        )
      ],
    );
  }
}

extension on BuildContext {
  TextTheme get getTextTheme => Theme.of(this).textTheme;
}
