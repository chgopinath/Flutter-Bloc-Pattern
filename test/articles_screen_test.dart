import 'package:bloc_example/articles_data/bloc/article_bloc.dart';
import 'package:bloc_example/articles_data/bloc/article_event.dart';
import 'package:bloc_example/articles_data/bloc/article_state.dart';
import 'package:bloc_example/articles_data/ui/articles_screen.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class ArticleBlocMock extends Mock implements ArticlesBloc {}

void main() {
  // ignore: close_sinks
  ArticlesBloc articlesBloc;

  setUp(() {
    articlesBloc = ArticleBlocMock();
  });

  Widget makeTestableWidget({Widget child}) {
    return BlocProvider.value(
      value: articlesBloc,
      child: MaterialApp(
        home: child,
      ),
    );
  }

  testWidgets('Loading State Widget', (WidgetTester tester) async {

    when(articlesBloc.state).thenAnswer((_) => ArticlesLoadingState());

    ArticlesList articlesScreen = ArticlesList();
    await tester.pumpWidget(makeTestableWidget(child: articlesScreen));

    final loadingText = find.byKey(Key('Loading Text'));
    expect(loadingText, findsOneWidget);
    tester.pump();

  });

  testWidgets('Empty State Widget', (WidgetTester tester) async {

    when(articlesBloc.state).thenAnswer((_) => ArticlesEmptyState());

    ArticlesList articlesScreen = ArticlesList();
    await tester.pumpWidget(makeTestableWidget(child: articlesScreen));

    final emptyText = find.byKey(Key('Empty Text'));
    expect(emptyText, findsOneWidget);
    tester.pump();
  });

  testWidgets('Error State Widget', (WidgetTester tester) async {

    when(articlesBloc.state).thenAnswer((_) => ArticlesErrorState());

    ArticlesList articlesScreen = ArticlesList();
    await tester.pumpWidget(makeTestableWidget(child: articlesScreen));

    final errorText = find.byKey(Key('Error Text'));
    expect(errorText, findsOneWidget);
    tester.pump();
  });

  testWidgets('Loaded State Widget', (WidgetTester tester) async {

    when(articlesBloc.state).thenAnswer((_) => ArticleLoadedState());

    ArticlesList articlesScreen = ArticlesList();

    await tester.pumpWidget(makeTestableWidget(child: articlesScreen));

    final articleTitle = find.byKey(Key('ListView'));
    expect(articleTitle, findsOneWidget);
    tester.pump();
  });
}
