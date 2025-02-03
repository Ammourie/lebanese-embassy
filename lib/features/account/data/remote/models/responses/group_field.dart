class GroupedField {
  final int id;
  final dynamic country;
  final String description;
  final String name;
  final String group;
  final String type;
  final String? options;
  final List<String>? optionsList;
  final int required;
  final int status;
  final String createdAt;
  final String updatedAt;
  final String values;

  GroupedField({
    required this.id,
    this.country,
    required this.description,
    required this.name,
    required this.group,
    required this.type,
    required this.optionsList,
    this.options,
    required this.required,
    required this.status,
    required this.values,
    required this.createdAt,
    required this.updatedAt,
  });

  // From JSON
  factory GroupedField.fromJson(Map<String, dynamic> json) {
    return GroupedField(
      id: json['id'],
      country: json['country'],
      description: json['description'],
      name: json['name'],
      group: json['group'],
      type: json['type'],
      options: json['options'],
      optionsList: json['options']!=null?json['options'].toString().split('،'):[],
      required: json['required'],
      status: json['status'],
      values: json['values'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'country': country,
      'description': description,
      'name': name,
      'group': group,
      'type': type,
      'options': options,
      'required': required,
      'status': status,
      'created_at': createdAt,
      'values': values,
      'updated_at': updatedAt,
    };
  }
}
