// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// // Dummy VisaApplicant model
// class VisaApplicant {
//   final String givenNames;
//   final String passportNumber;
//
//   VisaApplicant({required this.givenNames, required this.passportNumber});
// }
//
// // Dummy ApplicantController for demonstration
// class ApplicantController extends GetxController {
//   VisaApplicant? mainVisaApplicant = VisaApplicant(
//     givenNames: "John Doe",
//     passportNumber: "A12345678",
//   );
//
//   void addMainApplicant() {
//     // Logic to add a main applicant
//   }
//
//   void addOtherApplicant() {
//     // Logic to add other applicants
//   }
//
//   void removeMainApplicant() {
//     // Logic to remove the main applicant
//     mainVisaApplicant = null;
//     update();
//   }
// }
//
// class ApplicantsScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Visa Applicants',
//           style: TextStyle(
//             fontSize: 28,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: GetBuilder<ApplicantController>(
//           init: ApplicantController(),
//           builder: (controller) {
//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Main Applicant Section
//                 Container(
//                   padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
//                   decoration: BoxDecoration(
//                     color: Colors.blue.shade50,
//                     borderRadius: BorderRadius.circular(8),
//                     border: Border.all(color: Colors.blue.shade100, width: 1),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text("Main Applicant", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue)),
//                       const SizedBox(height: 10),
//                       controller.mainVisaApplicant != null
//                           ? VisaApplicantCard(
//                         applicant: controller.mainVisaApplicant,
//                         onRemove: controller.removeMainApplicant,
//                       )
//                           : AddApplicantButton(
//                         onPressed: controller.addMainApplicant,
//                         label: "+ Add Main Applicant",
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//
//                 Container(
//                   padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
//                   decoration: BoxDecoration(
//                     color: Colors.blue.shade50,
//                     borderRadius: BorderRadius.circular(8),
//                     border: Border.all(color: Colors.blue.shade100, width: 1),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Other Applicants Section
//                       const Text("Other Applicants", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue)),
//                       const SizedBox(height: 10),
//                       // Dummy example, you can add real logic for other applicants
//                       AddApplicantButton(
//                         onPressed: controller.addOtherApplicant,
//                         label: "+ Add Other Applicant",
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
//
// class AddApplicantButton extends StatelessWidget {
//   final VoidCallback onPressed;
//   final String label;
//
//   const AddApplicantButton({super.key, required this.onPressed, required this.label});
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onPressed,
//       child: SizedBox(
//         height: 100,
//         child: Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(12),
//             border: Border.all(color: Colors.blue, width: 2),
//             color: Colors.white,
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.blue.withOpacity(0.2),
//                 spreadRadius: 2,
//                 blurRadius: 8,
//                 offset: Offset(0, 4),
//               ),
//             ],
//           ),
//           padding: const EdgeInsets.symmetric(horizontal: 12), // Horizontal padding
//           margin: const EdgeInsets.only(bottom: 12),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//
//               Text(
//                 label,
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.blue,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//
// class VisaApplicantCard extends StatelessWidget {
//   final VisaApplicant? applicant;
//   final VoidCallback? onRemove;
//
//   VisaApplicantCard({required this.applicant, this.onRemove});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(8),
//         border: Border.all(color: Colors.blue, width: 2),
//       ),
//       child: Card(
//         elevation: 0,
//         margin: EdgeInsets.zero,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: ListTile(
//           contentPadding: const EdgeInsets.all(16),
//           leading: Icon(Icons.account_circle, size: 60, color: Colors.blue),
//           title: Text(applicant?.givenNames ?? "Unknown", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//           subtitle: Text(applicant?.passportNumber ?? "No Passport Number", style: TextStyle(fontSize: 14)),
//           trailing: IconButton(
//             icon: const Icon(Icons.remove_circle, color: Colors.red),
//             onPressed: onRemove,
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// void main() {
//   runApp(GetMaterialApp(
//     home: ApplicantsScreen(),
//   ));
// }
