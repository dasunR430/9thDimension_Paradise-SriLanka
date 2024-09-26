import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:paradise_sri_lanka/Common/Widgets/custom_text_input.dart';
import 'package:paradise_sri_lanka/Controllers/visa_application_controller.dart';

class ContactDetailsPage extends StatelessWidget {
  ContactDetailsPage({super.key});

  VisaApplicationController sectionController =
      VisaApplicationController.instance;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '3. Contact Details',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),

        //Mobile Number Field
        const Text(
          'What is your mobile number?',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 8),
        IntlPhoneField(
          //TODO
          //initialCountryCode: ,
          decoration: const InputDecoration(
            labelText: 'Phone Number',
            border: OutlineInputBorder(
              borderSide: BorderSide(),
            ),
          ),
          languageCode: "en",
          onChanged: (phone) {
            sectionController.phoneNumberCountryCodeController.text =
                phone.countryCode;
            sectionController.phoneNumberController.text = phone.number;
          },
        ),
        const SizedBox(height: 20),

        const Text(
          'What is your WhatsApp number?',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 8),
        IntlPhoneField(
          decoration: const InputDecoration(
            labelText: 'WhatsApp Number',
            border: OutlineInputBorder(
              borderSide: BorderSide(),
            ),
          ),
          languageCode: "en",
          onChanged: (phone) {
            sectionController.whatsAppNumberCountryCodeController.text =
                phone.countryCode;
            sectionController.whatsAppNumberController.text = phone.number;
          },
        ),
        const SizedBox(height: 20),

        //E-mail Field
        CustomTextInputField(
          isRequired: true,
          questionText: 'What is your e-mail address?',
          labelText: 'E-mail',
          controller: sectionController.emailController,
        ),
        const SizedBox(height: 25),

        //Home Address Field
        CustomTextInputField(
          isRequired: true,
          questionText: 'What is your home address?',
          labelText: 'Home Address',
          controller: sectionController.homeAddressController,
        ),
        const SizedBox(height: 25),

        const Divider(),

        const SizedBox(height: 25),

        const Text(
          'Emergency Contact',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),

        //Emergency Contact Person Name Field
        CustomTextInputField(
          isRequired: true,
          questionText: 'Name of the Person',
          labelText: 'Name',
          controller: sectionController.emergencyContactPersonNameController,
        ),
        const SizedBox(height: 25),

        //Emergency Contact Person Phone Field
        const Text(
          'Phone Number',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 8),
        IntlPhoneField(
          decoration: const InputDecoration(
            labelText: 'Phone Number',
            border: OutlineInputBorder(
              borderSide: BorderSide(),
            ),
          ),
          languageCode: "en",
          onChanged: (phone) {
            sectionController.emergencyContactPersonPhoneCountryCodeController
                .text = phone.countryCode;
            sectionController.emergencyContactPersonPhoneController.text =
                phone.number;
          },
        ),
      ],
    );
  }
}
