import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paradise_sri_lanka/Controllers/error_display_controller.dart';
import 'package:tuple/tuple.dart';
import 'package:paradise_sri_lanka/Controllers/visa_application_controller.dart';
import '../../../Common/Widgets/custom_dropdown_field.dart';
import '../../../Common/Widgets/custom_text_input.dart';
import '../../../Common/Widgets/custom_date_picker.dart';
import '../../../Utils/helpers/helper_functions.dart';
import 'package:country_picker/country_picker.dart';

class PersonalDetailsScreen extends StatelessWidget {
  final VisaApplicationController controller;
  final ErrorController errorController = ErrorController();

  PersonalDetailsScreen({super.key, required this.controller});

  void _showCountryPicker(BuildContext context) {
    showCountryPicker(
      context: context,
      exclude: <String>['LK'],
      showPhoneCode: false,
      onSelect: (Country country) {
        controller.nationalityController.value.text =
            HelperFunctions.isoToPassportCode(country.countryCode);
      },
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
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Surname Field
            Obx(() => CustomTextInputField(
                  isRequired: true,
                  questionText: 'What is your surname?',
                  labelText: 'Surname',
                  controller: controller.surnameController.value,
                )),
            const SizedBox(height: 25),

            // Other Names Field
            Obx(() => CustomTextInputField(
                  isRequired: true,
                  questionText: 'What are your other names?',
                  labelText: 'Other Names',
                  controller: controller.otherNamesController.value,
                )),
            const SizedBox(height: 25),

            // Birthday Picker
            Obx(() => CustomDatePickerField(
                  isRequired: true,
                  questionText: 'What is your date of birth?',
                  labelText: 'Date of Birth',
                  initialDate: DateTime(2000),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                  controller: controller.birthdayController.value,
                )),
            const SizedBox(height: 25),

            // Place of Birth Field
            Obx(() => CustomTextInputField(
                  isRequired: true,
                  questionText: 'Where were you born?',
                  labelText: 'Place of Birth',
                  controller: controller.placeOfBirthController.value,
                )),
            const SizedBox(height: 25),

            // Gender Dropdown
            Obx(() => CustomDropdownField(
                  isRequired: true,
                  questionText: 'What is your Gender?',
                  labelText: 'Gender',
                  items: const ['Male', 'Female', 'Other']
                      .map((element) => Tuple2(element, element))
                      .toList(),
                  controller: controller.genderController.value,
                )),
            const SizedBox(height: 25),

            // Nationality Field with Country Picker
            GestureDetector(
              onTap: () => _showCountryPicker(context),
              child: AbsorbPointer(
                child: Obx(() => CustomTextInputField(
                      isRequired: true,
                      questionText: 'What is your nationality?',
                      labelText: 'Select Country',
                      controller: controller.nationalityController.value,
                    )),
              ),
            ),
            const SizedBox(height: 25),

            // Passport Number Field
            Obx(() => CustomTextInputField(
                  isRequired: true,
                  questionText: 'What is your passport number?',
                  labelText: 'Passport Number',
                  controller: controller.passportNumberController.value,
                )),
            const SizedBox(height: 25),

            // Passport Expiry Date Picker
            Obx(() => CustomDatePickerField(
                  isRequired: true,
                  questionText: 'When does your passport expire?',
                  labelText: 'Passport Expiry Date',
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2100),
                  controller: controller.passportExpiryDateController.value,
                )),
            const SizedBox(height: 25),

            // Occupation Field
            Obx(() => CustomTextInputField(
                  questionText: 'What is your occupation?',
                  labelText: 'Occupation',
                  controller: controller.occupationController.value,
                )),
            const SizedBox(height: 25),

            // Marital Status Dropdown
            Obx(() => CustomDropdownField(
                  questionText: 'What is your Marital Status?',
                  labelText: 'Marital Status',
                  items: const ['Single', 'Married', 'Divorced', 'Widowed']
                      .map((element) => Tuple2(element, element))
                      .toList(),
                  controller: controller.maritalStatusController.value,
                )),
            const SizedBox(height: 25),

            // Next Button with Validation

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: controller.previousPage,
                  child: const Text('Back'),
                ),
                ElevatedButton(
                  onPressed: controller.nextPage,
                  child: const Text('Next'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
