
import 'package:bloc_example/articles_data/models/articles_response.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class ArticleState extends Equatable{
  const ArticleState();
  @override
  List<Object> get props => [];
}

class ArticlesInitialState extends ArticleState {}

class ArticlesLoadingState extends ArticleState {}

class ArticleLoadedState extends ArticleState {

  final List<Articles> articles;

  ArticleLoadedState({@required this.articles});

  @override
  List<Object> get props => [this.articles];

}

class ArticlesEmptyState extends ArticleState {}

class ArticlesErrorState extends ArticleState {}


