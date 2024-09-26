import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paradise_sri_lanka/Controllers/visa_application_controller.dart';
import 'package:paradise_sri_lanka/Utils/helpers/helper_functions.dart';
import 'package:paradise_sri_lanka/Views/Visa%20Form/Widgets/form_page.dart';
import 'Sections/contact_details_page.dart';
import 'Sections/passport_and_photo_page.dart';
import 'Sections/personal_details_page.dart';
import 'Sections/supporting_information_page.dart';
import 'Sections/travel_history.dart';
import 'Widgets/form_appbar.dart';

class FormScreen extends StatelessWidget {
  FormScreen(this.isMainApplicant, {super.key}){
    controller = Get.put(VisaApplicationController(isMainApplicant));
  }
  final bool isMainApplicant;
  late final VisaApplicationController controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverPersistentHeader(
              delegate: FormAppBar(
                minHeight: 200.0,
                maxHeight: 400.0,
              ),
              pinned: true,
              floating: true,
            ),
          ];
        }, body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
          child:  SizedBox(
            height: HelperFunctions.screenHeight() - 200,
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: controller.pageController,
              onPageChanged: (int page) {
                controller.onPageChange(page);
              },
              children: [
                FormPage(form: PassportAndPhotoPage(), formName: "Passport & Photo"),
                FormPage(form: PersonalDetailsPage(), formName: "Personal Details"),
                FormPage(form: ContactDetailsPage(), formName: "Contact Details"),
                FormPage(form: SupportingDocumentsPage(), formName: "Supporting Documents"),
                FormPage(form: TravelHistoryPage(), formName: "Travel History"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}