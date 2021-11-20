import 'package:flutter/material.dart';

class CurvedBGContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? margin;
  final double? borderRadius;

  const CurvedBGContainer({
    Key? key,
    required this.child,
    this.margin,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Stack(
        children: <Widget>[
          Positioned.fill(
              child: CurveBGWidget(
            color: Colors.blue,
            borderRadius: borderRadius,
          )),
          child,
        ],
      ),
    );
  }
}

class CurveBGWidget extends StatelessWidget {
  final Color? color;
  final double? borderRadius;

  const CurveBGWidget({Key? key, this.color, this.borderRadius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: BezierClipperCurved(),
      child: Container(
        decoration: BoxDecoration(
          color: color,
        ),
      ),
    );
  }
}

class BlueSecondContainerClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    final double _xScaling = size.width / 375;
    final double _yScaling = size.height / 450;
    path.lineTo(376 * _xScaling, 38.7043 * _yScaling);
    path.cubicTo(
      215.173 * _xScaling,
      -31.3579 * _yScaling,
      58.0096 * _xScaling,
      9.45854 * _yScaling,
      0 * _xScaling,
      38.6511 * _yScaling,
    );
    path.cubicTo(
      0 * _xScaling,
      38.6511 * _yScaling,
      0 * _xScaling,
      288 * _yScaling,
      0 * _xScaling,
      288 * _yScaling,
    );
    path.cubicTo(
      0 * _xScaling,
      288 * _yScaling,
      375.062 * _xScaling,
      288 * _yScaling,
      375.062 * _xScaling,
      288 * _yScaling,
    );
    path.cubicTo(
      375.062 * _xScaling,
      288 * _yScaling,
      376 * _xScaling,
      38.7043 * _yScaling,
      376 * _xScaling,
      38.7043 * _yScaling,
    );
    path.cubicTo(
      376 * _xScaling,
      38.7043 * _yScaling,
      376 * _xScaling,
      38.7043 * _yScaling,
      376 * _xScaling,
      38.7043 * _yScaling,
    );
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}

class WhiteBottomContainerClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    final double _xScaling = size.width / 375;
    final double _yScaling = size.height / 400;
    path.lineTo(376 * _xScaling, 38.7043 * _yScaling);
    path.cubicTo(
      215.173 * _xScaling,
      -31.3579 * _yScaling,
      58.0096 * _xScaling,
      9.45854 * _yScaling,
      0 * _xScaling,
      38.6511 * _yScaling,
    );
    path.cubicTo(
      0 * _xScaling,
      38.6511 * _yScaling,
      0 * _xScaling,
      678 * _yScaling,
      0 * _xScaling,
      678 * _yScaling,
    );
    path.cubicTo(
      0 * _xScaling,
      678 * _yScaling,
      375.062 * _xScaling,
      678 * _yScaling,
      375.062 * _xScaling,
      678 * _yScaling,
    );
    path.cubicTo(
      375.062 * _xScaling,
      678 * _yScaling,
      376 * _xScaling,
      38.7043 * _yScaling,
      376 * _xScaling,
      38.7043 * _yScaling,
    );
    path.cubicTo(
      376 * _xScaling,
      38.7043 * _yScaling,
      376 * _xScaling,
      38.7043 * _yScaling,
      376 * _xScaling,
      38.7043 * _yScaling,
    );
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}

class BezierClipperCurved extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    final double _xScaling = size.width / 320;
    final double _yScaling = size.height / 423;
    path.lineTo(17.8 * _xScaling, 422 * _yScaling);
    path.cubicTo(
      17.8 * _xScaling,
      422 * _yScaling,
      318 * _xScaling,
      422 * _yScaling,
      318 * _xScaling,
      422 * _yScaling,
    );
    path.cubicTo(
      318 * _xScaling,
      422 * _yScaling,
      318 * _xScaling,
      28.2183 * _yScaling,
      318 * _xScaling,
      28.2183 * _yScaling,
    );
    path.cubicTo(
      315.212 * _xScaling,
      36.2673 * _yScaling,
      308.613 * _xScaling,
      57.659 * _yScaling,
      304.524 * _xScaling,
      78.8341 * _yScaling,
    );
    path.cubicTo(
      299.412 * _xScaling,
      105.303 * _yScaling,
      252.012 * _xScaling,
      165.206 * _yScaling,
      218.088 * _xScaling,
      172.636 * _yScaling,
    );
    path.cubicTo(
      184.165 * _xScaling,
      180.066 * _yScaling,
      172.547 * _xScaling,
      208.392 * _yScaling,
      152.565 * _xScaling,
      250.649 * _yScaling,
    );
    path.cubicTo(
      132.582 * _xScaling,
      292.906 * _yScaling,
      95.4059 * _xScaling,
      305.909 * _yScaling,
      76.3529 * _xScaling,
      310.088 * _yScaling,
    );
    path.cubicTo(
      57.3 * _xScaling,
      314.267 * _yScaling,
      33.6 * _xScaling,
      350.023 * _yScaling,
      17.8 * _xScaling,
      422 * _yScaling,
    );
    path.cubicTo(
      17.8 * _xScaling,
      422 * _yScaling,
      17.8 * _xScaling,
      422 * _yScaling,
      17.8 * _xScaling,
      422 * _yScaling,
    );
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
