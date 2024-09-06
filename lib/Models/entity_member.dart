import 'package:paradise_sri_lanka/Models/visa_applicant.dart';

class EntityMember{
  VisaApplicant applicant;
  String relation;

  EntityMember({required this.applicant, required this.relation});

  Map<String, dynamic> toMap(){
    return {
      'applicant': applicant.toMap(),
      'relation': relation
    };
  }

  static fromMap(Map<String, dynamic> map){
    return EntityMember(
      applicant: VisaApplicant.fromMap(map['applicant']),
      relation: map['relation']
    );
  }
}