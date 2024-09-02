import 'package:flutter/material.dart';
import 'package:paradise_sri_lanka/Common/spacing_styles.dart';
import 'package:paradise_sri_lanka/Views/Profile/Widgets/bottom_panel.dart';

import 'Widgets/account_appbar.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate: ProfileAppBar(
              minHeight: 110.0,
              maxHeight: 400.0,
            ),
            pinned: true,
            floating: true,
          ),

          SliverToBoxAdapter(
              child : Padding(
                  padding: SpacingStyles.withOutAppBarPadding,
                  child:  BottomPanel(),
                ),
          ),
        ],
      ),
    );
  }
}
