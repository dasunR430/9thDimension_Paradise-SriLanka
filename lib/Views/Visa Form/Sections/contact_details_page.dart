import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:paradise_sri_lanka/Common/Widgets/custom_text_input.dart';
import 'package:paradise_sri_lanka/Controllers/visa_application_controller.dart';

class ContactDetailsScreen extends StatelessWidget {
  final VisaApplicationController controller;
  ContactDetailsScreen({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
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
                controller.phoneNumberCountryCodeController.value.text =
                    phone.countryCode;
                controller.phoneNumberController.value.text = phone.number;
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
                controller.whatsAppNumberCountryCodeController.value.text =
                    phone.countryCode;
                controller.whatsAppNumberController.value.text = phone.number;
              },
            ),
            const SizedBox(height: 20),

            //E-mail Field
            CustomTextInputField(
              isRequired: true,
              questionText: 'What is your e-mail address?',
              labelText: 'E-mail',
              controller: controller.emailController.value,
            ),
            const SizedBox(height: 25),

            //Home Address Field
            CustomTextInputField(
              isRequired: true,
              questionText: 'What is your home address?',
              labelText: 'Home Address',
              controller: controller.homeAddressController.value,
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
              controller: controller.emergencyContactPersonNameController.value,
            ),
            const SizedBox(height: 25),

            //Emergency Contact Person Phone Field
            const Text(
              'Phone Number *',
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
                controller.emergencyContactPersonPhoneCountryCodeController
                    .value.text = phone.countryCode;
                controller.emergencyContactPersonPhoneController.value.text =
                    phone.number;
              },
            ),
            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: controller.previousPage,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 5,
                    ),
                    child: const Text('Back'),
                  ),
                  ElevatedButton(
                    onPressed: controller.nextPage,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 5,
                    ),
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
