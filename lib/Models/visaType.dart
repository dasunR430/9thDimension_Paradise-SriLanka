class VisaType{
  String visaId, title;
  String? description, entryType, period, extensionDetails;
  int duration;
  int? multiEntryLimitDays;
  double? visaFee;

  VisaType.basicDetails({
    required this.visaId,
    required this.title,
    required this.duration
  });

  VisaType.allDetails({
    required this.visaId,
    required this.title,
    required this.description,
    required this.entryType,
    required this.period,
    required this.extensionDetails,
    required this.duration,
    required this.multiEntryLimitDays,
    required this.visaFee
  });

}