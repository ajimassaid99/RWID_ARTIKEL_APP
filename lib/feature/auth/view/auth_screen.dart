import 'package:artikel_aplication/core/constant/colors.dart';
import 'package:artikel_aplication/core/extention/doubel_ext.dart';
import 'package:artikel_aplication/core/extention/string_ext.dart';
import 'package:artikel_aplication/core/widget/button_icon_widget.dart';
import 'package:artikel_aplication/core/widget/button_widget.dart';
import 'package:artikel_aplication/feature/auth/bloc/bloc/authentication_bloc.dart';
import 'package:artikel_aplication/feature/home/view/home.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  late AuthenticationBloc authBloc;
  final supabase = Supabase.instance.client;

  @override
  void initState() {
    authBloc = context.read<AuthenticationBloc>();
    supabase.auth.onAuthStateChange.listen((data) {
      if (data.session != null) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => const HomePage(),
          ),
          (route) => false,
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primary500,
          title: const Text(
            "Login",
            style: TextStyle(color: AppColors.white),
          ),
        ),
        body: BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state is SinginSuccess) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => const HomePage(),
                ),
                (route) => false,
              );
            }
            if (state is SinginFailed) {}
          },
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            FormButton(
              label: "Login",
              onPressed: () {
                "Anda Telah Login".failedBar(context);
              },
            ),
            20.0.height,
            FormButtonIcon(
              image: Image.asset("assets/icon/google.png"),
              label: "Dengan Google",
              backgroundColor: AppColors.grey300,
              textColor: AppColors.grey700,
              onPressed: () {
                _googleSignIn();
              },
            )
          ]),
        ));
  }

  _googleSignIn() async {
    const webClientId =
        '112205241964-epp7fap208orc9hc8bsnnsdniab2rqco.apps.googleusercontent.com';
    const iosClientId =
        '112205241964-m5ekcialps9vsikgcnh1vcsl8sjsv1h7.apps.googleusercontent.com';

    final GoogleSignIn googleSignIn = GoogleSignIn(
      clientId: iosClientId,
      serverClientId: webClientId,
    );
    final googleUser = await googleSignIn.signIn();
    final googleAuth = await googleUser!.authentication;
    final accessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;

    if (accessToken == null) {
      throw 'No Access Token found.';
    }
    if (idToken == null) {
      throw 'No ID Token found.';
    }

    authBloc.add(SingInWithGoogel(idToken: idToken, accessToken: accessToken));
  }
}
