import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controllers/visa_type_selection_controller.dart';
import 'Widgets/question_page.dart';

class VisaTypeSelection extends StatelessWidget {
  VisaTypeSelection({super.key});

  final VisaTypeSelectionController controller = Get.put(VisaTypeSelectionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(controller.titles[controller.currentPage.value], style: TextStyle(fontWeight: FontWeight.bold))),
      ),
      body: Column(
        children: [
          Obx(() => LinearProgressIndicator(
            value: controller.progress.value,
            backgroundColor: Colors.grey[200],
            color: Colors.blue,
          )),
          Expanded(
            child: PageView(
              controller: controller.pageController,
              onPageChanged: controller.onPageChange,
              children: [

                QuestionPage(
                  title: "From which country are your from?",
                  dropdownItems: const [],
                  showBack: true,
                  onNext: controller.nextPage,
                  onBack: controller.previousPage,
                  isDropdown: false,
                  useCountryPicker: true,
                  textController: controller.countryIdController,
                ),

                QuestionPage(
                  title: "What is the primary purpose of your visit?",
                  dropdownItems: const ['Tourism', 'Business', 'Education', 'Medical', 'Other'],
                  showBack: true,
                  onNext: controller.nextPage,
                  onBack: controller.previousPage,
                  isDropdown: true,
                  textController: controller.purposeController,
                ),

                QuestionPage(
                  title: "Are you traveling as an individual or as part of a family/group?",
                  dropdownItems: ['Individual', 'Family', 'Group'],
                  showBack: true,
                  onNext: controller.nextPage,
                  onBack: controller.previousPage,
                  isDropdown: true,
                  textController: controller.travelTypeController,
                ),

                QuestionPage(
                  title: "Please choose the appropriate visa category for your visit",
                  dropdownItems: ['Tourism', 'Business', 'Education', 'Medical', 'Other'],
                  showBack: true,
                  onNext: controller.nextPage,
                  onBack: controller.previousPage,
                  isDropdown: true,
                  textController: controller.visaSubCategoryController,
                ),

                QuestionPage(
                  title: "When do you plan to arrive in Sri Lanka?",
                  dropdownItems: [], // Not used, but could be used for some other inputs
                  showBack: true,
                  onNext: controller.nextPage,
                  onBack: controller.previousPage,
                  isDropdown: false,
                  useDatePicker: true,
                  textController: controller.arrivalDateController,
                ),
                // Add more pages as needed
              ],
            ),
          ),
        ],
      ),
    );
  }
}

