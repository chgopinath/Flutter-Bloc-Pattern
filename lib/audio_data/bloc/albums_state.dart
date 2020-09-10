import 'package:bloc_example/audio_data/models/albums_response.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class AlbumsState extends Equatable {

  const AlbumsState();
  @override
  List<Object> get props => [];
}


class AlbumsInitialState extends AlbumsState {}

class AlbumsLoadingState extends AlbumsState {}

class AlbumsLoadedState extends AlbumsState {
  final List<Item> items;
  final int limit;
  final int offset;
  final int total;

  AlbumsLoadedState({@required this.items, @required this.limit, this.offset, this.total});

  @override
  List<Object> get props => [this.items, limit, offset, total];
}

class AlbumsEmptyState extends AlbumsState {}

class AlbumsErrorState extends AlbumsState {}
