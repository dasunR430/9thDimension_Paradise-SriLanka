import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paradise_sri_lanka/Controllers/applicants_controller.dart';
import 'package:tuple/tuple.dart';
import '../../Controllers/visa_type_selection_controller.dart';
import 'Widgets/question_page.dart';
import 'locations.dart';
import 'activities.dart';

class VisaTypeSelection extends StatelessWidget {
  VisaTypeSelection({super.key});

  final VisaTypeSelectionController controller =
      Get.put(VisaTypeSelectionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(controller.titles[controller.currentPage.value],
            style: const TextStyle(fontWeight: FontWeight.bold))),
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
                  dropdownItems: controller.purposes
                      .map((purpose) => Tuple2(purpose, purpose))
                      .toList(),
                  showBack: true,
                  onNext: controller.nextPage,
                  onBack: controller.previousPage,
                  isDropdown: true,
                  textController: controller.purposeController,
                ),
                QuestionPage(
                  title:
                      "Are you traveling as an individual or as part of a family/group?",
                  dropdownItems: controller.entryTypes
                      .map((element) => Tuple2(element, element))
                      .toList(),
                  showBack: true,
                  onNext: controller.nextPage,
                  onBack: controller.previousPage,
                  isDropdown: true,
                  textController: controller.travelTypeController,
                ),
                QuestionPage(
                  title:
                      "Please choose the appropriate visa category for your visit",
                  dropdownItems: controller.visaTypes
                      .map(
                          (visaType) => Tuple2(visaType.visaId, visaType.title))
                      .toList(),
                  showBack: true,
                  onNext: controller.nextPage,
                  onBack: controller.previousPage,
                  isDropdown: true,
                  textController: controller.visaSubCategoryController,
                ),
                QuestionPage(
                  title: "When do you plan to arrive in Sri Lanka?",
                  dropdownItems: const [],
                  showBack: true,
                  onNext: controller.nextPage,
                  onBack: controller.previousPage,
                  isDropdown: false,
                  useDatePicker: true,
                  textController: controller.arrivalDateController,
                ),
                QuestionPage(
                  title:
                      "Select your favorite activities in Sri Lanka (exactly 3)",
                  dropdownItems: categories
                      .map((activity) => Tuple2(activity, activity))
                      .toList(),
                  showBack: true,
                  onNext: controller.nextPage,
                  onBack: controller.previousPage,
                  isDropdown: true,
                  textController: controller.activitiesController,
                  isMultiSelect: true,
                  maxSelections: 3,
                  minSelections: 3,
                ),
                QuestionPage(
                  title: "Select your favorite places in Sri Lanka (up to 5)",
                  dropdownItems: allLocations
                      .map((place) => Tuple2(place, place))
                      .toList(),
                  showBack: true,
                  onNext: controller.nextPage,
                  onBack: controller.previousPage,
                  isDropdown: true,
                  textController: controller.placesController,
                  isMultiSelect: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(ApplicantController());
  runApp(GetMaterialApp(
    home: VisaTypeSelection(),
    theme: ThemeData(
      primarySwatch: Colors.blue,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
  ));
}
