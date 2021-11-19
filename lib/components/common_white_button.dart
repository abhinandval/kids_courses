import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

const _colorButtonBG = Color(0xffFFFAF3);

class CommonWhiteButton extends StatelessWidget {
  const CommonWhiteButton({
    Key? key,
    this.onPressed,
    required this.icon,
    required this.text,
    required this.primaryColor,
  }) : super(key: key);

  final void Function()? onPressed;
  final IconData icon;
  final Color primaryColor;
  final String text;

  @override
  Widget build(BuildContext context) {
    return NeumorphicButton(
      margin: const EdgeInsets.only(top: 12),
      onPressed: onPressed,
      style: NeumorphicStyle(
        color: _colorButtonBG,
        shadowLightColor: Colors.white38,
        shape: NeumorphicShape.concave,
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(51)),
      ),
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          Neumorphic(
            padding: const EdgeInsets.all(8),
            style: NeumorphicStyle(
                color: primaryColor,
                shadowLightColor: Colors.white38,
                boxShape: const NeumorphicBoxShape.circle()),
            child: NeumorphicIcon(
              Icons.play_circle_fill,
              style: const NeumorphicStyle(
                shadowLightColor: Colors.white38,
                shape: NeumorphicShape.concave,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(color: primaryColor),
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }
}
