import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:threads/src/features/auth/application/providers.dart';
import 'package:threads/src/features/auth/domain/user_auth_credentials_model.dart';
import 'package:threads/src/widgets/molecules/call_to_sign_up.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key, required this.isSignInScreen});
  final bool isSignInScreen;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // bool isLoading = false;
    String buttonTitle = widget.isSignInScreen ? 'Sign In' : 'Create Account';
    String title =
        widget.isSignInScreen ? 'Welcome back!' : 'Welcome to Threads!';
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 64),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style:
                    const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(label: Text('Email')),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.email(),
                        ]),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                          controller: _passwordController,
                          decoration:
                              const InputDecoration(label: Text('Password')),
                          validator: FormBuilderValidators.required()),
                      const SizedBox(height: 12),
                      widget.isSignInScreen
                          ? Container()
                          : TextFormField(
                              controller: _confirmPasswordController,
                              decoration: const InputDecoration(
                                  label: Text('Confirm Password')),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(),
                                (val) {
                                  if (val != _passwordController.text) {
                                    return 'Passwords do not match';
                                  }
                                  return null;
                                }
                              ])),
                      const SizedBox(height: 36),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    backgroundColor: Colors.black,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16)),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    final UserAuthCredential credential =
                                        UserAuthCredential(
                                            email: _emailController.text,
                                            password: _passwordController.text);

                                    ref.watch(signUpProvider(credential)).when(
                                        data: (data) {
                                      print(data);
                                    }, error: (e, st) {
                                      print(e);
                                      print(st);
                                    }, loading: () {
                                      // setState(() {
                                      //   isLoading = true;
                                      // });
                                    });
                                  }
                                },
                                child: Text(
                                  buttonTitle,
                                  style: const TextStyle(fontSize: 20),
                                )),
                          ),
                        ],
                      ),
                      CallToAuth(
                          prefix: widget.isSignInScreen
                              ? "Don't have an account yet?"
                              : "Already have an account?",
                          buttonText:
                              widget.isSignInScreen ? 'Sign Up' : 'Sign In',
                          authType: widget.isSignInScreen ? 'signUp' : 'signIn')
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
