import 'package:bloc/bloc.dart';
import 'package:bloc_example/audio_data/bloc/albums_event.dart';
import 'package:bloc_example/audio_data/bloc/albums_state.dart';
import 'package:bloc_example/audio_data/models/albums_response.dart';
import 'package:bloc_example/audio_data/repository/album_repository.dart';



class AlbumsBloc extends Bloc<AlbumsEvent, AlbumsState> {

  AlbumsBloc({AlbumsState initialState}) : super(initialState);


  //Here we can pass a repository
//  AlbumsBloc() : super(AlbumsLoadingState());

  @override
  Stream<AlbumsState> mapEventToState(AlbumsEvent event) async* {
    if(event is FetchAlbumsEvent) {
      print('Inside fetch event');
      yield* _mapFetchAlbumsEventToState(event);
    }if(event is FetchMoreEvent) {
      print('Inside fetch more event');
      print('Next limit: ${event.limit}');
      yield* _mapFetchMoreEventToState(event);
    }
  }


  Stream<AlbumsState> _mapFetchAlbumsEventToState(FetchAlbumsEvent event) async* {
    try {
      yield AlbumsLoadingState();
      print('Event initial limit: ${event.initialLimit}');
      AlbumsResponse response = await AlbumRepository().getAlbums(limit: event.initialLimit);
      if(response.items.length > 0) {
        print('proceed adding to state');
        yield AlbumsLoadedState(items: response.items, limit: event.initialLimit, offset: response.offset, total: response.total);
      }else {
        print('items called on null or empty');
        yield AlbumsEmptyState();
      }
    }catch(err) {
      print('Error=> $err');
      yield AlbumsErrorState();
    }
  }

  Stream<AlbumsState> _mapFetchMoreEventToState(FetchMoreEvent event) async* {
    try {
      AlbumsResponse response = await AlbumRepository().getAlbums(limit: event.limit);

      if(response.items.length > 0) {
        print('proceed adding more data to state');
        print('dataaaaaaaaaaaa=> ${event.limit}');
        yield AlbumsLoadedState(items: response.items, limit: event.limit, total: event.total);
      } else {
        print('items called on null or empty');
        yield AlbumsEmptyState();
      }
      if(event.total == response.total) {
        //Here we can show toast message to user that they have reached max length (BotToast plugin)
        print('Max Reached');
      }

    }catch(err) {
      print('Error=> $err');
      yield AlbumsErrorState();
    }
  }

}