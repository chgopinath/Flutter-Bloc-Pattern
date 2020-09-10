import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class AlbumsEvent extends Equatable {}

class FetchAlbumsEvent extends AlbumsEvent {
  final int initialLimit;

  FetchAlbumsEvent({@required this.initialLimit});

  @override
  List<Object> get props => [initialLimit];
}

class FetchMoreEvent extends AlbumsEvent {
  final int limit;
  final int total;

  FetchMoreEvent({@required this.limit, @required this.total});

  @override
  List<Object> get props => [limit, total];
}
