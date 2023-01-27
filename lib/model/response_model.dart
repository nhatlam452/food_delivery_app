class ResponseModel{
  bool _isSuccess;
  String _msg;

  ResponseModel(this._isSuccess,  this._msg);
  String get msg => _msg;
  bool get isSuccess => _isSuccess;

}