import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'widgets/DotProgressIndicator.dart';
import '../../Services/connections.dart';
import 'widgets/MapMarkerWidget.dart';

class SummaryScreen extends StatelessWidget {
  final List<String> selectedCategories;
  final List<String> bucketList;
  final List<String> recommendations;
  final DateTime startDate;
  final DateTime endDate;
  final int duration;

  final Connections connectionService = Connections();

  SummaryScreen({
    super.key,
    required this.selectedCategories,
    required this.bucketList,
    required this.recommendations,
    required this.startDate,
    required this.endDate,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Travel Plan'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: connectionService.sendDataToBackend(selectedCategories,
            bucketList, recommendations, startDate, endDate, duration),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Hang tight as our AI team\ncurates your unforgettable\njourney!!!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  DotProgressIndicator(
                    totalDots: 4,
                    dotSize: 10,
                    activeColor: Colors.blue,
                    inactiveColor: Colors.grey.shade300,
                    animationDuration: const Duration(milliseconds: 300),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data != null) {
            final itinerary = snapshot.data!['itinerary'];
            final expandedLoc = snapshot.data!['expanded_loc'] as List<dynamic>;

            // Sort the keys based on the day number
            final sortedKeys = itinerary.keys.toList()
              ..sort((a, b) {
                final dayA = int.parse(a.split(' ')[1].replaceAll(':', ''));
                final dayB = int.parse(b.split(' ')[1].replaceAll(':', ''));
                return dayA.compareTo(dayB);
              });
            return ListView.builder(
              itemCount: sortedKeys.length + 2, // Add 2 for the map and buttons
              itemBuilder: (context, index) {
                if (index == 0) {
                  // Display the map at the top
                  return SizedBox(
                    height: 300, // Adjust the height as needed
                    child: MapMarkerWidget(expandedLoc: expandedLoc),
                  );
                } else if (index <= sortedKeys.length) {
                  String day = sortedKeys[index - 1];
                  Map<String, dynamic> details = itinerary[day];

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    child: Card(
                      elevation: 5,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: ExpansionTile(
                        title: Text(
                          day,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MarkdownBody(
                                  data: '**Description:**',
                                  styleSheet: MarkdownStyleSheet(
                                    p: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                MarkdownBody(
                                  data: details['Description'],
                                  styleSheet: MarkdownStyleSheet(
                                    p: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                MarkdownBody(
                                  data: '**Activities:**',
                                  styleSheet: MarkdownStyleSheet(
                                    p: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                ...details['Activities']
                                    .map<Widget>((activity) {
                                  return ListTile(
                                    leading:
                                        const Icon(Icons.check_circle_outline),
                                    title: MarkdownBody(
                                      data: '- $activity',
                                      styleSheet: MarkdownStyleSheet(
                                        p: const TextStyle(fontSize: 16),
                                      ),
                                    ),
                                    contentPadding: EdgeInsets.zero,
                                  );
                                }).toList(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  // Add buttons at the end of the ListView
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              // TODO: Implement save journey functionality
                              print('Save my journey');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Save my journey',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        MarkdownBody(
                          data: '**Need Accommodations?**',
                          styleSheet: MarkdownStyleSheet(
                            p: const TextStyle(fontSize: 16),
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                '/accommodation_selection',
                                arguments: expandedLoc,
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Get Accommodations',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  );
                }
              },
            );
          } else {
            return const Center(child: Text('No Plan available'));
          }
        },
      ),
    );
  }
}
