import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:paradise_sri_lanka/Common/Widgets/custom_date_picker.dart';
import 'package:paradise_sri_lanka/Common/Widgets/custom_dropdown_field.dart';
import '../../../Models/travelled_country.dart';

class TravelledCountryCard extends StatelessWidget {
  final TravelledCountry travelledCountry;
  final VoidCallback onRemove;
  final Function(PlatformFile) onUploadFile;

  TravelledCountryCard({
    required this.travelledCountry,
    required this.onRemove,
    required this.onUploadFile,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.grey, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: onRemove,
                child: const Text('Remove', style: TextStyle(color: Colors.red)),
              ),
            ),
            // Country input
            CustomDropdownField(
              questionText: 'What is the country you visited?',
              labelText: 'Country',
              items: const ['USA', 'UK', 'Canada'],
              onChanged: (String? newValue) {
                // Handle country selection
              },
            ),
            SizedBox(height: 20),
            // Entry Date input
            CustomDatePickerField(
              questionText: 'Entry date',
              labelText: 'Select',
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
            ),
            const SizedBox(height: 20),

            // Purpose input
            CustomDropdownField(
              questionText: 'Purpose of visit',
              labelText: 'Select',
              items: const ['Tourism', 'Business', 'Other'],
              onChanged: (String? newValue) {
                // Handle purpose selection
              },
            ),
            const SizedBox(height: 20),

            // File upload button
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    foregroundColor: Colors.white, backgroundColor: Colors.blue,
                  ),
                  onPressed: () async {
                    FilePickerResult? result = await FilePicker.platform
                        .pickFiles(
                      type: FileType.custom,
                      allowedExtensions: ['jpg', 'pdf', 'png'],
                    );
                    if (result != null && result.files.isNotEmpty) {
                      onUploadFile(result.files.first);
                    }
                  },
                  child: const Text('Upload File'),
                ),
                if (travelledCountry.attachment != null)
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(travelledCountry.attachment!.name),
                  ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
