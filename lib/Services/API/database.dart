import 'package:paradise_sri_lanka/Models/visaType.dart';

class ParadiseDataBase {
  static const String _baseurl = 'http://10.10.13.11:3000/api/data';

  static List<VisaType> _visaTypes = [];

  static Future<List<VisaType>?> get visaTypes async {
    if (_visaTypes.isNotEmpty) {
      return _visaTypes;
    } else {
      await _getVisaTypes();
      if (_visaTypes.isNotEmpty) return _visaTypes;
    }
    return null;
  }

  static Future<void> _getVisaTypes() async {
    //TODO: Fetch data from the server
    _visaTypes = [
      VisaType.basicDetails(
        visaId: 'tourist_30',
        title: 'Tourist Visa – 30 Days',
        duration: 30,
      ),
      VisaType.basicDetails(
        visaId: 'visitor_6m',
        title: 'Tourist Visa – Standard Visitor Visa',
        duration: 60,
      ),
      VisaType.basicDetails(
        visaId: 'multi_1y',
        title: 'Tourist Visa – One Year Multiple Entry Visa',
        duration: 90,
      ),
      VisaType.basicDetails(
        visaId: 'multi_2y',
        title: 'Tourist Visa – Two Years Multiple Entry Visa',
        duration: 180,
      ),
      VisaType.basicDetails(
        visaId: 'multi_5y',
        title: 'Tourist Visa – Five Years Multiple Entry Visa',
        duration: 180,
      ),
      VisaType.basicDetails(
        visaId: 'multi_10y',
        title: 'Tourist Visa – Ten Years Multiple Entry Visa',
        duration: 180,
      ),
      VisaType.basicDetails(
        visaId: 'free_30',
        title: 'Tourist Visa – Free Visa',
        duration: 30,
      )
    ];
  }

  static VisaType getVisaType(String id) {
    try {
      return _visaTypes.firstWhere((element) => element.visaId == id);
    } catch (e) {
      // Return a default VisaType or throw a custom exception
      return VisaType.basicDetails(
        visaId: 'default',
        title: 'Default Visa',
        duration: 0,
      );
    }
  }
}
