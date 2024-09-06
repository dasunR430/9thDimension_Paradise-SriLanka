import 'package:flutter/material.dart';
import 'package:paradise_sri_lanka/Common/Widgets/custom_date_picker.dart';
import 'package:paradise_sri_lanka/Common/Widgets/custom_dropdown_field.dart';
import 'package:paradise_sri_lanka/Common/Widgets/custom_text_input.dart';
import 'package:paradise_sri_lanka/Controllers/pdf_upload_controller.dart';
import 'package:paradise_sri_lanka/Controllers/visa_application_controller.dart';
import 'package:tuple/tuple.dart';
import '../Widgets/pdf_upload_widget.dart';

class SupportingDocumentsPage extends StatelessWidget {

  SupportingDocumentsPage({super.key});

  final PdfUploadController returnAirTicketController = PdfUploadController();
  final PdfUploadController accommodationPlaceDocumentController = PdfUploadController();
  final VisaApplicationController sectionController = VisaApplicationController.instance;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
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

            ),

            const SizedBox(height: 25),

            PdfUploadWidget(
              instructionText: 'Upload your accommodation booking confirmation',
              controller: accommodationPlaceDocumentController,
              questionText: 'Accommodation Booking Confirmation',
            ),

            const SizedBox(height: 25),

            CustomDropdownField(
              questionText: 'Have you visited Sri Lanka before?',
              labelText: 'Select',
              items: const ['Yes', 'No'].map((element) => Tuple2(element, element)).toList(),
              onChanged: (String? newValue) {
                sectionController.hasVisitedBeforeController.text = newValue!;
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
              controller: sectionController.lastVisitedDateController,
            ),
            const SizedBox(height: 25),

            CustomTextInputField(
              questionText: 'Enter your Facebook Account URL.',
              labelText: 'Facebook URL',
              controller: sectionController.facebookURLController,
            ),
            const SizedBox(height: 25),

            CustomTextInputField(
              questionText: 'Enter your Instagram Account URL.',
              labelText: 'Instagram URL',
              controller: sectionController.instagramURLController,
            ),
            const SizedBox(height: 25),

            CustomTextInputField(
              questionText: 'Enter your X Account URL.',
              labelText: 'X URL',
              controller: sectionController.xURLController,
            ),
            const SizedBox(height: 25),

            CustomTextInputField(
              questionText: 'Enter your LinkedIn Account URL.',
              labelText: 'LinkedIn URL',
              controller: sectionController.linkedInURLController,
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
