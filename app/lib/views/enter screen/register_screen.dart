import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                                fontStyle: FontStyle.italic
                            ),
                          ),
                          Text(
                            'Хрючево!',
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic
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
                    'Создайте аккаунт',
                    style: TextStyle(
                        fontSize: 20
                    ),
                  ),
                  const TextField(
                    decoration: InputDecoration(
                      hintText: 'Логин', // Tip text displayed when the field is empty
                    ),
                  ),
                  const TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Пароль', // Tip text displayed when the field is empty
                    ),
                  ),
                  const TextField(
                    decoration: InputDecoration(
                      hintText: 'Фамилия', // Tip text displayed when the field is empty
                    ),
                  ),
                  const TextField(
                    decoration: InputDecoration(
                      hintText: 'Имя', // Tip text displayed when the field is empty
                    ),
                  ),
                  const TextField(
                    decoration: InputDecoration(
                      hintText: 'Телефон', // Tip text displayed when the field is empty
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    width: 300,
                    child: ElevatedButton(
                      onPressed: ()=>{},
                      style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(Colors.white)
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
}
