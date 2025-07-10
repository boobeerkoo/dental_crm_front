class Tooth {
  int id;
  int dentalFormulaId;
  String toothNumber;
  String toothName;
  String type;
  String damage;
  String parodont;
  String endo;
  String constructions;

  DateTime createdDate;
  DateTime updatedDate;

  Tooth({
    required this.id,
    required this.dentalFormulaId,
    required this.toothNumber,
    required this.toothName,
    required this.type,
    required this.damage,
    required this.parodont,
    required this.endo,
    required this.constructions,
    required this.createdDate,
    required this.updatedDate,
  });

  factory Tooth.fromJson(Map<String, dynamic> json) {
    return Tooth(
      id: json['id'],
      dentalFormulaId: json['dental_formula_id'],
      toothNumber: json['tooth_number'],
      toothName: json['tooth_name'],
      type: json['type'],
      damage: json['damage'],
      parodont: json['parodont'],
      endo: json['endo'],
      constructions: json['constructions'],
      createdDate: DateTime.parse(json['created_date']),
      updatedDate: DateTime.parse(json['updated_date']),
    );
  }
}

class Tooths {
  final List<Tooth> items;

  Tooths({required this.items});

  factory Tooths.fromJson(List<dynamic> json) {
    List<Tooth> appointments =
        json.map((data) => Tooth.fromJson(data)).toList();
    return Tooths(items: appointments);
  }
}
