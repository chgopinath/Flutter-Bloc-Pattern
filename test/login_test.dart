import 'package:bloc_example/form_validation_bloc/bloc/my_form_bloc.dart';
import 'package:bloc_example/form_validation_bloc/ui/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';



void main(){

  // ignore: close_sinks
  MyFormBloc myFormBloc;

  setUp(() {
    myFormBloc = MyFormBloc();
  });

  Widget makeTestableWidget({Widget child}){
    return MaterialApp(
      home: child,
    );
  }

  Widget makeBlocTestableWidget({Widget child}){
    return BlocProvider.value(
      value: myFormBloc,
      child: MaterialApp(
        home: child,
      ),
    );
  }


  // Email Field Widget Test
  testWidgets('Email Field Widget', (WidgetTester tester) async {

    MyForm emailInput = MyForm();

    await tester.pumpWidget(makeBlocTestableWidget(child: emailInput));

    final emailFinder = find.byKey(Key('Email Field'));
    expect(emailFinder, findsOneWidget);
    await tester.enterText(find.byKey(Key('Email Field')), 'hi@gmail.com');
    expect(find.text('hi@gmail.com'), findsOneWidget);

    await tester.pump();

  });

  // Password Filed Widget Test
  testWidgets('Password Field Widget', (WidgetTester tester) async {

    MyForm passwordInput = MyForm();

    await tester.pumpWidget(makeBlocTestableWidget(child: passwordInput));

    final passwordFinder = find.byKey(Key('Password Field'));
    expect(passwordFinder, findsOneWidget);
    await tester.enterText(find.byKey(Key('Password Field')), 'abcdef123');
    expect(find.text('abcdef123'), findsOneWidget);

    await tester.pump();

  });

  // Submit Button Widget Test
  testWidgets('Submit Button Widget', (WidgetTester tester) async {

    MyForm submitInput = MyForm();

    await tester.pumpWidget(makeBlocTestableWidget(child: submitInput));

    final submitButton = find.byKey(Key('Submit Button'));
    expect(submitButton, findsOneWidget);
    await tester.tap(submitButton);

    await tester.pump();

  });

  // Dialog Button Widget Test
  testWidgets('Dialog Buttons Widget test', (WidgetTester tester) async {

    SuccessDialog successDialog = SuccessDialog();

    await tester.pumpWidget(makeTestableWidget(child: successDialog));

    final buttonAudio = find.byKey(Key('Audio Button'));
    expect(buttonAudio, findsOneWidget);
    await tester.tap(buttonAudio);

    final buttonNews = find.byKey(Key('News Button'));
    expect(buttonNews, findsOneWidget);
    await tester.tap(buttonNews);

    final formSubmitText = find.byKey(Key('Form Submit'));
    expect(formSubmitText, findsOneWidget);


    await tester.pump();

  });



 /* testWidgets('Login Widget test', (WidgetTester tester) async {

    LoginScreen loginScreen = LoginScreen();

    await tester.pumpWidget(makeTestableWidget(child: loginScreen));

    final emailErrorFinder = find.byKey(Key('Email Field'));
    expect(emailErrorFinder, findsOneWidget);
    await tester.enterText(find.byKey(Key('Email Field')), 'hi@gmail.com');
    expect(find.text('hi@gmail.com'), findsOneWidget);


    final passwordErrorFinder = find.byKey(Key('Password Field'));
    expect(passwordErrorFinder, findsOneWidget);
    await tester.enterText(find.byKey(Key('Password Field')), 'hello');
    expect(find.text('hello'), findsOneWidget);


    final buttonAudio = find.byKey(Key('Audio Button'));
    expect(buttonAudio, findsOneWidget);
    await tester.tap(buttonAudio);

    final buttonNews = find.byKey(Key('News Button'));
    expect(buttonNews, findsOneWidget);
    await tester.tap(buttonNews);

    await tester.pump();

  });*/


}

