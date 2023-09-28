import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../widget/myTextForm.dart';
import 'ListScreen.dart';
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController userName = TextEditingController();
  TextEditingController email_t = TextEditingController();
  TextEditingController password_t = TextEditingController();
  TextEditingController confirmPassword= TextEditingController();
  GlobalKey <FormState> formKey = GlobalKey <FormState>();

  Future <void> signup(
      String email,
      String password,
      ) async{
    if (formKey.currentState!.validate()) {
      try {
        final credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
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
      } catch (e) {
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
                    controller: userName,
                    texthint: 'Enter your UserName',
                    validator:(value) {
                      if (value !.length < 9) {
                        return 'email must be 9 or more';
                      }
                    }
                ),
                MyForm(
                    controller: email_t,
                    texthint: 'Enter Your Email',
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
                MyForm(
                    controller: confirmPassword,
                    texthint: 'Confirm Password',
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
                      'Sign up',
                      style: TextStyle(
                        fontSize: 16,
                      )
                  ),
                  onPressed: ()
                  {
                    signup(
                        email_t.text,
                        password_t.text,
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


              ],
            ),
          ),
        )
    );
  }
}
