import 'package:flutter/material.dart';

import 'account_appbar_background.dart';
import 'account_appbar_bottom.dart';

class ProfileAppBar extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;


  ProfileAppBar({required this.minHeight, required this.maxHeight});


  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    double reversedShrinkOffset = maxHeight - shrinkOffset;
    return SizedBox(
        child: Stack(
          children: [
            ProfileAppBarBackground(
                height: reversedShrinkOffset > minExtent
                    ? reversedShrinkOffset
                    : minExtent),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AppBar(
                title: const Text("Profile", style: TextStyle(color: Colors.white),),
                iconTheme: const IconThemeData(color: Colors.white),
              ),
            ),
            shrinkOffset < maxExtent/4 ?Opacity(
                opacity: (maxExtent- 4*shrinkOffset)/maxExtent,
                child: const AccountAppbarBottom()
            )
                : const SizedBox(),
          ],
        ));
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxExtent ||
        minHeight != oldDelegate.minExtent;
  }
}