import 'package:flutter/material.dart';
import 'package:journal/pages/home.dart';
import 'package:journal/services/authentication.dart';
import 'package:journal/blocs/login_bloc.dart';

class Login extends StatefulWidget {
  const Login({super.key});

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

  @override
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
                  style:
                      const ButtonStyle(
                          elevation: WidgetStatePropertyAll(16.00),
                          backgroundColor:
                              WidgetStatePropertyAll(Colors.redAccent)),
                  onPressed: snapshot.data
                      ? () => _loginBloc.loginOrCreateChanged.add('Login')
                      : null,
                  child: Text('Login')),
        ),
        TextButton(
            onPressed: () {
              _loginBloc.loginOrCreateButtonChanged.add('Create Account');
            },
            child: const Text('Create Account'))
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
            style: const ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.redAccent),
              elevation: WidgetStatePropertyAll(16.00),
            ),
            child: Text('Create Account'),
          ),
        ),
        TextButton(
            onPressed: () {
              _loginBloc.loginOrCreateButtonChanged.add('Login');
            },
            child: const Text('Login')),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () async {
            String result = await _loginBloc.createAccount();
            if (result == 'success') {
              Navigator.push(
                context,
                MaterialPageRoute(
                    fullscreenDialog: true, builder: (context) => Home()),
              );
            } else {
              print(result);
            }
          },
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Colors.grey),
            elevation: WidgetStatePropertyAll(16.00),
          ),
          child: const Text('Submit'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: const PreferredSize(
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
        padding: const EdgeInsets.all(16.00),
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
                  icon: const Icon(Icons.mail_outline),
                  errorText:
                      snapshot.hasError ? snapshot.error.toString() : null,
                ),
                onChanged: (email) => _loginBloc.emailChanged.add(email),
              ),
            ),
            const Divider(),
            StreamBuilder(
              stream: _loginBloc.password,
              builder: (BuildContext context, AsyncSnapshot snapshot) =>
                  TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  icon: const Icon(Icons.security),
                  errorText:
                      snapshot.hasError ? snapshot.error.toString() : null,
                ),
                onChanged: (password) =>
                    _loginBloc.passwordChanged.add(password),
              ),
            ),
            const Divider(),
            const SizedBox(height: 48.00),
            _buildLoginandCreateButtons(),
          ],
        ),
      )),
    );
  }
}
