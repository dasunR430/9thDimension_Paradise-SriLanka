import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../Navigation/Widgets/custom_app_bar.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  String searchText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(16),
              child: Stack(
                children: [
                  SearchBar(
                    controller: _controller,
                    hintText: 'Search',
                    hintStyle:
                    WidgetStateProperty.all(TextStyle(color: Colors.grey)),
                    onSubmitted: (value) {
                      // setState(() {
                      //   searchText = value;
                      // });
                      //insert search function here
                    },
                    onTapOutside: (event) {
                      // Dismiss the keyboard when tapped outside the search bar
                      FocusScope.of(context).unfocus();
                    },
                    onChanged: (value) => setState(() {
                      searchText = value;
                    }),
                    backgroundColor: WidgetStateProperty.all(Colors.white),
                    shadowColor: WidgetStateProperty.all(Colors.white),
                  ),
                  Positioned(
                    right: 8,
                    top: 4,
                    child: Visibility(
                      visible: searchText.isNotEmpty,
                      child: IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          // Clear the search text and reset
                          setState(() {
                            searchText = "";
                          });
                          _controller.clear();

                          // Add your reset logic here
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 100),
            Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(
                    'assets/images/Search_Screen/hiking.gif',
                  ),
                  fit: BoxFit.fitHeight,
                ),
              ),
              width: double.infinity,
              height: 260,
            ),
          ],
        ),
      ),
    );
  }
}
