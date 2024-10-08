import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paradise_sri_lanka/Common/Widgets/custom_date_picker.dart';
import 'package:paradise_sri_lanka/Common/Widgets/custom_text_input.dart';
import 'package:tuple/tuple.dart';
import '../../../Common/Widgets/custom_dropdown_field.dart';
import '../../../Utils/helpers/helper_functions.dart';
import '../../../Controllers/visa_type_selection_controller.dart';

class QuestionPage extends StatelessWidget {
  final String title;
  final List<Tuple2<String, String>> dropdownItems;
  final bool showBack;
  final VoidCallback onNext;
  final VoidCallback onBack;
  final bool isDropdown;
  final bool useCountryPicker;
  final bool useDatePicker;
  final bool isMultiSelect;
  final TextEditingController textController;
  final int maxSelections;
  final int minSelections;

  const QuestionPage({
    super.key,
    required this.title,
    required this.dropdownItems,
    required this.showBack,
    required this.onNext,
    required this.onBack,
    required this.textController,
    this.isDropdown = false,
    this.useCountryPicker = false,
    this.useDatePicker = false,
    this.isMultiSelect = false,
    this.maxSelections = 0,
    this.minSelections = 0,
  });

  void _showCountryPicker(BuildContext context) {
    showCountryPicker(
      context: context,
      exclude: ['LK'],
      showPhoneCode: false,
      onSelect: (Country country) {
        textController.text =
            HelperFunctions.isoToPassportCode(country.countryCode);
      },
      moveAlongWithKeyboard: false,
      countryListTheme: CountryListThemeData(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40.0),
          topRight: Radius.circular(40.0),
        ),
        inputDecoration: InputDecoration(
          labelText: 'Search',
          hintText: 'Start typing to search',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: const Color(0xFF8C98A8).withOpacity(0.2),
            ),
          ),
        ),
        searchTextStyle: const TextStyle(
          color: Colors.blue,
          fontSize: 18,
        ),
      ),
    );
  }

  Widget _buildMultiSelectList() {
    final VisaTypeSelectionController controller = Get.find();
    return Expanded(
      child: ListView.builder(
        itemCount: dropdownItems.length,
        itemBuilder: (context, index) {
          final item = dropdownItems[index];
          return Obx(() => CheckboxListTile(
                title: Text(item.item2),
                value: controller.selectedActivities.contains(item.item1) ||
                    controller.selectedPlaces.contains(item.item1),
                onChanged: (bool? value) {
                  if (controller.titles[controller.currentPage.value]
                      .contains('activities')) {
                    controller.selectActivity(item.item1);
                  } else {
                    controller.selectPlace(item.item1);
                  }
                },
              ));
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (useCountryPicker) {
      return _buildCountryPickerPage(context);
    }

    if (useDatePicker) {
      return _buildDatePickerPage();
    }

    if (isMultiSelect) {
      return _buildMultiSelectPage();
    }

    return _buildDropdownPage();
  }

  Widget _buildCountryPickerPage(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const SizedBox(height: 80.0),
          Text(
            title,
            style: const TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.normal,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20.0),
          GestureDetector(
            onTap: () => _showCountryPicker(context),
            child: AbsorbPointer(
              child: CustomTextInputField(
                isRequired: true,
                questionText: title,
                labelText: 'Select Country',
                controller: textController,
              ),
            ),
          ),
          const SizedBox(height: 30.0),
          _buildNavigationButtons(),
        ],
      ),
    );
  }

  Widget _buildDatePickerPage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const SizedBox(height: 80.0),
          Text(
            title,
            style: const TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.normal,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20.0),
          CustomDatePickerField(
            questionText: title,
            labelText: 'Select Date',
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime(2100),
            controller: textController,
          ),
          const SizedBox(height: 30.0),
          _buildNavigationButtons(),
        ],
      ),
    );
  }

  Widget _buildMultiSelectPage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const SizedBox(height: 50.0),
          Text(
            title,
            style: const TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.normal,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20.0),
          _buildMultiSelectList(),
          const SizedBox(height: 10.0),
          Text(
            title.contains("activities")
                ? "Please select exactly 3 activities"
                : "Please select 1 to 5 places",
            style: const TextStyle(
              fontSize: 16.0,
              fontStyle: FontStyle.italic,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 20.0),
          _buildNavigationButtons(),
          const SizedBox(height: 20.0),
        ],
      ),
    );
  }

  Widget _buildDropdownPage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const SizedBox(height: 80.0),
          Text(
            title,
            style: const TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.normal,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20.0),
          CustomDropdownField(
            controller: textController,
            questionText: 'Please select',
            labelText: 'Options',
            items: dropdownItems,
          ),
          const SizedBox(height: 30.0),
          _buildNavigationButtons(),
        ],
      ),
    );
  }

  Widget _buildNavigationButtons() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
          style: ButtonStyle(
            fixedSize: MaterialStateProperty.all<Size>(const Size(319, 54)),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
            side: MaterialStateProperty.all<BorderSide>(
              const BorderSide(
                color: Colors.blue,
                width: 1.0,
              ),
            ),
          ),
          onPressed: onNext,
          child: const Text('Next Question',
              style: TextStyle(fontSize: 19, color: Colors.white)),
        ),
        const SizedBox(height: 20),
        if (showBack)
          ElevatedButton(
            style: ButtonStyle(
              fixedSize: MaterialStateProperty.all<Size>(const Size(319, 54)),
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              side: MaterialStateProperty.all<BorderSide>(
                const BorderSide(
                  color: Colors.blue,
                  width: 1.0,
                ),
              ),
            ),
            onPressed: onBack,
            child: const Text(
              'Back',
              style: TextStyle(fontSize: 19, color: Colors.blue),
            ),
          )
        else
          const SizedBox.shrink(),
      ],
    );
  }
}
