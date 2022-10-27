class PasswordFormEvent {
  String? password;
  bool hidden = true;

  PasswordFormEvent(this.password, [bool? hidden]) {
    this.hidden = hidden ?? true;
  }
}