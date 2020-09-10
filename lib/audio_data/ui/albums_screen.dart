import 'package:bloc_example/articles_data/ui/articles_details_screen.dart';
import 'package:bloc_example/audio_data/bloc/albums_bloc.dart';
import 'package:bloc_example/audio_data/bloc/albums_event.dart';
import 'package:bloc_example/audio_data/bloc/albums_state.dart';
import 'package:bloc_example/audio_data/models/albums_response.dart';
import 'package:bloc_example/inherited_widget/inherited_data_provider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AlbumsScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AlbumsView(),
    );
  }
}

class AlbumsView extends StatelessWidget{
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
        AlbumsBloc()..add(FetchAlbumsEvent(initialLimit: 3)),
        child: AlbumsList(),
      ),
    );
  }

}

class AlbumsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AlbumsBloc, AlbumsState>(builder: (context, state) {
        if (state is AlbumsLoadingState) {
          return _progressIndicator();
        }
        if (state is AlbumsEmptyState) {
          return _emptyText();
        }
        if (state is AlbumsErrorState) {
          return _errorText();
        }
        if (state is AlbumsLoadedState) {
          return _dataLoadingState(state,context);
        }
        return _defaultState();
      }),
    );
  }


  // Progress Indicator
  _progressIndicator(){
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

          Text('Loading...', style: TextStyle(color: Colors.orangeAccent, fontSize: 16),key: Key('Loading Text')),
        ],
      ),
    );
  }

  // Empty Text
 _emptyText(){
    return Center(
        child: Container(
          child: Text('Empty...',key: Key('Empty Text'),),
        ));
 }

 // Error Text
 _errorText(){
    return Center(
        child: Container(
          child: Text('Error while fetching data...',key: Key('Error Text'),),
        ));
 }

 // Default State
  _defaultState(){
    return Center(
        child: Container(
          child: Text('Default state',key: Key('Default Text'),),
        ));
 }

 // Data Loading
  _dataLoadingState(AlbumsLoadedState state,BuildContext context){
    return Scaffold(
      floatingActionButton: ConditionalBuilder(
        key: Key('Floating Button'),
        condition: state.total > state.limit,
        builder: (context) {
          print('Total: ${state.total} && Limit: ${state.limit}');
          return _floatingButton(context,state);
        },
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: state.items.length,
                itemBuilder: (context, index) {
                  Item item = state.items[index];
                  //List<Artist> _artists = state.items[index].artists;
                  return _showListItems(item,context);
                }),
          ),
        ],
      ),
    );
  }

  // Floating Button
  _floatingButton(BuildContext context,AlbumsLoadedState state){
    return RaisedButton(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6)),
      color: Colors.blue,
      onPressed: () {
        print(
            'On Pressed Total: ${state.total} && Limit: ${state.limit}');
        BlocProvider.of<AlbumsBloc>(context).add(FetchMoreEvent(
            limit: state.limit + 3, total: state.total));
      },
      child: Text(
        'Load More',
        style: TextStyle(color: Colors.white),
      ),
    );
 }

 // Show List Items
 _showListItems(Item item,BuildContext context){
    return InkWell(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => InheritedDataProvider(
              child: ArticlesDetailsScreen(), title: item.name,authorName: item.uri),),
        );

      },
      child: Card(
        elevation: 4,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(
                  horizontal: 16, vertical: 8),
              child: Text(
                '${item.name}',
                style: TextStyle(
                    color: Colors.green, fontSize: 16),
              ),
            ),
            ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: item.artists.length != null &&
                    item.artists.length > 0
                    ? item.artists.length
                    : 0,
                itemBuilder: (context, position) {
                  Artist artist = item.artists[position];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.symmetric(
                        vertical: 4, horizontal: 16),
                    child: Text('${artist.name}'),
                  );
                })
          ],
        ),
      ),
    );
 }
}
