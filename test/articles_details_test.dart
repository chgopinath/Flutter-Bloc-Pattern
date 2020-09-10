

import 'package:bloc_example/articles_data/ui/articles_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){

  Widget makeTestableWidget({Widget child}){
    return MaterialApp(
      home: child,
    );
  }

  testWidgets('Articles Details Widget test', (WidgetTester tester) async {

    ArticlesDetailsScreen articlesDetailsScreen = ArticlesDetailsScreen();

    await tester.pumpWidget(makeTestableWidget(child: articlesDetailsScreen));

    final titleText = find.byKey(Key('Title Text'));
    expect(titleText, findsOneWidget);
    //await tester.enterText(find.byKey(Key('Title Text')), 'hi@gmail.com');
    //expect(find.text('hi@gmail.com'), findsOneWidget);


    await tester.pump();

  });

}