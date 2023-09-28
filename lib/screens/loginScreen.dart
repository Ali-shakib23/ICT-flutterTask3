import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task3/screens/sigunUpScreen.dart';

import '../widget/myTextForm.dart';
import 'ListScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email_t = TextEditingController();
  TextEditingController password_t = TextEditingController();
  GlobalKey <FormState> formKey = GlobalKey <FormState>();

  Future <void> login({
    required String email,
    required String password,
  }
      ) async{
    if (formKey.currentState!.validate()) {
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
          email: email,
          password: password,
        ).then((value) {
          if (value.user != null) {
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
              builder: (context) => ListScreen(),),
                  (route) =>false,
            );

          }
        },);
      } on FirebaseException catch (e) {
        // setState(() {
        //   isLoading = false;
        // });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar (
          content: Text(
            e.toString(),
          ),
        ));
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),

        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(
                flex:3,
              ),
              Text(
                'Welcome Back! Glad to see you. Again!',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),

              ),
              Spacer(
                flex:1,
              ),
              MyForm(
                controller: email_t,
                texthint: 'Enter your Email',
                validator:(value) {
                  if (value !.length < 9) {
                    return 'email must be 9 or more';
                  }
                }
              ),
              MyForm(
                  controller: password_t,
                  texthint: 'Enter Your password',
                  validator:(value) {
                    if (value !.length < 9) {
                      return 'email must be 9 or more';
                    }
                  }
              ),

              Spacer(
                flex:1,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(
                    330,
                    40,
                  ),
                  backgroundColor: Color(0xFf300046)
                ),
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 16,
                    )
                  ),
                onPressed: ()
                {
                  login(
                      email: email_t.text,
                      password: password_t.text,
                  );
                },
              ),
              SizedBox(
                height: 20,
              ),
              Text('Or login with'),
              Spacer(
                flex:1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SvgPicture.asset(
                    'images/apple.svg',
                  ),
                  SvgPicture.asset(
                    'images/face.svg',
                  ), SvgPicture.asset(
                    'images/google.svg',
                  ),
                  ],
              ),
              Spacer(
                flex:2,
              ),
              Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Don\'t have an account?',),
                      TextButton(
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => SignUpScreen(),
                            ));
                          },
                          child: Text(
                              'Register now',
                            style: TextStyle(
                              color:Color(
                                0xFFF14336
                              ),
                            ),
                          )),
                    ],
                  ),
              Spacer(
                flex:1,
              ),

            ],
          ),
        ),
      )

    );
  }
}
