import 'package:artikel_aplication/core/constant/colors.dart';
import 'package:artikel_aplication/core/constant/size.dart';
import 'package:artikel_aplication/core/extention/doubel_ext.dart';
import 'package:artikel_aplication/core/extention/string_ext.dart';
import 'package:artikel_aplication/core/widget/button_icon_widget.dart';
import 'package:artikel_aplication/core/widget/button_widget.dart';
import 'package:artikel_aplication/core/widget/form_input__password_widget.dart';
import 'package:artikel_aplication/core/widget/form_input_widget.dart';
import 'package:artikel_aplication/feature/auth/bloc/bloc/authentication_bloc.dart';
import 'package:artikel_aplication/feature/home/bloc/tag_bloc.dart';
import 'package:artikel_aplication/feature/home/view/home.dart';
import 'package:artikel_aplication/feature/home/view/pilih_kategory.dart';
import 'package:artikel_aplication/feature/register/view/register_screen.dart';
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late AuthenticationBloc authBloc;
  final supabase = Supabase.instance.client;

  @override
  void initState() {
    authBloc = context.read<AuthenticationBloc>();
    supabase.auth.onAuthStateChange.listen((data) {
      if (data.session != null) {
        authBloc.add(const CekUserTag());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
        if (state is SinginSuccess) {
          authBloc.add(const CekUserTag());
        }
        if (state is TegUserExist) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => const MyHomePage(),
            ),
            (route) => false,
          );
        }
        if (state is TegUserNotExist) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => const PilihKelasScreen(),
            ),
            (route) => false,
          );
        }
      }, builder: (context, state) {
        if (state is SinginLoading) {
          return const CircularProgressIndicator();
        }

        return Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/image/logo.jpeg',
                        width: 300,
                        height: 300,
                      ),
                      FormInput(
                        controller: _emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email tidak boleh kosong';
                          } else if (!RegExp(
                                  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                              .hasMatch(value)) {
                            return 'Alamat email tidak valid';
                          }
                          return null;
                        },
                        label: "Email",
                        hint: "email",
                        icon: const Icon(Icons.email),
                      ),
                      20.0.height,
                      FormInputPassword(
                        controller: _passwordController,
                        // validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return 'Password tidak boleh kosong';
                        //   } else if (value.length < 6) {
                        //     return 'Password harus memiliki setidaknya 6 karakter';
                        //   }
                        //   return null;
                        // },
                        label: "Password",
                        hint: "password",
                      ),
                      20.0.height,
                      FormButton(
                        label: "Login",
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            context.read<AuthenticationBloc>().add(SignIn(
                                email: _emailController.text,
                                password: _passwordController.text));
                          }
                        },
                      ),
                      10.0.height,
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const RegisterPage()),
                            );
                          },
                          child: const Text(
                              "Belum Punya Akun? Register Sekarang")),
                      20.0.height,
                      const Row(
                        children: [
                          Expanded(
                            child: Divider(
                              thickness: 1,
                              color: AppColors.black,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Atau',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            child:
                                Divider(thickness: 1, color: AppColors.black),
                          )
                        ],
                      ),
                      20.0.height,
                      FormButtonIcon(
                        image: Image.asset("assets/icon/google.png"),
                        label: "Login Dengan Google",
                        backgroundColor: AppColors.grey300,
                        textColor: AppColors.grey700,
                        onPressed: () {
                          _googleSignIn();
                        },
                      )
                    ]),
              ),
            ),
          ),
        );
      }),
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
    final String displayName = googleUser.displayName ?? '';
    final String email = googleUser.email ?? '';
    final String photoUrl = googleUser.photoUrl ?? '';

    if (accessToken == null) {
      throw 'No Access Token found.';
    }
    if (idToken == null) {
      throw 'No ID Token found.';
    }

    authBloc.add(SingInWithGoogel(
        idToken: idToken,
        accessToken: accessToken,
        name: displayName,
        email: email,
        urlImage: photoUrl));
  }
}
