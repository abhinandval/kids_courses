import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

const _colorButtonBG = Color(0xffFFFAF3);

class CommonWhiteButton extends StatelessWidget {
  const CommonWhiteButton({
    Key? key,
    this.onPressed,
    required this.iconData,
    required this.text,
    required this.primaryColor,
  }) : super(key: key);

  final void Function()? onPressed;
  final IconData iconData;
  final Color primaryColor;
  final String text;

  @override
  Widget build(BuildContext context) {
    return NeumorphicButton(
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
              iconData,
              style: const NeumorphicStyle(
                shadowLightColor: Colors.white38,
                shape: NeumorphicShape.concave,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(color: primaryColor, fontFamily: 'Nexa-Bold'),
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }
}
