import 'dart:convert';

class Generation {
  DateTime from;
  DateTime to;
  List<GenerationType> generation;
  Generation({
    this.from,
    this.to,
    this.generation,
  });

  Map<String, dynamic> toMap() {
    return {
      'from': from?.millisecondsSinceEpoch,
      'to': to?.millisecondsSinceEpoch,
      'generation': generation?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory Generation.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Generation(
      from: DateTime.parse(map['from']),
      to: DateTime.parse(map['to']),
      generation: List<GenerationType>.from(
          map['generationmix']?.map((x) => GenerationType.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Generation.fromJson(String source) =>
      Generation.fromMap(json.decode(source));

  @override
  String toString() =>
      'Generation(from: $from, to: $to, generation: $generation)';
}

class GenerationType {
  String generationName;
  double generationPercentage;
  GenerationType({
    this.generationName,
    this.generationPercentage,
  });

  Map<String, dynamic> toMap() {
    return {
      'fuel': generationName,
      'perc': generationPercentage,
    };
  }

  factory GenerationType.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return GenerationType(
      generationName: map['fuel'],
      generationPercentage: map['perc']
          .toDouble(), // convert to double as some values are 0 (not 0.0)
    );
  }

  String toJson() => json.encode(toMap());

  factory GenerationType.fromJson(String source) =>
      GenerationType.fromMap(json.decode(source));

  @override
  String toString() =>
      'GenerationType(generationName: $generationName, generationPercentage: $generationPercentage)';
}
