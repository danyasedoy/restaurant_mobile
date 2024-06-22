import 'package:app/viewmodels/enter_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main screen/main_screen.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EnterViewModel(),
      child: Consumer<EnterViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.state.loginStatus == LoginStatus.error) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Ошибка авторизации. Повторите попытку.")),
              );
            });
            viewModel.state.loginStatus = LoginStatus.initial;
          }
          if (viewModel.state.loginStatus == LoginStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          else if (viewModel.state.loginStatus == LoginStatus.success) {
            final roleId = viewModel.state.roleId;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => MainScreen(roleId: roleId,))
              );
            });
            return const SizedBox.shrink();
          }
          else {
          return Scaffold(
            body: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 300),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                            color: Colors.deepOrange,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.all(Radius.circular(45))
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            children: [
                              Text(
                                'С возвращением в ... ',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w300,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.black38
                                ),
                              ),
                              Text(
                                'Хрючево!',
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.black
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 200,
                      ),
                      const Text(
                        'Войдите в аккаунт',
                        style: TextStyle(
                            fontSize: 20
                        ),
                      ),
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'Введите логин',
                          errorText: viewModel.state.isLoginValid ? null : 'Введите корректный логин',
                          prefixIcon: Icon(viewModel.state.isLoginValid ? Icons.check : Icons.error),
                        ),

                        onChanged: (text) {
                          viewModel.validateLogin(text);
                        },
                      ),
                      TextField(
                        obscureText: true,
                        decoration:  InputDecoration(
                          hintText: 'Введите пароль',
                          errorText: viewModel.state.isPasswordValid ? null : 'Введите корректный пароль',
                          prefixIcon: Icon(viewModel.state.isPasswordValid ? Icons.check : Icons.error),
                        ),
                        onChanged: (text) {
                          viewModel.validatePassword(text);
                        },
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      SizedBox(
                        width: 300,
                        child: ElevatedButton(
                          onPressed: viewModel.isValidated(isForAuth: true) ? ()=>{viewModel.login()} : null,
                          style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(
                                  Colors.white)
                          ),
                          child: const Text(
                            'Войти',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () =>
                        {
                          Navigator.pushReplacementNamed(context, '/register')
                        },
                        child: const Text(
                            'У меня нет аккаунта!',
                            style: TextStyle(
                                decoration: TextDecoration.underline
                            )
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
          }
        }
      ),
    );
  }
}

