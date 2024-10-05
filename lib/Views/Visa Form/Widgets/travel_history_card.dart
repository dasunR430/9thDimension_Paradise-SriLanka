import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:paradise_sri_lanka/Common/Widgets/custom_date_picker.dart';
import 'package:paradise_sri_lanka/Common/Widgets/custom_dropdown_field.dart';
import 'package:tuple/tuple.dart';
import '../../../Models/travelled_country.dart';
import 'package:paradise_sri_lanka/Common/Widgets/custom_text_input.dart';
import 'package:country_picker/country_picker.dart';
import '../../../Utils/helpers/helper_functions.dart';
import 'dart:io';

class TravelledCountryCard extends StatelessWidget {
  final TravelledCountry travelledCountry;
  final VoidCallback onRemove;
  final Function(TravelledCountry) onEdit;
  final Function(PlatformFile) onUploadFile;
  final Function(String?) onCountryChanged;
  final Function(String?) onPurposeChanged;

  const TravelledCountryCard({
    super.key,
    required this.travelledCountry,
    required this.onRemove,
    required this.onEdit,
    required this.onUploadFile,
    required this.onCountryChanged,
    required this.onPurposeChanged,
  });

  void _showCountryPicker(BuildContext context) {
    showCountryPicker(
      context: context,
      exclude: ['LK'],
      showPhoneCode: false,
      onSelect: (Country country) {
        final countryCode =
            HelperFunctions.isoToPassportCode(country.countryCode);
        onCountryChanged(countryCode);
        // Update the travelledCountry object
        travelledCountry.country = countryCode;
        // Trigger the onEdit callback to update the parent widget
        onEdit(travelledCountry);
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
                child:
                    const Text('Remove', style: TextStyle(color: Colors.red)),
              ),
            ),
            // Country input
            GestureDetector(
              onTap: () => _showCountryPicker(context),
              child: AbsorbPointer(
                child: CustomTextInputField(
                  isRequired: true,
                  questionText: 'What is the country you visited?',
                  labelText: 'Select Country',
                  controller:
                      TextEditingController(text: travelledCountry.country),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Entry Date input
            CustomDatePickerField(
              questionText: 'Entry date',
              labelText: 'Select',
              initialDate: travelledCountry.entryDate,
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
              controller: TextEditingController(
                  text: travelledCountry.entryDate.toString().split(" ")[0]),
            ),
            const SizedBox(height: 20),

            // Purpose input
            CustomDropdownField(
              questionText: 'Purpose of visit',
              labelText: 'Select',
              items: const ['Tourism', 'Business', 'Other']
                  .map((element) => Tuple2(element, element))
                  .toList(),
              onChanged: onPurposeChanged,
            ),
            const SizedBox(height: 20),

            // File upload button
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue,
                    ),
                    onPressed: () async {
                      FilePickerResult? result =
                          await FilePicker.platform.pickFiles(
                        type: FileType.custom,
                        allowedExtensions: ['jpg', 'pdf', 'png'],
                      );
                      if (result != null && result.files.isNotEmpty) {
                        onUploadFile(result.files.first);
                        // Update the travelledCountry object
                        travelledCountry.attachment = result.files.first.path;
                        // Trigger the onEdit callback to update the parent widget
                        onEdit(travelledCountry);
                      }
                    },
                    child: const Text('Upload File'),
                  ),
                  if (travelledCountry.attachment != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: _isImageFile(travelledCountry.attachment!)
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.file(
                                File(travelledCountry.attachment!),
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Text(basename(travelledCountry.attachment!)),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

String basename(String path) {
  var parts = path.split('/');
  return parts.last.length > 30
      ? '${parts.last.substring(0, 13)}...${parts.last.substring(parts.last.length - 13)}'
      : parts.last;
}

bool _isImageFile(String path) {
  return ['jpg', 'png', 'jpeg'].any((ext) => path.endsWith(ext));
}
