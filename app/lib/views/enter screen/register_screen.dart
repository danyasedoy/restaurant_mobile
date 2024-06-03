import 'package:app/viewmodels/enter_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EnterViewModel(),
      child: Consumer<EnterViewModel>(
        builder: (context, viewModel, child) {
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
                            'Добро пожаловать в ... ',
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
                      height: 100,
                    ),
                    const Text(
                      'Создайте аккаунт',
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
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Фамилия',
                        errorText: viewModel.state.isLastNameValid ? null : 'Введите корректную фамилию',
                        prefixIcon: Icon(viewModel.state.isLastNameValid ? Icons.check : Icons.error),
                      ),
                      onChanged: (text) {
                        viewModel.validateLastName(text);
                      },
                    ),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Имя',
                        errorText: viewModel.state.isFirstNameValid ? null : 'Введите корректное имя',
                        prefixIcon: Icon(viewModel.state.isFirstNameValid ? Icons.check : Icons.error),
                      ),
                      onChanged: (text) {
                        viewModel.validateFirstName(text);
                      },
                    ),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Телефон',
                        errorText: viewModel.state.isPhoneNumberValid ? null : 'Введите корректный номер',
                        prefixIcon: Icon(viewModel.state.isPhoneNumberValid ? Icons.check : Icons.error),
                      ),
                      onChanged: (text) {
                        viewModel.validatePhoneNumber(text);
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: 300,
                      child: ElevatedButton(
                        onPressed: viewModel.isValidated() ? ()=>{} : null,
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(Colors.white),
                        ),
                        child: const Text(
                          'Регистрация',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: ()=>{Navigator.pushReplacementNamed(context, '/auth')},
                      child: const Text(
                        'У меня уже есть аккаунт!',
                        style: TextStyle(
                          decoration: TextDecoration.underline
                        )
                      ),
                    ),
                  ]
                  ),
                ),
              ),
            )
          );
        }
    ));
  }
}
