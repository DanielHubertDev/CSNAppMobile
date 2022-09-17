import 'package:csnapp/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';


const users = const {
  'lukongahubert@gmail.com': '00000',
};

class PageConnexion extends StatelessWidget {
  Duration get loginTime => Duration(milliseconds: 2250);

  Future<String?> _authUser(LoginData data) {
    debugPrint('Email: ${data.name}, Mot de passe: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(data.name)) {
        return "Cette Email n'exite pas";
      }
      if (users[data.name] != data.password) {
        return 'Mot de passe non compatible';
      }
      return null;
    });
  }

  Future<String?> _signupUser(SignupData data) {
    debugPrint('Email inscrit: ${data.name}, Mot de passe: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      return null;
    });
  }

  Future<String> _recoverPassword(String name) {
    debugPrint('Email: $name');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return "Cette Email n'exite pas";
      }
      return 'null';
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'CSN App',
      onLogin: _authUser,
      onSignup: _signupUser,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => Menu(),
        ));
      },
      onRecoverPassword: _recoverPassword,
      messages: LoginMessages(
        userHint: 'Mail utilisateur',
        passwordHint: 'Mot de passe',
        confirmPasswordHint: 'Confirmation mot de passe',
        loginButton: 'CONNECXION',
        signupButton: 'INSCRIPTION',
        forgotPasswordButton: 'Mot de passe oublié?',
        recoverPasswordButton: 'Envoyer',
        goBackButton: 'Retour',
        confirmPasswordError: 'Les deux mots de passe ne sont pas identiques!',
        recoverPasswordDescription: 'Un lien pour récupérer votre mot de passe va vous être envoyé par email.',
        recoverPasswordSuccess: 'Email de récupération du mot de passe envoyé.',
        recoverPasswordIntro: 'Récupérer votre mot de passe',
        recoveryCodeValidationError: 'Mail non valide',
      ),
    );
  }
}
