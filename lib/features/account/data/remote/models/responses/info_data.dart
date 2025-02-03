class InfoData{
  String?  name;
  String? value;
  String? group;
  int? field_id;

  InfoData({this.name,this.value,this.field_id,this.group});
  factory InfoData.fromJson(Map<String, dynamic> json) {
    return InfoData(
      name:  json['name'],
      value:  json['value'],
      group:  json['group'],
      field_id:  json['field_id'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'group': group,
      'name':  name,
      'value':  value,
      'field_id':  field_id,
    };
  }
}
