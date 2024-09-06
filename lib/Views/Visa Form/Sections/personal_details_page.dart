import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart'; // Import the country_picker package
import 'package:paradise_sri_lanka/Common/Widgets/custom_date_picker.dart';
import 'package:paradise_sri_lanka/Common/Widgets/custom_text_input.dart';
import 'package:paradise_sri_lanka/Controllers/visa_application_controller.dart';
import 'package:tuple/tuple.dart';
import '../../../Common/Widgets/custom_dropdown_field.dart';
import '../../../Utils/helpers/helper_functions.dart';

class PersonalDetailsScreen extends StatelessWidget {

  PersonalDetailsScreen({super.key});

  VisaApplicationController sectionController = VisaApplicationController.instance;

  void _showCountryPicker(BuildContext context) {
    showCountryPicker(
      context: context,
      exclude: <String>['LK'],
      showPhoneCode: false,
      onSelect: (Country country) {
        sectionController.nationalityController.text = HelperFunctions.isoToPassportCode(country.countryCode);
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '2. Personal Details',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Surname Field
            CustomTextInputField(
              isRequired: true,
              questionText: 'What is your surname?',
              labelText: 'Surname',
              controller: sectionController.surnameController,
            ),
            const SizedBox(height: 25),

            // Other names Field
            CustomTextInputField(
              isRequired: true,
              questionText: 'What are your other names?',
              labelText: 'Other names',
              controller: sectionController.otherNamesController,
            ),
            const SizedBox(height: 25),

            // Date of Birth Picker
            CustomDatePickerField(
              isRequired: true,
              questionText: 'When is your birthday?',
              labelText: 'Date of Birth',
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
              controller: sectionController.birthdayController,
            ),
            const SizedBox(height: 25),

            // Place of Birth Field
            CustomTextInputField(
              isRequired: true,
              questionText: 'Where were you born?',
              labelText: 'Place of Birth',
              controller: sectionController.placeOfBirthController,
            ),
            const SizedBox(height: 25),

            // Gender Selection Dropdown
            CustomDropdownField(
              isRequired: true,
              questionText: 'What is your Gender?',
              labelText: 'Gender',
              items: const ['Male', 'Female', 'Other'].map((element)=> Tuple2(element, element)).toList(),
              controller: sectionController.genderController,

            ),
            const SizedBox(height: 25),

            // Nationality Selection
            GestureDetector(
              onTap: () => _showCountryPicker(context),
              child: AbsorbPointer(
                child: CustomTextInputField(
                  isRequired: true,
                  questionText: 'What is your nationality?',
                  labelText: 'Select Country',
                  controller: sectionController.nationalityController,
                ),
              ),
            ),
            const SizedBox(height: 25),

            // Passport Number Field
            CustomTextInputField(
              isRequired: true,
              questionText: 'What is your passport number?',
              labelText: 'Passport Number',
              controller: sectionController.passportNumberController,
            ),
            const SizedBox(height: 25),

            // Passport Expiry Date Picker
            CustomDatePickerField(
              isRequired: true,
              questionText: 'When does your passport expire?',
              labelText: 'Passport Expiry Date',
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime(2100),
              controller: sectionController.passportExpiryDateController,
            ),
            const SizedBox(height: 25),

            // Occupation Field
            CustomTextInputField(
              questionText: 'What is your occupation?',
              labelText: 'Occupation',
              controller: sectionController.occupationController,
            ),
            const SizedBox(height: 25),

            CustomDropdownField(
              questionText: 'What is your Martial Status?',
              labelText: 'Martial Status',
              items: const ['Single', 'Married', 'Divorced'].map((element) => Tuple2(element, element)).toList(),
              controller: sectionController.genderController,

            ),
            const SizedBox(height: 25),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (sectionController.currentPage.value > 0)
                    ElevatedButton(
                      onPressed: sectionController.previousPage,
                      child: const Text('Back'),
                    ),
                  if (sectionController.currentPage.value < 3)
                    ElevatedButton(
                      onPressed: sectionController.nextPage,
                      child: const Text('Next'),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
