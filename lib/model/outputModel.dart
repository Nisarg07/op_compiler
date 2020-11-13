class OutPutModel {
  String output;
  String error;
  OutPutModel({this.output, this.error});
  factory OutPutModel.fromJson(Map<String, dynamic> data) {
    return OutPutModel(output: data['output'], error: data['error']);
  }
}
