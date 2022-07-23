import 'package:flutter_test/flutter_test.dart';
import 'package:quit_smoking/loginScreen.dart';
import 'package:quit_smoking/signUpScreen.dart';

void main(){

  test('empty username', () {

    var result=usernameFieldValidator.validate('');
    expect(result,'Username must be filled');
  });

  test('incorrect username', () {

    var result=usernameFieldValidator.validate('123');
    expect(result,"Enter correct name");
  });

  test('correct username', () {

    var result=usernameFieldValidator.validate('David');
    expect(result,null);
  });

  test('empty email',(){
    var result=emailFieldValidator.validate('');
    expect(result,'Email must be filled');

  });

  test('non-empty but incorrect format',(){
    var result=emailFieldValidator.validate('aaa');
    expect(result,'Enter correct email');

  });

  test('correct email format',(){
    var result=emailFieldValidator.validate('david@gmail.com');
    expect(result,null);

  });

  test('empty password',(){
    var result=passwordFieldValidator.validate('');
    expect(result,'Password must be filled');

  });

  test('non-empty but incorrect format of password',(){
    var result=passwordFieldValidator.validate('123');
    expect(result,'Enter min. 8 characters');

  });

  test('correct format of password',(){
    var result=passwordFieldValidator.validate('12345678');
    expect(result,null);

  });
}