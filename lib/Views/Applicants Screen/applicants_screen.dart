import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controllers/applicants_controller.dart';
import '../Visa Form/form_screen.dart';

class ApplicantScreen extends StatelessWidget {
  final ApplicantController _controller = Get.put(ApplicantController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Applicants'),
      ),
      body: Obx(() {
        return Column(
          children: [
            if (_controller.mainApplicant.value != null)
              Card(
                margin: EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text('Main Applicant'),
                  subtitle: Text('Name: ${_controller.mainApplicant.value!.givenNames} ${_controller.mainApplicant.value!.surname}'),
                ),
              ),
            Expanded(
              child: ListView.builder(
                itemCount: _controller.applicants.length,
                itemBuilder: (context, index) {
                  final applicant = _controller.applicants[index];
                  return Card(
                    margin: EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text('${applicant.givenNames} ${applicant.surname}'),
                      subtitle: Text('Passport Number: ${applicant.passportNumber}'),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _controller.removeApplicant(applicant),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                final result = await Get.to(() => FormScreen());
                if (result != null) {
                  _controller.addMainApplicant(result);
                }
              },
              child: Text('Add Main Applicant'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                final result = await Get.to(() => FormScreen());
                if (result != null) {
                  _controller.addOtherApplicant(result);
                }
              },
              child: Text('Add Other Applicant'),
            ),
          ],
        );
      }),
    );
  }
}
