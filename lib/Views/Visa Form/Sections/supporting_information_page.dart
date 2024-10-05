import 'package:flutter/material.dart';
import 'package:paradise_sri_lanka/Common/Widgets/custom_date_picker.dart';
import 'package:paradise_sri_lanka/Common/Widgets/custom_dropdown_field.dart';
import 'package:paradise_sri_lanka/Common/Widgets/custom_text_input.dart';
import 'package:paradise_sri_lanka/Controllers/pdf_upload_controller.dart';
import 'package:paradise_sri_lanka/Controllers/visa_application_controller.dart';
import 'package:tuple/tuple.dart';
import '../Widgets/pdf_upload_widget.dart';

class SupportingDocumentsPage extends StatelessWidget {
  VisaApplicationController controller = VisaApplicationController.instance;

  SupportingDocumentsPage({Key? key, required this.controller})
      : super(key: key);

  PdfUploadController returnAirTicketController = PdfUploadController();
  PdfUploadController accommodationPlaceDocumentController =
      PdfUploadController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              '4. Supporting Information',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            PdfUploadWidget(
              instructionText: 'Upload your return air ticket',
              controller: returnAirTicketController,
              questionText: 'Return Air Ticket',
              type: "return",
            ),
            const SizedBox(height: 25),
            PdfUploadWidget(
              instructionText: 'Upload your accommodation booking confirmation',
              controller: accommodationPlaceDocumentController,
              questionText: 'Accommodation Booking Confirmation',
              type: "accommodation",
            ),
            const SizedBox(height: 25),
            CustomDropdownField(
              questionText: 'Have you visited Sri Lanka before?',
              labelText: 'Select',
              items: const ['Yes', 'No']
                  .map((element) => Tuple2(element, element))
                  .toList(),
              onChanged: (String? newValue) {
                controller.hasVisitedBeforeController.value.text = newValue!;
              },
            ),
            const SizedBox(height: 30),
            CustomDatePickerField(
              isRequired: true,
              questionText: 'If yes when was it?',
              labelText: 'Last visited date',
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
              controller: controller.lastVisitedDate.value,
            ),
            const SizedBox(height: 25),
            CustomTextInputField(
              questionText: 'Enter your Facebook Account URL.',
              labelText: 'Facebook URL',
              controller: controller.facebookURLController.value,
            ),
            const SizedBox(height: 25),
            CustomTextInputField(
              questionText: 'Enter your Instagram Account URL.',
              labelText: 'Instagram URL',
              controller: controller.instagramURLController.value,
            ),
            const SizedBox(height: 25),
            CustomTextInputField(
              questionText: 'Enter your X Account URL.',
              labelText: 'X URL',
              controller: controller.xURLController.value,
            ),
            const SizedBox(height: 25),
            CustomTextInputField(
              questionText: 'Enter your LinkedIn Account URL.',
              labelText: 'LinkedIn URL',
              controller: controller.linkedInURLController.value,
            ),
            const SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: controller.previousPage
                    ,
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
                    onPressed: controller.nextPage
                    ,
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
