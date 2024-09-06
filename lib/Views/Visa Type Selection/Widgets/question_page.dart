import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:paradise_sri_lanka/Common/Widgets/custom_date_picker.dart';
import 'package:paradise_sri_lanka/Common/Widgets/custom_text_input.dart';
import '../../../Common/Widgets/custom_dropdown_field.dart';

class QuestionPage extends StatelessWidget {
  final String title;
  final List<String> dropdownItems;
  final bool showBack;
  final VoidCallback onNext;
  final VoidCallback onBack;
  final bool isDropdown;
  final bool useCountryPicker;
  final bool useDatePicker;
  final TextEditingController textController;

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
  });

  void _showCountryPicker(BuildContext context) {
    showCountryPicker(
      context: context,
      favorite: <String>['SE'],
      showPhoneCode: false,
      onSelect: (Country country) {
        textController.text = country.name;
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
    if (useCountryPicker) {
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

    if (useDatePicker) {
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
            fixedSize: WidgetStateProperty.all<Size>(Size(319, 54)),
            backgroundColor: WidgetStateProperty.all<Color>(Colors.blue),
            side: WidgetStateProperty.all<BorderSide>(
              const BorderSide(
                color: Colors.blue,
                width: 1.0,
              ),
            ),
          ),
          onPressed: onNext,
          child: Text('Next Question', style: TextStyle(fontSize: 19, color: Colors.white)),
        ),
        const SizedBox(height: 20),
        if (showBack)
          ElevatedButton(
            style: ButtonStyle(
              fixedSize: WidgetStateProperty.all<Size>(Size(319, 54)),
              backgroundColor: WidgetStateProperty.all<Color>(Colors.white),
              side: WidgetStateProperty.all<BorderSide>(
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

