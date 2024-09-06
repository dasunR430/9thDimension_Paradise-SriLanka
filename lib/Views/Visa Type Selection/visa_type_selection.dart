import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tuple/tuple.dart';
import '../../Controllers/visa_type_selection_controller.dart';
import 'Widgets/question_page.dart';

class VisaTypeSelection extends StatelessWidget {
  VisaTypeSelection({super.key});

  final VisaTypeSelectionController controller = Get.put(VisaTypeSelectionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(controller.titles[controller.currentPage.value], style: const TextStyle(fontWeight: FontWeight.bold))),
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
              physics: const NeverScrollableScrollPhysics(),
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
                  dropdownItems: controller.purposes.map((purpose) => Tuple2(purpose, purpose)).toList(),
                  showBack: true,
                  onNext: controller.nextPage,
                  onBack: controller.previousPage,
                  isDropdown: true,
                  textController: controller.purposeController,
                ),

                QuestionPage(
                  title: "Are you traveling as an individual or as part of a family/group?",
                  dropdownItems: controller.entryTypes.map((element) => Tuple2(element, element)).toList(),
                  showBack: true,
                  onNext: controller.nextPage,
                  onBack: controller.previousPage,
                  isDropdown: true,
                  textController: controller.travelTypeController,
                ),

                QuestionPage(
                  title: "Please choose the appropriate visa category for your visit",
                  dropdownItems: controller.visaTypes.map((visaType) => Tuple2(visaType.visaId, visaType.title)).toList(),
                  showBack: true,
                  onNext: controller.nextPage,
                  onBack: controller.previousPage,
                  isDropdown: true,
                  textController: controller.visaSubCategoryController,
                ),

                QuestionPage(
                  title: "When do you plan to arrive in Sri Lanka?",
                  dropdownItems: const [], // Not used, but could be used for some other inputs
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

