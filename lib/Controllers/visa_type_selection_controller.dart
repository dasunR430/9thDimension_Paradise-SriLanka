import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paradise_sri_lanka/Views/Applicants%20Screen/test_sceen.dart';
import 'package:paradise_sri_lanka/Views/Visa%20Form/form_screen.dart';
import 'package:paradise_sri_lanka/Views/Visa%20Portal/visa_portal_screen.dart';
import '../Models/visaType.dart';
import '../Services/API/database.dart';
import 'applicants_controller.dart';

class VisaTypeSelectionController extends GetxController {
  final ApplicantController applicantsController =
      Get.find<ApplicantController>();

  RxInt currentPage = 0.obs;
  int _cPage = 0;
  var pages = 7; // Increased to include the new places page
  RxDouble progress = 0.0.obs;

  final PageController pageController = PageController();

  final TextEditingController countryIdController = TextEditingController();
  final TextEditingController travelTypeController = TextEditingController();
  final TextEditingController purposeController = TextEditingController();
  final TextEditingController visaSubCategoryController =
      TextEditingController();
  final TextEditingController arrivalDateController = TextEditingController();
  final TextEditingController departureDateController = TextEditingController();
  final TextEditingController accommodationController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController zipController = TextEditingController();
  final TextEditingController activitiesController = TextEditingController();
  final TextEditingController placesController = TextEditingController();

  RxList<String> selectedActivities = <String>[].obs;
  RxList<String> selectedPlaces = <String>[].obs;
  List<String> titles = [
    "Let's Start",
    "Just a few more questions",
    "Just a few more questions",
    "Almost there",
    "Last Question",
    "Select your favorite activities",
    "Select your favorite places",
  ];

  late final List<VisaType> visaTypes;
  List<String> purposes = [
    'Sightseeing / Holidaying',
    'Visiting friends and relatives',
    'Medical treatment including Ayurvedic and Yoga',
    'Participating in sports events, competitions, and activities relating to cultural performance',
  ];

  List<String> entryTypes = [
    'Individual',
    'Group',
  ];
  final List<String> activities = [
    'Beach relaxation',
    'Surfing',
    'Scuba diving',
    'Snorkeling',
    'Whale watching',
    'Hiking',
    'Wildlife safari',
    'Tea plantation tour',
    'Cultural sightseeing',
    'Temple visits',
    'Cooking classes',
    'Ayurvedic spa treatments',
    'Train rides through scenic routes',
    'Water rafting',
    'Cycling tours',
    'Yoga and meditation retreats',
    'Elephant orphanage visit',
    'Gem mining tour',
    'Cinnamon plantation visit',
    'Stilt fishing observation',
  ];

  @override
  void onInit() {
    _getVisaTypes();
    super.onInit();
  }

  @override
  void onClose() {
    // Dispose controllers when not needed
    pageController.dispose();
    countryIdController.dispose();
    travelTypeController.dispose();
    purposeController.dispose();
    visaSubCategoryController.dispose();
    arrivalDateController.dispose();
    departureDateController.dispose();
    accommodationController.dispose();
    addressController.dispose();
    cityController.dispose();
    zipController.dispose();
    activitiesController.dispose();
    placesController.dispose();
    super.onClose();
  }

  void nextPage() {
    if (_cPage < pages - 1) {
      if (_validatePage()) {
        _cPage++;
        pageController.animateToPage(_cPage,
            duration: const Duration(milliseconds: 300), curve: Curves.linear);
        setIndicator();
      } else {
        Get.snackbar(
          "Incomplete Information",
          "Please fill in all required fields before proceeding.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );
      }
    } else if (_cPage == pages - 1) {
      if (_validatePage()) {
        String countryId = countryIdController.value.text;
        String visaTypeId = visaSubCategoryController.value.text;
        DateTime? startDate = tryParseDate(arrivalDateController.value.text);
        String travelType = travelTypeController.value.text;

        if (startDate == null) {
          Get.snackbar(
            "Invalid Date",
            "Please enter a valid date.",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.redAccent,
            colorText: Colors.white,
            duration: const Duration(seconds: 2),
          );
          return;
        }

        _cPage = 0;
        applicantsController.setVisaDetails(
          countryId: countryId,
          visaTypeId: visaTypeId,
          startDate: startDate,
          activities: selectedActivities,
          places: selectedPlaces,
        );

        // Navigate based on travel type
        if (travelType != "Individual") {
          Get.off(() => ApplicantsScreen());
        } else {
          applicantsController.addMainApplicantIndividual();
        }
      } else {
        Get.snackbar(
          "Incomplete Information",
          "Please fill in all required fields before proceeding.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );
      }
    }
  }

  void previousPage() {
    if (_cPage <= 0) {
      Get.off(() => VisaPortalScreen());
    } else if (_cPage > 0) {
      _cPage--;
      pageController.animateToPage(_cPage,
          duration: const Duration(milliseconds: 300), curve: Curves.linear);
      setIndicator();
    }
  }

  void onPageChange(int page) {
    _cPage = page;
    setIndicator();
  }

  void setIndicator() {
    progress.value = (_cPage + 1) / pages;
    currentPage.value = _cPage;
  }

  // Validation method
  bool _validatePage() {
    switch (_cPage) {
      case 0:
        return countryIdController.text.isNotEmpty;
      case 1:
        return purposeController.text.isNotEmpty;
      case 2:
        return travelTypeController.text.isNotEmpty;
      case 3:
        return visaSubCategoryController.text.isNotEmpty;
      case 4:
        return arrivalDateController.text.isNotEmpty;
      case 5:
        return selectedActivities.isNotEmpty && selectedActivities.length == 3;
      case 6:
        return selectedPlaces.isNotEmpty && selectedPlaces.length <= 5;
      default:
        return true;
    }
  }

  DateTime? tryParseDate(String date) {
    try {
      return DateTime.parse(date);
    } catch (e) {
      return null;
    }
  }

  void _getVisaTypes() {
    ParadiseDataBase.visaTypes.then((value) {
      if (value == null) {
        visaTypes = [];
        return;
      }
      visaTypes = value;
    });
  }

  void selectActivity(String activity) {
    if (selectedActivities.contains(activity)) {
      selectedActivities.remove(activity);
    } else if (selectedActivities.length < 5) {
      selectedActivities.add(activity);
    }
    activitiesController.text = selectedActivities.join(', ');
  }

  void selectPlace(String place) {
    if (selectedPlaces.contains(place)) {
      selectedPlaces.remove(place);
    } else if (selectedPlaces.length < 5) {
      selectedPlaces.add(place);
    }
    placesController.text = selectedPlaces.join(', ');
  }
}
