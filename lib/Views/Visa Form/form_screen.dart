import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paradise_sri_lanka/Controllers/image_select_controller.dart';
import 'package:paradise_sri_lanka/Controllers/image_upload_controller.dart';
import 'package:paradise_sri_lanka/Controllers/visa_application_controller.dart';
import 'package:paradise_sri_lanka/Controllers/applicants_controller.dart';
import 'Widgets/appbar.dart';
import 'Widgets/bottompanel.dart';

class FormScreen extends StatelessWidget {
  String type;
  String visaSelectionTrype;
  FormScreen(this.type,this.visaSelectionTrype,{super.key});
  final VisaApplicationController controller =
      Get.put(VisaApplicationController());
  final ImageUploadController passportBioPageController= Get.put(ImageUploadController());
  final ImageSelectController passportPhotoController= Get.put(ImageSelectController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: controller.scrollController, // Add this line
        slivers: [
          SliverPersistentHeader(
            delegate: FormAppBar(
              minHeight: 200.0,
              maxHeight: 400.0,
            ),
            pinned: true,
            floating: true,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
              child: BottomPanel(controller: controller,applicantType:type,visaSelectionType:visaSelectionTrype), // Pass the controller
            ),
          ),
        ],
      ),
    );
  }
}