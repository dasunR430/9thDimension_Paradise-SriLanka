import 'package:flutter/material.dart';
import 'package:paradise_sri_lanka/Views/Home/Widgets/search_screen.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Image.asset('assets/images/Home_Screen/LogoSVG.png', height: 40),
      //centerTitle: true,
      actions: [
        IconButton(icon: Icon(Icons.search), onPressed: () {
          if ((ModalRoute.of(context)?.settings.name == 'SearchScreen')) {
            print(ModalRoute.of(context)?.settings.name);
          } else {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SearchScreen(),
                    settings: RouteSettings(name: 'SearchScreen')));
          }
        }),
        IconButton(icon: Icon(Icons.favorite_border), onPressed: () {}),
        IconButton(icon: Icon(Icons.manage_accounts_rounded), onPressed: () {}),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}