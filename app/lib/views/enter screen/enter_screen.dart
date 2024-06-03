import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

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
                      'Войдите в аккаунт',
                      style: TextStyle(
                        fontSize: 20
                      ),
                  ),
                  const TextField(),
                  const TextField(
                    obscureText: true,
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
                        'Войти',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                      onPressed: ()=>{},
                      child: const Text(
                        'У меня нет аккаунта!',
                        style: TextStyle(
                          decoration: TextDecoration.underline
                        )
                      ),
                  ),
                  TextButton(onPressed: ()=>{}, child: const Text('Войти как официант')),
                  TextButton(onPressed: ()=>{}, child: const Text('Войти как курьер'))
                ],
              ),
            ),
          ),
      ),
    );
  }
}

