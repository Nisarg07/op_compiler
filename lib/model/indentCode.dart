class IndentCode {
  String code;
  IndentCode({this.code});
  factory IndentCode.fromJson(Map<String, dynamic> data) {
    return IndentCode(code: data['Edited']);
  }
}
