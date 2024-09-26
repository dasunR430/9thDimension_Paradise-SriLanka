import 'package:flutter/material.dart';
import 'package:paradise_sri_lanka/Common/Widgets/curved_edges_widget.dart';
import 'package:paradise_sri_lanka/Utils/helpers/helper_functions.dart';

class ChatBotAppBarBackground extends StatelessWidget {
  final double height;
  final Widget? child;
  final double opacity;

  const ChatBotAppBarBackground({
    Key? key,
    required this.height,
    required this.opacity,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: CurvedEdgesWidget(
        child: SizedBox(
          height: height,
          width: HelperFunctions.screenWidth(),
          child: Stack(
            children: [
              Image.asset(
                'assets/images/chatbot_background.png',
                fit: BoxFit.cover,
                alignment: Alignment.center,
                width: HelperFunctions.screenWidth(),
                height: height,
              ),
              Positioned(
                bottom: 5,
                right: 0,
                left: 0,
                child: Opacity(
                  opacity: opacity,
                  child: Image.asset(
                    'assets/images/bot_images/chat_assistant_group.png',
                    fit: BoxFit.contain,
                    alignment: Alignment.bottomCenter,
                  ),
                ),
              ),
              // Overlay child widget if provided
              if (child != null) child!,
            ],
          ),
        ),
      ),
    );
  }
}
