import 'package:bloc_example/articles_data/bloc/article_bloc.dart';
import 'package:bloc_example/articles_data/bloc/article_event.dart';
import 'package:bloc_example/articles_data/bloc/article_state.dart';
import 'package:bloc_example/articles_data/ui/articles_screen.dart';
import 'package:bloc_example/audio_data/bloc/albums_bloc.dart';
import 'package:bloc_example/audio_data/bloc/albums_state.dart';
import 'package:bloc_example/audio_data/ui/albums_screen.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class AlbumsBlocMock extends Mock implements AlbumsBloc {}

void main() {
  // ignore: close_sinks
  AlbumsBloc albumsBloc;

  setUp(() {
    albumsBloc = AlbumsBlocMock();
  });

  Widget makeBlocTestableWidget({Widget child}) {
    return BlocProvider.value(
      value: albumsBloc,
      child: MaterialApp(
        home: child,
      ),
    );
  }

  Widget makeTestableWidget({Widget child}){
    return MaterialApp(
      home: child,
    );
  }

  testWidgets('Loading State Widget', (WidgetTester tester) async {

    when(albumsBloc.state).thenAnswer((_) => AlbumsLoadingState());

    AlbumsList albumsListScreen = AlbumsList();
    await tester.pumpWidget(makeBlocTestableWidget(child: albumsListScreen));

    final loadingText = find.byKey(Key('Loading Text'));
    expect(loadingText, findsOneWidget);
    tester.pump();

  });

  testWidgets('Empty State Widget', (WidgetTester tester) async {

    when(albumsBloc.state).thenAnswer((_) => AlbumsEmptyState());

    AlbumsList albumsListScreen = AlbumsList();
    await tester.pumpWidget(makeBlocTestableWidget(child: albumsListScreen));

    final emptyText = find.byKey(Key('Empty Text'));
    expect(emptyText, findsOneWidget);
    tester.pump();
  });

  testWidgets('Error State Widget', (WidgetTester tester) async {

    when(albumsBloc.state).thenAnswer((_) => AlbumsErrorState());

    AlbumsList albumsListScreen = AlbumsList();
    await tester.pumpWidget(makeBlocTestableWidget(child: albumsListScreen));

    final errorText = find.byKey(Key('Error Text'));
    expect(errorText, findsOneWidget);
    tester.pump();
  });

  // Floating Button Widget Test
  testWidgets('Floating Button Widget', (WidgetTester tester) async {

    when(albumsBloc.state).thenAnswer((_) => AlbumsLoadedState());

    AlbumsList albumsListScreen = AlbumsList();

    await tester.pumpWidget(makeBlocTestableWidget(child: albumsListScreen));

    final submitButton = find.byKey(Key('Floating Button'));
    expect(submitButton, findsOneWidget);
    await tester.tap(submitButton);

    /*final snackBar = find.byKey(Key('SnackBar'));
    expect(snackBar, findsOneWidget);*/


    await tester.pump();

  });

  testWidgets('Loaded State Widget', (WidgetTester tester) async {

    when(albumsBloc.state).thenAnswer((_) => AlbumsLoadedState());

    AlbumsList albumsListScreen = AlbumsList();

    await tester.pumpWidget(makeBlocTestableWidget(child: albumsListScreen));

    final articleTitle = find.byKey(Key('ListView'));
    expect(articleTitle, findsOneWidget);
    tester.pump();
  });
}
