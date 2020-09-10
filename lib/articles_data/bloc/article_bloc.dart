
import 'package:bloc/bloc.dart';
import 'package:bloc_example/articles_data/bloc/article_event.dart';
import 'package:bloc_example/articles_data/bloc/article_state.dart';
import 'package:bloc_example/articles_data/models/articles_response.dart';
import 'package:bloc_example/articles_data/repository/articles_repository.dart';




class ArticlesBloc extends Bloc<ArticlesEvent,ArticleState>{


 ArticlesBloc({ArticleState initialState}) : super(initialState);


  @override
  Stream<ArticleState> mapEventToState(ArticlesEvent event) async*{

    if(event is FetchArticlesEvent){
      print('Inside fetch event');
      yield* _mapFetchArticlesEventToState(event);
    }

  }

  Stream<ArticleState> _mapFetchArticlesEventToState(FetchArticlesEvent event) async* {
    try {
      yield ArticlesLoadingState();
       List<Articles> articles = await ArticlesRepository().getArticlesData();
       if(articles != null){
         if(articles.length > 0) {
           print('proceed adding to state');
           yield ArticleLoadedState(articles: articles);
         }else {
           print('items called on null or empty');
           yield ArticlesEmptyState();
         }
       }else{
         print('Article null');
       }

    }catch(err) {
      print('Error=> $err');
      yield ArticlesErrorState();
    }
  }

}