
import 'package:flutter/cupertino.dart';

class InheritedDataProvider extends InheritedWidget{

  final String title;
  final String authorName;
  final String imageUrl;

  InheritedDataProvider({
    Widget child,
    this.title,
    this.imageUrl,
    this.authorName
  }):super(child: child);

  @override
  bool updateShouldNotify(InheritedDataProvider oldWidget) =>  true;
  static InheritedDataProvider of(BuildContext context) =>  context.dependOnInheritedWidgetOfExactType<InheritedDataProvider>();
}
