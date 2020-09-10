import 'package:bloc_example/articles_data/ui/articles_screen.dart';
import 'package:bloc_example/audio_data/ui/albums_screen.dart';
import 'package:bloc_example/config/colors.dart';
import 'package:bloc_example/form_validation_bloc/bloc/my_form_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHome(),
    );
  }
}

class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: const Text('Login Form')),
      body: BlocProvider(
        create: (context) => MyFormBloc(),
        child: MyForm(),
      ),
    );
  }
}

class MyForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<MyFormBloc, MyFormState>(
        listener: (context, state) {
          if (state.status.isSubmissionSuccess) {
            Scaffold.of(context).hideCurrentSnackBar();
            showDialog<void>(
              barrierDismissible: true,
              context: context,
              builder: (_) => SuccessDialog(),
            );
          }
          if (state.status.isSubmissionInProgress) {
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(content: Text('Submitting...',key: Key('SnackBar'),)),
              );
          }
        },
        child: BlocBuilder<MyFormBloc, MyFormState>(builder: (context, state) {
          return SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              margin: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: TextFormField(
                      key: Key('Email Field'),
                      initialValue: state.email.value,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                        errorText: state.email.invalid ? 'Invalid Email' : null,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) {
                        context
                            .bloc<MyFormBloc>()
                            .add(EmailChanged(email: value));
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: TextFormField(
                      key: Key('Password Field'),
                      initialValue: state.password.value,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        errorText: state.password.invalid ? 'Invalid Password' : null,
                      ),
                      obscureText: true,
                      onChanged: (value) {
                        context
                            .bloc<MyFormBloc>()
                            .add(PasswordChanged(password: value));
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 12),
                    child: RaisedButton(
                      key: Key('Submit Button'),
                      color: AppColors.colorPrimary,
                      onPressed: state.status.isValidated
                          ? () => context.bloc<MyFormBloc>().add(FormSubmitted())
                          : null,
                      child: const Text('Submit'),
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0)),
                    ),
                  )
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

class SuccessDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 24, bottom: 24, left: 16),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    const Icon(Icons.verified_user),
                    const Flexible(
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Form Submitted Successfully!',
                          softWrap: true,key: Key('Form Submit'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 24, bottom: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    RaisedButton(
                      key: Key('Audio Button'),
                      child: const Text('Go To Albums'),
                      color: AppColors.colorPrimary,
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0)),
                      onPressed: () {
                       Navigator.of(context).pop();
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => AlbumsScreen()));
                      },
                    ),
                    RaisedButton(
                      key: Key('News Button'),
                      child: const Text('Go To Articles'),
                      color: AppColors.colorPrimary,
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0)),
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => ArticlesScreen()));
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
    );
  }
}
