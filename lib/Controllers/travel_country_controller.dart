import 'package:get/get.dart';

import '../Models/travelled_country.dart';

class TravelledCountryController extends GetxController {
  // List to store all travel history entries
  var travelledCountryList = <TravelledCountry>[].obs;

  // Method to add a new entry to the list
  void addTravelledCountry(TravelledCountry travelledCountry) {
    travelledCountryList.add(travelledCountry);
  }

  // Method to remove an entry from the list
  void removeTravelledCountry(int index) {
    travelledCountryList.removeAt(index);
  }
}
