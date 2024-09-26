import 'package:flutter/material.dart';
import 'package:paradise_sri_lanka/Controllers/visa_application_controller.dart';

class FormPage extends StatelessWidget {
  FormPage({super.key, required this.form, required this.formName});

  final Widget form;
  final String formName;

  final VisaApplicationController controller =
      VisaApplicationController.instance;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      key: PageStorageKey(formName),
      physics: const NeverScrollableScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            form,
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (controller.currentPage.value > 0)
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: controller.previousPage,
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25.0),
                          child: Text('Back'),
                        ),
                      ),
                      const SizedBox(width: 15),
                    ],
                  ),

                Expanded(
                  child: (controller.currentPage.value < 4)
                      ? ElevatedButton(
                          onPressed: controller.nextPage,
                          child: const Text('Next'),
                        )
                      : ElevatedButton(
                          onPressed: controller.createVisaApplicant,
                          child: const Text('Submit'),
                        ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
