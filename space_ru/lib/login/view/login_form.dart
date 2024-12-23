import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:space_ru/login/bloc/login_bloc.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Authentication Failure')),
            );
        }
      },
      child: Align(
        alignment: const Alignment(1000, -10 / 3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _showLogo(),
            const Padding(padding: EdgeInsets.all(12)),
            _showLogoText(),
            const Padding(padding: EdgeInsets.all(12)),
            _UsernameInput(),
            const Padding(padding: EdgeInsets.all(12)),
            _PasswordInput(),
            const Padding(padding: EdgeInsets.all(12)),
            _LoginButton(),
            const Padding(padding: EdgeInsets.all(12)),
          ],
        ),
      ),
    );
  }
}

class _UsernameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final displayError = context.select(
      (LoginBloc bloc) => bloc.state.username.displayError,
    );

    return TextField(
      key: const Key('loginForm_usernameInput_textField'),
      autofocus: true,
      onChanged: (username) {
        context.read<LoginBloc>().add(LoginUsernameChanged(username));
      },
      decoration: InputDecoration(
        icon: Icon(
          Icons.mail,
          color: Colors.purple.shade300,
        ),
        labelText: 'username',
        errorText: displayError != null ? 'invalid username' : null,
      ),
    );
  }
}

Widget _showLogo() {
  return Hero(
      tag: 'hero',
      child: Padding(
        padding: const EdgeInsets.only(top: 160.0),
        child: Center(
          child: Container(
              width: 120,
              height: 90,
              child: Image.asset('lib/assets/launch.png')),
        ),
      ));
}

Widget _showLogoText() {
  return Text(
    overflow: TextOverflow.fade,
    maxLines: 1,
    style: TextStyle(color: Colors.grey.shade600, fontSize: 25),
    'Sloggers',
  );
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final displayError = context.select(
      (LoginBloc bloc) => bloc.state.password.displayError,
    );

    return TextField(
      key: const Key('loginForm_passwordInput_textField'),
      onChanged: (password) {
        context.read<LoginBloc>().add(LoginPasswordChanged(password));
      },
      obscureText: true,
      decoration: InputDecoration(
        icon: Icon(
          Icons.key,
          color: Colors.purple.shade300,
        ),
        labelText: 'password',
        errorText: displayError != null ? 'invalid password' : null,
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isInProgressOrSuccess = context.select(
      (LoginBloc bloc) => bloc.state.status.isInProgressOrSuccess,
    );

    if (isInProgressOrSuccess) return const CircularProgressIndicator();

    final isValid = context.select((LoginBloc bloc) => bloc.state.isValid);

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black54,
          backgroundColor: Colors.purple.shade50,
          minimumSize: const Size(400, 48)),
      key: const Key('loginForm_continue_raisedButton'),
      onPressed: isValid
          ? () => context.read<LoginBloc>().add(const LoginSubmitted())
          : null,
      child: const Text('Войти'),
    );
  }
}
