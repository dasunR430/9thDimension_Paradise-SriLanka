import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Services/API/database.dart';

class VisaStateScreen extends StatefulWidget {
  const VisaStateScreen({Key? key}) : super(key: key);

  @override
  _VisaStateScreenState createState() => _VisaStateScreenState();
}

class _VisaStateScreenState extends State<VisaStateScreen> {
  Map<String, dynamic>? mainApplicant;
  List<Map<String, dynamic>> otherApplicants = [];
  List<dynamic> recommendations = [];
  int? entityId;

  @override
  void initState() {
    super.initState();
    _loadEntityIdAndFetchStatus();
  }

  Future<void> _loadEntityIdAndFetchStatus() async {
    final prefs = await SharedPreferences.getInstance();
    entityId = prefs.getInt('entityId');
    if (entityId != null) {
      await _fetchVisaStatus();
    } else {
      setState(() {
        mainApplicant = {
          'status': 'Error: Entity ID not found',
          'givenName': '',
          'surname': ''
        };
        otherApplicants = [];
        recommendations = [];
      });
    }
  }

  Future<void> _fetchVisaStatus() async {
    try {
      final applicantsData = await ParadiseDataBase.getVisaStatuses(entityId!);

      setState(() {
        if (applicantsData['MainApplicantStatus'] == "success") {
          mainApplicant = applicantsData['mainApplicant'];
        } else {
          mainApplicant = {
            'status': 'No data available for main applicant',
            'givenName': '',
            'surname': ''
          };
        }

        if (applicantsData['OtherApplicantsStatus'] == "success") {
          otherApplicants = List<Map<String, dynamic>>.from(
              applicantsData['otherApplicants']);
        } else {
          otherApplicants = [];
        }

        // Add handling for recommendations
        if (applicantsData['RecommedationsStatus'] == "success") {
          // Handle recommendations data here
          // For example:
          recommendations = applicantsData['recommedations'];
        } else {
          // Handle case when no recommendations are available
          // For example:
          recommendations = [];
        }
      });
    } catch (e) {
      setState(() {
        mainApplicant = {
          'status': 'Error fetching visa status: $e',
          'givenName': '',
          'surname': ''
        };
        otherApplicants = [];
        // Reset recommendations if needed
        recommendations = [];
      });
    }
  }

  Widget _buildApplicantInfo(Map<String, dynamic> applicant) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
          BoxShadow(
            color: Colors.blue.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.person, color: Colors.white),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    '${(applicant['givenName'] + ' ' + applicant['surname']).length > 25 ? (applicant['givenName'] + ' ' + applicant['surname']).substring(0, 22) + '...' : applicant['givenName'] + ' ' + applicant['surname']}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                _buildStatusIcon(applicant['status']),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Status: ${applicant['status']}',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusIcon(String status) {
    IconData iconData;
    Color iconColor;

    switch (status.toLowerCase()) {
      case 'approved':
        iconData = Icons.check_circle;
        iconColor = Colors.green;
        break;
      case 'pending':
        iconData = Icons.hourglass_empty;
        iconColor = Colors.orange;
        break;
      case 'rejected':
        iconData = Icons.cancel;
        iconColor = Colors.red;
        break;
      default:
        iconData = Icons.info;
        iconColor = Colors.blue;
    }

    return Icon(iconData, color: iconColor, size: 28);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Visa Status'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Main Applicant',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(height: 16),
                  mainApplicant != null
                      ? _buildApplicantInfo(mainApplicant!)
                      : Center(
                      child:
                      CircularProgressIndicator(color: Colors.white)),
                  if (otherApplicants.isNotEmpty) ...[
                    SizedBox(height: 32),
                    Text(
                      'Other Applicants',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(height: 16),
                    ...otherApplicants
                        .map((applicant) => _buildApplicantInfo(applicant))
                        .toList(),
                  ],
                  SizedBox(height: 32),
                  Text(
                    'Recommendations',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(height: 16),
                  if (recommendations.isNotEmpty)
                    Column(
                      children: [
                        _buildRecommendationItem(recommendations),
                      ],
                    )
                  else
                    Center(
                      child: Text(
                        'No recommendations available',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                  SizedBox(height: 32),
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: _fetchVisaStatus,
                      icon: Icon(Icons.refresh),
                      label: Text('Refresh Status'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        padding:
                        EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                        textStyle: TextStyle(fontSize: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRecommendationItem(List<dynamic> recommendation) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recommended Places',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue),
            ),
            SizedBox(height: 12),
            ...recommendation
                .map((place) => Padding(
              padding: EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  Icon(Icons.place, color: Colors.green, size: 18),
                  SizedBox(width: 8),
                  Text(
                    place,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ))
                .toList(),
          ],
        ),
      ),
    );
  }
}
