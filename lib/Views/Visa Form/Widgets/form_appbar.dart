import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'appbar_background.dart';
import 'section_indicator.dart';


class FormAppBar extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;


  FormAppBar({required this.minHeight, required this.maxHeight});


  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    double reversedShrinkOffset = maxHeight - shrinkOffset;
    return SizedBox(
        child: Stack(
          children: [
            FormAppBarBackground(
                height: reversedShrinkOffset > minExtent
                    ? reversedShrinkOffset
                    : minExtent
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Section", style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),),

                SectionIndicator()
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
            ),
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