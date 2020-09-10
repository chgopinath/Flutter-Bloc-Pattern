import 'package:bloc_example/articles_data/bloc/article_bloc.dart';
import 'package:bloc_example/articles_data/bloc/article_event.dart';
import 'package:bloc_example/articles_data/bloc/article_state.dart';
import 'package:bloc_example/articles_data/models/articles_response.dart';
import 'package:bloc_example/articles_data/ui/articles_details_screen.dart';
import 'package:bloc_example/inherited_widget/inherited_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArticlesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ArticlesView(),
    );
  }
}

class ArticlesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        'Articles',
        key: Key('Toolbar Text'),
      )),
      body: BlocProvider(
        create: (BuildContext context) =>
            ArticlesBloc()..add(FetchArticlesEvent()),
        child: ArticlesList(),
      ),
    );
  }
}

class ArticlesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ArticlesBloc, ArticleState>(builder: (context, state) {
        if (state is ArticlesLoadingState) {
          return _progressIndicator(context);
        }
        if (state is ArticlesEmptyState) {
          return _emptyText(context);
        }
        if (state is ArticlesErrorState) {
          return _errorText(context);
        }
        if (state is ArticleLoadedState) {
          return _dataLoadingState(state, context);
        }
        return _defaultState();
      }),
    );
  }

  // Progress Indicator
  _progressIndicator(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: CircularProgressIndicator(
              strokeWidth: 3,
              backgroundColor: Colors.orangeAccent,
              semanticsLabel: 'Loading...',
            ),
          ),
          Text(
            'Loading...',
            style: TextStyle(color: Colors.orangeAccent, fontSize: 16),
            key: Key('Loading Text'),
          ),
        ],
      ),
    );
  }

  // Empty Text
  _emptyText(BuildContext context) {
    return Center(
      child: Container(
        child: Text(
          'Empty...',
          key: Key('Empty Text'),
        ),
      ),
    );
  }

  // Error Text
  _errorText(BuildContext context) {
    return Center(
        child: Container(
      child: Text(
        'Error while fetching data...',
        key: Key('Error Text'),
      ),
    ));
  }

  // Default State
  _defaultState() {
    return Center(
        child: Container(
      child: Text(
        'Default state',
        key: Key('Default Text'),
      ),
    ));
  }

  // Data Loading
  _dataLoadingState(ArticleLoadedState state, BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
                key: Key('ListView'),
                shrinkWrap: true,
                itemCount: state.articles.length,
                itemBuilder: (context, index) {
                  Articles item = state.articles[index];
                  //List<Artist> _artists = state.items[index].artists;
                  return _showListItems(item, context);
                }),
          ),

        ],
      ),
    );
  }

  // Show List Items
  _showListItems(Articles articles, BuildContext context) {
    return Card(
      elevation: 4,
      child: Container(
        margin: const EdgeInsets.only(top: 8, bottom: 8),
        child: ListTile(
          leading: Hero(
            tag: articles.urlToImage,
            child: articles.urlToImage != null
                ? CircleAvatar(
                    key: Key('Article Image'),
                    radius: 30,
                    backgroundImage: NetworkImage(
                      '${articles.urlToImage}',
                    ),
                    backgroundColor: Colors.grey,
                  )
                : Container(),
          ),
          title: Text(
            articles.title,
            key: Key('Article Title'),
          ),
          subtitle: Text(articles.author, key: Key('Article Author')),
          onTap: () {
            print('${articles.title}');
            print('${articles.author}');
            print('${articles.urlToImage}');
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => InheritedDataProvider(
                  child: ArticlesDetailsScreen(),
                  title: articles.title,
                  authorName: articles.author,
                  imageUrl: articles.urlToImage,
                ),
              ),
            );

            //BlocProvider.of<ArticlesBloc>(context).add(ArticleNavigationEvent());
          },
        ),
      ),
    );
  }
}
