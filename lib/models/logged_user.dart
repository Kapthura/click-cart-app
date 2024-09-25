class LoggedUser {
  bool? _isLoggedIn;
  String? _displayName;
  String? _email;
  String? _photoURL;

  LoggedUser({
    bool? isLoggedIn,
    String? displayName,
    String? email,
    String? photoURL,
  }) {
    _isLoggedIn = isLoggedIn;
    _displayName = displayName;
    _email = email;
    _photoURL = photoURL;
  }

  // Convert class instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'isLoggedIn': _isLoggedIn,
      'displayName': _displayName,
      'email': _email,
      'photoURL': _photoURL,
    };
  }

  // Create class instance from JSON
  factory LoggedUser.fromJson(Map<String, dynamic> json) {
    return LoggedUser(
      isLoggedIn: json['isLoggedIn'] as bool? ?? false,
      displayName: json['displayName'] as String? ?? '',
      email: json['email'] as String? ?? '',
      photoURL: json['photoURL'] as String? ?? '',
    );
  }

  // Getter and setter for isLoggedIn
  bool? get isLoggedIn => _isLoggedIn;
  set isLoggedIn(bool? value) {
    _isLoggedIn = value;
  }

  // Getter and setter for displayName
  String? get displayName => _displayName;
  set displayName(String? value) {
    _displayName = value;
  }

  // Getter and setter for email
  String? get email => _email;
  set email(String? value) {
    _email = value;
  }

  // Getter and setter for photoURL
  String? get photoURL => _photoURL;
  set photoURL(String? value) {
    _photoURL = value;
  }
}
