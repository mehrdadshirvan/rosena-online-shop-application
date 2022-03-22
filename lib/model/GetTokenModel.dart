class TokenGet {
  final String _token_type;
  final int _expires_in;
  final String _access_token;
  final String _refresh_token;

  TokenGet(this._token_type, this._expires_in, this._access_token,
      this._refresh_token);

  String get refresh_token => _refresh_token;

  String get access_token => _access_token;

  int get expires_in => _expires_in;

  String get token_type => _token_type;
}