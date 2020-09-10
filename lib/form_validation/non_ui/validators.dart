import 'dart:async';


class Validators {

  final validateEmail = StreamTransformer<String, String>.fromHandlers(
      handleData: (email, sink) {
        if (email.contains('@')) {
          sink.add(email);
        } else {
          sink.addError('Enter a valid email');
        }
      });

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
        if (password.length > 4) {
          sink.add(password);
        } else {
          sink.addError(
              'Invalid password, please enter more than 4 characters');
        }
      });

  String validEmail(String email) {
    if (email.contains('@')) {
      return email;
    } else {
      return '';
    }
  }

  String validPassword(String pass) {
    if (pass.length > 4) {
      return pass;
    } else {
      return '';
    }
  }
}
