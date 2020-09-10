
import 'package:equatable/equatable.dart';

abstract class ArticlesEvent extends Equatable {}

class FetchArticlesEvent extends ArticlesEvent{
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

}

