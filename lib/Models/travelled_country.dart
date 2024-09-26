class TravelledCountry {
  String country;
  DateTime entryDate;
  String purpose;
  String? attachment;

  TravelledCountry({
    required this.country,
    required this.entryDate,
    required this.purpose,
    this.attachment,
  });

  factory TravelledCountry.fromMap(Map<String, dynamic> map) {
    return TravelledCountry(
      country: map['country'] ?? '',
      entryDate: DateTime.parse(map['entryDate']),
      purpose: map['purpose'] ?? '',
      attachment: map['attachment'],
    );
  }

  // Converts the instance to a Map
  Map<String, dynamic> toMap() {
    return {
      'country': country,
      'entryDate': entryDate.toIso8601String(),
      'purpose': purpose,
      'attachmentPath': attachment,
    };
  }
}
