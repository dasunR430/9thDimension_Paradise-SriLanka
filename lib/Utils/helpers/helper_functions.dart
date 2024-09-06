import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HelperFunctions {
  static Color? getColor(String value) {

    if (value == 'Green') {
      return Colors.green;
    } else if (value == 'Red') {
      return Colors.red;
    } else if (value == 'Blue') {
      return Colors.blue;
    } else if (value == 'Pink') {
      return Colors.pink;
    } else if (value == 'Grey') {
      return Colors.grey;
    } else if (value == 'Purple') {
      return Colors.purple;
    } else if (value == 'Black') {
      return Colors.black;
    } else if (value == 'White') {
      return Colors.white;
    } else if (value == 'Yellow') {
      return Colors.yellow;
    } else if (value == 'Orange') {
      return Colors.orange;
    } else if (value == 'Brown') {
      return Colors.brown;
    } else if (value == 'Teal') {
      return Colors.teal;
    } else if (value == 'Indigo') {
      return Colors.indigo;
    } else {
      return null;
    }
  }

  static void showSnackBar(String message) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  static void showOKAlert(String title, String message) {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
              ),
          ],
        );
      },
    );
  }

  static void showYesCancelAlert(String title, String message, String yesText, Color yesColor, Function() onYesPressed) {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                onYesPressed();
                Navigator.of(context).pop();
                },
              child: Text(yesText, style: TextStyle(color: yesColor, fontSize: 16)),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel', style: TextStyle(color: Colors.grey, fontSize: 16)),
            ),
          ],
        );
      },
    );
  }

  static void navigateToScreen(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  static String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return '${text.substring(0, maxLength)}...';
    }
  }

  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static Size screenSize() {
    return MediaQuery.of(Get.context!).size;
  }

  static double screenHeight() {
    return MediaQuery.of(Get.context!).size.height;
  }

  static double screenWidth() {
    return MediaQuery.of(Get.context!).size.width;
  }


  static List<T> removeDuplicates<T>(List<T> list) {
    return list.toSet().toList();
  }

  static List<Widget> wrapWidgets(List<Widget> widgets, int rowSize) {
    final wrappedList = <Widget>[];
    for (var i = 0; i < widgets.length; i += rowSize) {
      final rowChildren = widgets.sublist(i, i + rowSize > widgets.length ?  widgets.length : i + rowSize);
      wrappedList.add(Row(children: rowChildren));
    }
    return wrappedList;
  }

  static String isoToPassportCode(String isoCode) {
    final Map<String, String> isoToPassportMapping = {
      'AF': 'AFG', // Afghanistan
      'AL': 'ALB', // Albania
      'DZ': 'DZA', // Algeria
      'AD': 'AND', // Andorra
      'AO': 'AGO', // Angola
      'AG': 'ATG', // Antigua and Barbuda
      'AR': 'ARG', // Argentina
      'AM': 'ARM', // Armenia
      'AU': 'AUS', // Australia
      'AT': 'AUT', // Austria
      'AZ': 'AZE', // Azerbaijan
      'BS': 'BHS', // Bahamas
      'BH': 'BHR', // Bahrain
      'BD': 'BGD', // Bangladesh
      'BB': 'BRB', // Barbados
      'BY': 'BLR', // Belarus
      'BE': 'BEL', // Belgium
      'BZ': 'BLZ', // Belize
      'BJ': 'BEN', // Benin
      'BT': 'BTN', // Bhutan
      'BO': 'BOL', // Bolivia
      'BA': 'BIH', // Bosnia and Herzegovina
      'BW': 'BWA', // Botswana
      'BR': 'BRA', // Brazil
      'BN': 'BRN', // Brunei
      'BG': 'BGR', // Bulgaria
      'BF': 'BFA', // Burkina Faso
      'BI': 'BDI', // Burundi
      'KH': 'KHM', // Cambodia
      'CM': 'CMR', // Cameroon
      'CA': 'CAN', // Canada
      'CV': 'CPV', // Cape Verde
      'KY': 'CYM', // Cayman Islands
      'CF': 'CAF', // Central African Republic
      'TD': 'TCD', // Chad
      'CL': 'CHL', // Chile
      'CN': 'CHN', // China
      'CO': 'COL', // Colombia
      'KM': 'COM', // Comoros
      'CG': 'COG', // Congo (Congo-Brazzaville)
      'CD': 'COD', // Congo (Congo-Kinshasa)
      'CR': 'CRI', // Costa Rica
      'HR': 'HRV', // Croatia
      'CU': 'CUB', // Cuba
      'CY': 'CYP', // Cyprus
      'CZ': 'CZE', // Czechia
      'DK': 'DNK', // Denmark
      'DJ': 'DJI', // Djibouti
      'DM': 'DMA', // Dominica
      'DO': 'DOM', // Dominican Republic
      'EC': 'ECU', // Ecuador
      'EG': 'EGY', // Egypt
      'SV': 'SLV', // El Salvador
      'GQ': 'GNQ', // Equatorial Guinea
      'ER': 'ERI', // Eritrea
      'EE': 'EST', // Estonia
      'SZ': 'SWZ', // Eswatini
      'ET': 'ETH', // Ethiopia
      'FJ': 'FJI', // Fiji
      'FI': 'FIN', // Finland
      'FR': 'FRA', // France
      'GA': 'GAB', // Gabon
      'GM': 'GMB', // Gambia
      'GE': 'GEO', // Georgia
      'DE': 'DEU', // Germany
      'GH': 'GHA', // Ghana
      'GR': 'GRC', // Greece
      'GD': 'GRD', // Grenada
      'GT': 'GTM', // Guatemala
      'GN': 'GIN', // Guinea
      'GW': 'GNB', // Guinea-Bissau
      'GY': 'GUY', // Guyana
      'HT': 'HTI', // Haiti
      'HN': 'HND', // Honduras
      'HU': 'HUN', // Hungary
      'IS': 'ISL', // Iceland
      'IN': 'IND', // India
      'ID': 'IDN', // Indonesia
      'IR': 'IRN', // Iran
      'IQ': 'IRQ', // Iraq
      'IE': 'IRL', // Ireland
      'IL': 'ISR', // Israel
      'IT': 'ITA', // Italy
      'JM': 'JAM', // Jamaica
      'JP': 'JPN', // Japan
      'JO': 'JOR', // Jordan
      'KZ': 'KAZ', // Kazakhstan
      'KE': 'KEN', // Kenya
      'KI': 'KIR', // Kiribati
      'KR': 'KOR', // South Korea
      'KW': 'KWT', // Kuwait
      'KG': 'KGZ', // Kyrgyzstan
      'LA': 'LAO', // Laos
      'LV': 'LVA', // Latvia
      'LB': 'LBN', // Lebanon
      'LS': 'LSO', // Lesotho
      'LR': 'LBR', // Liberia
      'LY': 'LBY', // Libya
      'LI': 'LIE', // Liechtenstein
      'LT': 'LTU', // Lithuania
      'LU': 'LUX', // Luxembourg
      'MG': 'MDG', // Madagascar
      'MW': 'MWI', // Malawi
      'MY': 'MYS', // Malaysia
      'MV': 'MDV', // Maldives
      'ML': 'MLI', // Mali
      'MT': 'MLT', // Malta
      'MH': 'MHL', // Marshall Islands
      'MR': 'MRT', // Mauritania
      'MU': 'MUS', // Mauritius
      'MX': 'MEX', // Mexico
      'FM': 'FSM', // Micronesia
      'MD': 'MDA', // Moldova
      'MC': 'MCO', // Monaco
      'MN': 'MNG', // Mongolia
      'ME': 'MNE', // Montenegro
      'MA': 'MAR', // Morocco
      'MZ': 'MOZ', // Mozambique
      'MM': 'MMR', // Myanmar (Burma)
      'NA': 'NAM', // Namibia
      'NR': 'NRU', // Nauru
      'NP': 'NPL', // Nepal
      'NL': 'NLD', // Netherlands
      'NZ': 'NZL', // New Zealand
      'NI': 'NIC', // Nicaragua
      'NE': 'NER', // Niger
      'NG': 'NGA', // Nigeria
      'NU': 'NIU', // Niue
      'NF': 'NFK', // Norfolk Island
      'MP': 'MNP', // Northern Mariana Islands
      'NO': 'NOR', // Norway
      'OM': 'OMN', // Oman
      'PK': 'PAK', // Pakistan
      'PW': 'PLW', // Palau
      'PA': 'PAN', // Panama
      'PG': 'PNG', // Papua New Guinea
      'PY': 'PRY', // Paraguay
      'PE': 'PER', // Peru
      'PH': 'PHL', // Philippines
      'PN': 'PCN', // Pitcairn Islands
      'PL': 'POL', // Poland
      'PT': 'PRT', // Portugal
      'PR': 'PRI', // Puerto Rico
      'QA': 'QAT', // Qatar
      'RE': 'REU', // Réunion
      'RO': 'ROU', // Romania
      'RU': 'RUS', // Russia
      'RW': 'RWA', // Rwanda
      'WS': 'WSM', // Samoa
      'SM': 'SMR', // San Marino
      'ST': 'STP', // São Tomé and Príncipe
      'SA': 'SAU', // Saudi Arabia
      'SN': 'SEN', // Senegal
      'RS': 'SRB', // Serbia
      'SC': 'SYC', // Seychelles
      'SL': 'SLE', // Sierra Leone
      'SG': 'SGP', // Singapore
      'SX': 'SXM', // Sint Maarten
      'SK': 'SVK', // Slovakia
      'SI': 'SVN', // Slovenia
      'SB': 'SLB', // Solomon Islands
      'SO': 'SOM', // Somalia
      'ZA': 'ZAF', // South Africa
      'SS': 'SSD', // South Sudan
      'ES': 'ESP', // Spain
      'LK': 'LKA', // Sri Lanka
      'SD': 'SDN', // Sudan
      'SR': 'SUR', // Suriname
      'SZ': 'SWZ', // Eswatini
      'SE': 'SWE', // Sweden
      'CH': 'CHE', // Switzerland
      'SY': 'SYR', // Syria
      'TW': 'TWN', // Taiwan
      'TJ': 'TJK', // Tajikistan
      'TZ': 'TZA', // Tanzania
      'TH': 'THA', // Thailand
      'TL': 'TLS', // Timor-Leste
      'TG': 'TGO', // Togo
      'TK': 'TKL', // Tokelau
      'TO': 'TON', // Tonga
      'TT': 'TTO', // Trinidad and Tobago
      'TN': 'TUN', // Tunisia
      'TR': 'TUR', // Turkey
      'TM': 'TKM', // Turkmenistan
      'TV': 'TUV', // Tuvalu
      'UG': 'UGA', // Uganda
      'UA': 'UKR', // Ukraine
      'AE': 'ARE', // United Arab Emirates
      'GB': 'GBR', // United Kingdom
      'US': 'USA', // United States
      'UY': 'URY', // Uruguay
      'UZ': 'UZB', // Uzbekistan
      'VU': 'VUT', // Vanuatu
      'VE': 'VEN', // Venezuela
      'VN': 'VNM', // Vietnam
      'WF': 'WLF', // Wallis and Futuna
      'EH': 'ESH', // Western Sahara
      'YE': 'YEM', // Yemen
      'ZM': 'ZMB', // Zambia
      'ZW': 'ZWE', // Zimbabwe
    };

    return isoToPassportMapping[isoCode] ?? 'Unknown';
  }


}