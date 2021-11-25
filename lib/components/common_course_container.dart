import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/course_status_data.dart';
import '../models/session_tile_data.dart';
import '../res/images.dart';
import 'common_white_button.dart';

const _colorWhiteBG = Color(0xffFFFAF3);

class CommonCourseStatus extends StatelessWidget {
  CommonCourseStatus(
    this.data, {
    Key? key,
  }) : super(key: key);

  final CourseStatusData data;
  final ValueNotifier<bool> _sessionListExpanded = ValueNotifier(false);

  void _toggleExpanded() {
    _sessionListExpanded.value = !_sessionListExpanded.value;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
        ),
        color: data.primaryColor,
      ),
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.only(
        left: 8,
        right: 8,
        top: 8,
        bottom: 16,
      ),
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
                color: data.primaryColor,
                shadowLightColor: Colors.white38,
                shape: NeumorphicShape.concave,
                boxShape: NeumorphicBoxShape.roundRect(
                  BorderRadius.circular(24),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      data.contentTitle,
                      style: context.getTextTheme.headline6?.copyWith(
                        color: Colors.white,
                        fontFamily: 'Nexa-Bold',
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  NeumorphicProgress(
                    percent:
                        data.completedSessionsCount / data.totalSessionsCount,
                    style: ProgressStyle(
                      accent: Colors.white,
                      variant: Colors.white,
                      depth: 4,
                      border: NeumorphicBorder(
                        color: data.secondaryColor,
                        width: 0.9,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SessionProgressText(
                      completedSessionCount: data.completedSessionsCount,
                      remainingSessionCount: data.remainingSessionsCount,
                      isCompleted: data.isCompleted),
                  const SizedBox(height: 8),
                  ValueListenableBuilder<bool>(
                    valueListenable: _sessionListExpanded,
                    builder: (context, value, _) {
                      return CourseReward(
                        primaryColor: data.primaryColor,
                        secondaryColor: data.secondaryColor,
                        courseCount: data.creditCount,
                        favoriteCount: data.ratingCount,
                        isExpanded: value,
                        onToggle: _toggleExpanded,
                      );
                    },
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          ValueListenableBuilder<bool>(
            valueListenable: _sessionListExpanded,
            builder: (context, isExpanded, child) {
              return isExpanded
                  ? SessionsListView(
                      primaryColor: data.primaryColor,
                      sessions: data.sessions,
                    )
                  : const SizedBox(height: 0);
            },
          ),
          ValueListenableBuilder<bool>(
            valueListenable: _sessionListExpanded,
            builder: (context, isExpanded, child) {
              return isExpanded
                  ? const SizedBox(height: 16)
                  : const SizedBox(height: 0);
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CommonWhiteButton(
                text: "Watch Lessons",
                iconData: Icons.play_circle_fill_rounded,
                onPressed: () {},
                primaryColor: data.primaryColor,
              ),
              CommonWhiteButton(
                text: data.isCompleted ? "Certificate" : "Schedule",
                iconData: data.isCompleted
                    ? FontAwesomeIcons.award
                    : Icons.access_time_filled_rounded,
                onPressed: () {},
                primaryColor: data.primaryColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SessionsListView extends StatelessWidget {
  const SessionsListView({
    Key? key,
    required this.primaryColor,
    required this.sessions,
  }) : super(key: key);

  final Color primaryColor;
  final List<SessionTileData> sessions;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        decoration: const BoxDecoration(boxShadow: [
          BoxShadow(
            blurRadius: 20,
            spreadRadius: 0,
            color: Colors.white12,
            offset: Offset(-5, -7),
          ),
          BoxShadow(
            blurRadius: 10,
            spreadRadius: 0,
            color: Colors.black26,
            offset: Offset(5, 7),
          ),
        ]),
        child: Neumorphic(
          padding: const EdgeInsets.all(8),
          style: NeumorphicStyle(
            shadowLightColor: Colors.white24,
            shadowDarkColor: Colors.black54,
            shadowDarkColorEmboss: Colors.black54,
            depth: -4,
            color: primaryColor,
            boxShape: NeumorphicBoxShape.roundRect(
              BorderRadius.circular(18),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: sessions.map((data) => SessionInfoTile(data)).toList(),
          ),
        ),
      ),
    );
  }
}

class SessionInfoTile extends StatelessWidget {
  const SessionInfoTile(
    this.data, {
    Key? key,
  }) : super(key: key);

  final SessionTileData data;

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 4),
      style: NeumorphicStyle(
        boxShape: NeumorphicBoxShape.roundRect(
          BorderRadius.circular(13),
        ),
        shadowLightColor: Colors.white24,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Session ${data.sessionNumber}",
                  style: context.getTextTheme.caption,
                ),
                Text(
                  data.sessionDescription,
                  style: context.getTextTheme.subtitle2?.copyWith(
                    color: Colors.black54,
                    fontFamily: "Nexa-Bold",
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          // const Spacer(),
          if (data.isLocked)
            SvgPicture.asset(ImageRes.greenLockIcon)
          else ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(ImageRes.greenStarIcon),
                Text("${data.favCount}"),
              ],
            ),
            const SizedBox(width: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(ImageRes.greenCIcon),
                Text("${data.creditCount}"),
              ],
            )
          ]
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
    this.isExpanded = false,
    required this.onToggle,
  }) : super(key: key);

  final Color primaryColor;
  final Color secondaryColor;
  final int courseCount;
  final int favoriteCount;
  final bool isExpanded;
  final VoidCallback onToggle;

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
        GestureDetector(
          onTap: onToggle,
          child: Neumorphic(
            padding: const EdgeInsets.all(8),
            style: NeumorphicStyle(
              color: _colorWhiteBG,
              shadowLightColor: secondaryColor,
              boxShape: const NeumorphicBoxShape.circle(),
              shape: NeumorphicShape.concave,
            ),
            child: Icon(
              isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
              color: primaryColor,
            ),
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
          shadowLightColor: Colors.white24,
          shadowDarkColor: secondaryColor,
          color: primaryColor,
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(51)),
          shape: NeumorphicShape.concave,
        ),
        child: Row(
          children: [
            Neumorphic(
              padding: const EdgeInsets.all(8),
              style: NeumorphicStyle(
                color: primaryColor,
                shadowLightColor: Colors.white24,
                shadowDarkColor: secondaryColor,
                boxShape: const NeumorphicBoxShape.circle(),
                shape: NeumorphicShape.concave,
              ),
              child: Icon(
                iconData,
                color: Colors.white,
                size: 12,
              ),
            ),
            const SizedBox(width: 16),
            Text(
              "$rewardCount",
              style: context.getTextTheme.subtitle2?.copyWith(
                color: Colors.white,
                fontFamily: 'Nexa-Bold',
              ),
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
    required this.isCompleted,
  }) : super(key: key);

  final int completedSessionCount;
  final int remainingSessionCount;
  final bool isCompleted;

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
        isCompleted
            ? SvgPicture.asset(ImageRes.trophyImage)
            : Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Remaining",
                    style: context.getTextTheme.caption
                        ?.copyWith(color: Colors.white),
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

class GreenStarShape extends NeumorphicPathProvider {
  @override
  Path getPath(Size size) {
    Paint paint = Paint();
    Path path = Path();
    paint.color = const Color(0xffFFB754);
    path = Path();
    path.lineTo(size.width * 1.28, size.height * 0.69);
    path.cubicTo(size.width * 1.28, size.height * 0.67, size.width * 1.27,
        size.height * 0.66, size.width * 1.26, size.height * 0.65);
    path.cubicTo(size.width * 1.24, size.height * 0.64, size.width * 1.23,
        size.height * 0.63, size.width * 1.21, size.height * 0.63);
    path.cubicTo(size.width * 1.21, size.height * 0.63, size.width * 0.97,
        size.height * 0.59, size.width * 0.97, size.height * 0.59);
    path.cubicTo(size.width * 0.97, size.height * 0.59, size.width * 0.86,
        size.height * 0.36, size.width * 0.86, size.height * 0.36);
    path.cubicTo(size.width * 0.85, size.height * 0.35, size.width * 0.84,
        size.height / 3, size.width * 0.83, size.height / 3);
    path.cubicTo(size.width * 0.81, size.height * 0.32, size.width * 0.8,
        size.height * 0.31, size.width * 0.78, size.height * 0.31);
    path.cubicTo(size.width * 0.77, size.height * 0.31, size.width * 0.75,
        size.height * 0.32, size.width * 0.74, size.height / 3);
    path.cubicTo(size.width * 0.73, size.height / 3, size.width * 0.72,
        size.height * 0.35, size.width * 0.71, size.height * 0.36);
    path.cubicTo(size.width * 0.71, size.height * 0.36, size.width * 0.6,
        size.height * 0.59, size.width * 0.6, size.height * 0.59);
    path.cubicTo(size.width * 0.6, size.height * 0.59, size.width * 0.35,
        size.height * 0.63, size.width * 0.35, size.height * 0.63);
    path.cubicTo(size.width * 0.34, size.height * 0.63, size.width * 0.32,
        size.height * 0.64, size.width * 0.31, size.height * 0.65);
    path.cubicTo(size.width * 0.3, size.height * 0.66, size.width * 0.29,
        size.height * 0.67, size.width * 0.29, size.height * 0.69);
    path.cubicTo(size.width * 0.28, size.height * 0.7, size.width * 0.28,
        size.height * 0.72, size.width * 0.29, size.height * 0.74);
    path.cubicTo(size.width * 0.29, size.height * 0.75, size.width * 0.3,
        size.height * 0.76, size.width * 0.31, size.height * 0.78);
    path.cubicTo(size.width * 0.31, size.height * 0.78, size.width * 0.49,
        size.height * 0.96, size.width * 0.49, size.height * 0.96);
    path.cubicTo(size.width * 0.49, size.height * 0.96, size.width * 0.45,
        size.height * 1.21, size.width * 0.45, size.height * 1.21);
    path.cubicTo(size.width * 0.44, size.height * 1.23, size.width * 0.44,
        size.height * 1.25, size.width * 0.45, size.height * 1.26);
    path.cubicTo(size.width * 0.46, size.height * 1.27, size.width * 0.47,
        size.height * 1.29, size.width * 0.48, size.height * 1.3);
    path.cubicTo(size.width * 0.49, size.height * 1.31, size.width / 2,
        size.height * 1.31, size.width * 0.52, size.height * 1.31);
    path.cubicTo(size.width * 0.53, size.height * 1.31, size.width * 0.55,
        size.height * 1.31, size.width * 0.56, size.height * 1.3);
    path.cubicTo(size.width * 0.56, size.height * 1.3, size.width * 0.78,
        size.height * 1.18, size.width * 0.78, size.height * 1.18);
    path.cubicTo(size.width * 0.78, size.height * 1.18, size.width,
        size.height * 1.3, size.width, size.height * 1.3);
    path.cubicTo(size.width * 1.02, size.height * 1.31, size.width * 1.03,
        size.height * 1.31, size.width * 1.05, size.height * 1.31);
    path.cubicTo(size.width * 1.06, size.height * 1.31, size.width * 1.08,
        size.height * 1.31, size.width * 1.09, size.height * 1.3);
    path.cubicTo(size.width * 1.1, size.height * 1.29, size.width * 1.11,
        size.height * 1.27, size.width * 1.12, size.height * 1.26);
    path.cubicTo(size.width * 1.12, size.height * 1.25, size.width * 1.13,
        size.height * 1.23, size.width * 1.12, size.height * 1.21);
    path.cubicTo(size.width * 1.12, size.height * 1.21, size.width * 1.08,
        size.height * 0.96, size.width * 1.08, size.height * 0.96);
    path.cubicTo(size.width * 1.08, size.height * 0.96, size.width * 1.26,
        size.height * 0.77, size.width * 1.26, size.height * 0.77);
    path.cubicTo(size.width * 1.27, size.height * 0.76, size.width * 1.28,
        size.height * 0.75, size.width * 1.28, size.height * 0.73);
    path.cubicTo(size.width * 1.29, size.height * 0.72, size.width * 1.29,
        size.height * 0.7, size.width * 1.28, size.height * 0.69);
    path.cubicTo(size.width * 1.28, size.height * 0.69, size.width * 1.28,
        size.height * 0.69, size.width * 1.28, size.height * 0.69);
    path.cubicTo(size.width * 1.28, size.height * 0.69, size.width * 1.28,
        size.height * 0.69, size.width * 1.28, size.height * 0.69);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant NeumorphicPathProvider oldClipper) {
    return true;
  }

  @override
  bool get oneGradientPerPath => true;
}
