import 'get_field_model.dart';

class RequestGroupField {
  late List<String> groups;
  late Map<String, List<GroupedField>> groupedFields;
  late List<InfoData> info;

  RequestGroupField({
    required this.groups,
    required this.groupedFields,
    required this.info,
  });

  // From JSON
    RequestGroupField.fromJson(Map<String, dynamic> json) {
try {
  groups = List<String>.from(json['groups']);
  groupedFields = (json['groupedFields'] as Map<String, dynamic>).map(
        (key, value) =>
        MapEntry(
          key,
          List<GroupedField>.from(
            (value as List).map((e) => GroupedField.fromJson(e)),
          ),
        ),

  );
  info = <InfoData>[];

  if (json['info'] != null) {

    json['info'].forEach((v) {
      info!.add(new InfoData.fromJson(v));
    });
  }

  for (int i = 0; i < groups.length; i++) {
    groupedFields[groups[i]]!.sort((a, b) {
      if (a.country == "الكل" && b.country == "الكل") {
        return 0; // Both are "الكل", keep them as is
      } else if (a.country == "الكل") {
        return -1; // "الكل" comes first
      } else if (b.country == "الكل") {
        return 1; // "الكل" comes first
      } else {
        // Sort alphabetically for the rest
        return a.country!.compareTo(b.country!);
      }
    });
  }
} on Exception catch(e){
  print(e);
      }
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'groups': groups,
      'info': info,
      'groupedFields': groupedFields.map(
            (key, value) => MapEntry(
          key,
          value.map((e) => e.toJson()).toList(),
        ),
      ),
    };
  }
}
