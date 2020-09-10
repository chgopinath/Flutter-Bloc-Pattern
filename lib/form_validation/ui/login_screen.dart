import 'package:bloc_example/articles_data/ui/articles_screen.dart';
import 'package:bloc_example/audio_data/ui/albums_screen.dart';
import 'package:bloc_example/config/colors.dart';
import 'package:bloc_example/config/theme.dart';
import 'package:bloc_example/form_validation/non_ui/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class App extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Log Me In',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: LoginScreen(),
      ),
    );

  }

}

class LoginScreen extends StatelessWidget {

  goToAudioPage(BuildContext context) async{
    Navigator.push(context, MaterialPageRoute(builder: (_) => AlbumsScreen()));
  }

  goToNewsPage(BuildContext context) async{
    Navigator.push(context, MaterialPageRoute(builder: (_) => ArticlesScreen()));
  }

  @override
  Widget build(BuildContext context) {

    final bloc = Bloc();
    return Scaffold(
        appBar: AppBar(
          title: Text('Login Form'),
          backgroundColor: AppColors.colorPrimary,
        ),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            margin: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                welcomeText(),
                emailField(bloc),
                passwordField(bloc),
                submitButton(bloc),
              ],
            ),
          ),
        ),
      );

  }

  Widget welcomeText(){

    return Container(
      child: Text("Welcome",style: AppTheme.getThemeConfig().textTheme.headline1,),
    );

  }

  // Email Field Widget
  Widget emailField(Bloc bloc) {
    return Container(
      margin: EdgeInsets.only(top: 25.0),
      child: StreamBuilder<String>(
        stream: bloc.email,
        builder: (context, snapshot) {
          return TextField(
            key: Key('Email Field'),
            onChanged: bloc.changeEmail,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'ypu@example.com',
              labelText: 'Email Address',
              errorText: snapshot.error,
            ),
          );
        },
      ),
    );
  }

  // Password Field Widget
  Widget passwordField(Bloc bloc) {
    return Container(
      margin: EdgeInsets.only(top: 25.0),
      child: StreamBuilder<String>(
          stream: bloc.password,
          builder: (context, snapshot) {
            return TextField(
              key: Key('Password Field'),
              obscureText: true,
              onChanged: bloc.changePassword,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter Password',
                labelText: 'Password',
                errorText: snapshot.error,
              ),
            );
          }),
    );
  }

  // Submit Button
  Widget submitButton(Bloc bloc) {
    return Container(
      margin: EdgeInsets.only(top: 25.0),
      child: StreamBuilder<bool>(
        stream: bloc.submitValid,
        builder: (context, snapshot) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(left: 16, right: 16, top: 12),
                child: RaisedButton(
                  key: Key('Audio Button'),
                  shape:
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(44)),
                  child: Text(
                    'Audio Data',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  color: Colors.blue,
                  onPressed: snapshot.hasData ? () => goToAudioPage(context): null,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 16, right: 16, top: 12),
                child: RaisedButton(
                  key: Key('News Button'),
                  shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(44)),
                  child: Text(
                    'News Data',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  color: Colors.blue,
                  onPressed: snapshot.hasData ? () => goToNewsPage(context): null,
                ),
              )
            ],
          );
        },
      ),
    );
  }

}
