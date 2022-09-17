import 'package:graduation_project_draft/objects/medicine.dart';

class EForm {
  final String patientId;
  final String doctorId;
  DateTime? date;
  final String description;
  final String notes;
  final List<Medicine> prescription;

  EForm(
      {required this.description,
      required this.patientId,
      required this.doctorId,
      required this.notes,
      required this.prescription,
      required this.date}) {
    date ??= DateTime.now();
  }

  factory EForm.fromMap(Map<String, dynamic> map) {
    List<Medicine> medicines = [];
    map["prescription"].forEach((value) {
      medicines.add(Medicine.fromMap(value));
    });
    return EForm(
      patientId: map['patientId'],
      doctorId: map['doctorId'],
      date: map['date'].toDate(),
      description: map['description'],
      notes: map['notes'],
      prescription: medicines,
    );
  }
  Map<String, dynamic> toFirestore() {
    return {
      if (patientId != null) "patientId": patientId,
      if (doctorId != null) "doctorId": doctorId,
      if (date != null) "date": date,
      if (description != null) "description": description,
      if (notes != null) "notes": notes,
      if (prescription != null)
        "prescription": prescription.map((medicine) => medicine.toFirestore()),
    };
  }
}
