import 'package:artikel_aplication/core/constant/colors.dart';
import 'package:artikel_aplication/core/extention/doubel_ext.dart';
import 'package:artikel_aplication/core/extention/string_ext.dart';
import 'package:artikel_aplication/core/widget/button_widget.dart';
import 'package:artikel_aplication/core/widget/form_input__password_widget.dart';
import 'package:artikel_aplication/core/widget/form_input_widget.dart';
import 'package:artikel_aplication/feature/auth/view/auth_screen.dart';
import 'package:artikel_aplication/feature/register/bloc/register_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _noHpController = TextEditingController();
  final supabase = Supabase.instance.client;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary500,
        title: const Text(
          "Register",
          style: TextStyle(color: AppColors.white),
        ),
      ),
      body: BlocListener<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state is RegisterSuccess) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AuthPage()));
          }
        },
        child: Center(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/image/logo.jpeg",
                        height: 300,
                      ),
                      20.0.height,
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password tidak boleh kosong';
                          } else if (value.length < 6) {
                            return 'Password harus memiliki setidaknya 6 karakter';
                          }
                          return null;
                        },
                        label: "Password",
                        hint: "password",
                      ),
                      20.0.height,
                      FormInput(
                        controller: _nameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Nama tidak boleh kosong';
                          }
                          return null;
                        },
                        label: "Nama",
                        hint: "Nama",
                        icon: const Icon(Icons.verified_user),
                      ),
                      20.0.height,
                      FormInput(
                        controller: _noHpController,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'No Hp tidak boleh kosong';
                          }
                          return null;
                        },
                        label: "No HP",
                        hint: "NoHp",
                        icon: const Icon(Icons.phone),
                      ),
                      30.0.height,
                      FormButton(
                        label: "RegisterPage",
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            try {
                              context.read<RegisterBloc>().add(SingUp(
                                  password: _passwordController.text,
                                  email: _emailController.text,
                                  name: _nameController.text,
                                  phone: _noHpController.text));
                              _emailController.clear();
                              _passwordController.clear();
                              _nameController.clear();
                              _noHpController.clear();
                            } catch (e) {
                              "Gagal Mendaftarkan User".failedBar(context);
                            }
                          }
                        },
                      ),
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
