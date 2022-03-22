class ErrorMessge {
  final String _error;
  final String _errors;
  final String _error_description;
  final String _message;

  ErrorMessge(
      this._error, this._errors, this._error_description, this._message);

  String get message => _message;

  String get error_description => _error_description;

  String get errors => _errors;

  String get error => _error;
}