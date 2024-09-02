import 'package:flutter/material.dart';
import 'package:paradise_sri_lanka/Common/Widgets/curved_edges_widget.dart';
import 'package:paradise_sri_lanka/Utils/helpers/helper_functions.dart';

class ProfileAppBarBackground extends StatelessWidget {
  final double height;
  final Widget? child;
  const ProfileAppBarBackground({
    super.key, required this.height, this.child,
  });


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: CurvedEdgesWidget(
        child: SizedBox(
          height: height,
          width: HelperFunctions.screenWidth(),
          child: Container(
            padding: const EdgeInsets.all(0),
            child: Stack(
              children: [
                Positioned(
                    top: 0,
                    left: 0,
                    child: Image.asset("assets/images/account_background.png", fit: BoxFit.fitWidth, width: HelperFunctions.screenWidth(), height: height,)),
                child ?? const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}