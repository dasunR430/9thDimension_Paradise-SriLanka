import 'package:flutter/material.dart';

import 'chatbot_appbar_background.dart';

class ChatBotAppBar extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;

  ChatBotAppBar({required this.minHeight, required this.maxHeight});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    double reversedShrinkOffset = maxHeight - shrinkOffset;

    double backgroundHeight = reversedShrinkOffset > minExtent
        ? reversedShrinkOffset
        : minExtent;

    double opacity = reversedShrinkOffset > minHeight
        ? (reversedShrinkOffset) / maxHeight
        : 0;

    return ClipRect(

      child: Column(
        children: [
          Stack(
            children: [
              ChatBotAppBarBackground(
                opacity: opacity,
                height: backgroundHeight,
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  iconTheme: const IconThemeData(color: Colors.white),
                  actions: [
                    IconButton(
                      onPressed: () {
                        // TODO: Add info dialog
                      },
                      icon: const Icon(
                        Icons.info_outline,
                        color: Colors.white,
                      ),
                    ),
                  ],
                  title: Text(
                    "ChatBot",
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxExtent || minHeight != oldDelegate.minExtent;
  }
}
