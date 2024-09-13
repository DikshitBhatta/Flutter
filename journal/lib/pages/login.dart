import 'package:flutter/material.dart';
import 'package:journal/services/authentication.dart';
import 'package:journal/blocs/login_bloc.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late LoginBloc _loginBloc;
  @override
  void initState() {
    super.initState();
    _loginBloc = LoginBloc(AuthenticationService());
  }

  void dispose() {
    _loginBloc.dispose();
    super.dispose();
  }

  Widget _buildLoginandCreateButtons() {
    return StreamBuilder(
        initialData: 'Login',
        stream: _loginBloc.loginOrCreateButton,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == 'Login') {
            return _buttonsLogin();
          } else if (snapshot.data == 'CreateAccount') {
            return _buttonsCreateAcount();
          }
          return Container();
        });
  }

  Widget _buttonsLogin() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        StreamBuilder(
          initialData: false,
          stream: _loginBloc.enableLoginCreateButton,
          builder: (BuildContext context, AsyncSnapshot snapshot) =>
              ElevatedButton(
                  child: Text('Login'),
                  style:
                      ButtonStyle(
                          elevation: WidgetStatePropertyAll(16.00),
                          backgroundColor:
                              WidgetStatePropertyAll(Colors.redAccent)),
                  onPressed: snapshot.data
                      ? () => _loginBloc.loginOrCreateChanged.add('Login')
                      : null),
        ),
        TextButton(
            onPressed: () {
              _loginBloc.loginOrCreateButtonChanged.add('Create Account');
            },
            child: Text('Create Account'))
      ],
    );
  }

  Widget _buttonsCreateAcount() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        StreamBuilder(
          initialData: false,
          stream: _loginBloc.enableLoginCreateButton,
          builder: (BuildContext context, AsyncSnapshot snapshot) =>
              ElevatedButton(
            onPressed: snapshot.data
                ? () =>
                    _loginBloc.loginOrCreateButtonChanged.add("Create Account")
                : null,
            child: Text('Create Account'),
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.redAccent),
              elevation: WidgetStatePropertyAll(16.00),
            ),
          ),
        ),
        TextButton(
            onPressed: () {
              _loginBloc.loginOrCreateButtonChanged.add('Login');
            },
            child: Text('Login'))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(40.00),
          child: Icon(
            Icons.account_circle,
            size: 88.00,
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        padding: EdgeInsets.all(16.00),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilder(
              stream: _loginBloc.email,
              builder: (BuildContext context, AsyncSnapshot snapshot) =>
                  TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    labelText: 'Email Address',
                    icon: Icon(Icons.mail_outline),
                    errorText: snapshot.error.toString()),
                onChanged: _loginBloc.emailChanged.add,
              ),
            ),
            Divider(),
            StreamBuilder(
              stream: _loginBloc.password,
              builder: (BuildContext context, AsyncSnapshot snapshot) =>
                  TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  icon: Icon(Icons.security),
                  errorText: '${_loginBloc.passwordChanged.add}',
                ),
                onChanged: _loginBloc.passwordChanged.add,
              ),
            ),
            Divider(),
            SizedBox(height: 48.00),
            _buildLoginandCreateButtons(),
          ],
        ),
      )),
    );
  }
}
