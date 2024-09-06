import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paradise_sri_lanka/Controllers/visa_application_controller.dart';
import 'Widgets/appbar.dart';
import 'Widgets/bottompanel.dart';

class FormScreen extends StatelessWidget {
  FormScreen({super.key});
  final VisaApplicationController controller = Get.put(VisaApplicationController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate: FormAppBar(
              minHeight: 200.0,
              maxHeight: 400.0,
            ),
            pinned: true,
            floating: true,
          ),

          const SliverToBoxAdapter(
            child : Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
              child:  BottomPanel(),
            ),
          ),
        ],
      ),
    );
  }
}