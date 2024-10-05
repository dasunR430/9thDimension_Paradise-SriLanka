// lib/views/components/hero_section.dart
import 'package:flutter/material.dart';


class HeroSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [

        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Image.asset(
            'assets/images/Home_Screen/banner image 1.png', // Replace with your image path
            width: 400,
            height: 420.0,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          bottom: 65.0,
          left: 28.0,
          child: Text(
            "Journey Through Sri Lanka \nWhere Every Path Leads\nto Wonder!",
            style: TextStyle(
              height: 1.2,
              color: Colors.white,
              fontSize: 26.0,
              fontWeight: FontWeight.w900,
              shadows: [
                Shadow(
                  blurRadius: 10.0,
                  color: Colors.black,
                  offset: Offset(2, 2),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}



// import 'dart:async';
// import 'package:flutter/material.dart';
//
// class HeroSection extends StatefulWidget {
//   @override
//   _HeroSectionState createState() => _HeroSectionState();
// }
//
// class _HeroSectionState extends State<HeroSection> {
//   late PageController _pageController;
//   int _currentPage = 0;
//   List<String> _images = [
//     'assets/images/Home_Screen/banner image 1.png',
//     'assets/images/Home_Screen/banner image 2.png',
//     'assets/images/Home_Screen/banner image 3.png',
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//     _pageController = PageController(initialPage: 0);
//     Timer.periodic(Duration(seconds: 3), (Timer timer) {
//       if (_pageController.hasClients) {
//         if (_currentPage < _images.length - 1) {
//           _currentPage++;
//         } else {
//           _currentPage = 0;
//         }
//         _pageController.animateToPage(
//           _currentPage,
//           duration: Duration(milliseconds: 300),
//           curve: Curves.easeIn,
//         );
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         PageView.builder(
//           controller: _pageController,
//           itemCount: _images.length,
//           itemBuilder: (context, index) {
//             return Image.asset(
//               _images[index],
//               width: 400,
//               height: 420.0,
//               fit: BoxFit.cover,
//             );
//           },
//         ),
//         Positioned(
//           bottom: 65.0,
//           left: 28.0,
//           child: Text(
//             "Journey Through Sri Lanka \nWhere Every Path Leads\n to Wonder!",
//             style: TextStyle(
//               height: 1.2,
//               color: Colors.white,
//               fontSize: 26.0,
//               fontWeight: FontWeight.w900,
//               shadows: [
//                 Shadow(
//                   blurRadius: 10.0,
//                   color: Colors.black,
//                   offset: Offset(2, 2),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }