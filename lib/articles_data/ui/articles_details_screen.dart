
import 'package:bloc_example/config/theme.dart';
import 'package:bloc_example/inherited_widget/inherited_data_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ArticlesDetailsScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),

      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          margin: EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              InheritedDataProvider.of(context).title != null ? titleAssign(InheritedDataProvider.of(context).title ):Container(),
              InheritedDataProvider.of(context).authorName != null ? authorAssign(InheritedDataProvider.of(context).authorName):Container(),
              InheritedDataProvider.of(context).imageUrl != null ? imageView(InheritedDataProvider.of(context).imageUrl):Container(),

            ],
          ),
        ),
      ),
    );
  }

  // Image Binding
  Widget imageView(String image){
    return Container(
      child: Image.network(image,key: Key('Image'),),
    );

  }

  // Title Assign
Widget titleAssign(String title){

  return Container(
    margin: const EdgeInsets.only(top: 8),
    alignment: Alignment.topLeft,
    child: Text(title,style: AppTheme.getThemeConfig().textTheme.headline2,key: Key('Title Text'),),
  );

}
  Widget authorAssign(String author){

    return Container(
      margin: const EdgeInsets.only(top: 8),
      alignment: Alignment.topLeft,
      child: Text(author,style: AppTheme.getThemeConfig().textTheme.headline2,key: Key('Title Text'),),
    );
  }
}