import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_signin/controller/app_cubit.dart';
import 'package:google_signin/pages/home_page.dart';
import 'package:google_signin/provider/google_sign_in.dart';
import 'package:provider/provider.dart';

import 'controller/BlocObserver.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();

  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=>GoogleSignInProvider(),

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Google Sign in',
        theme: ThemeData(
          // primarySwatch: MaterialColor(1,Map(4,Colors.black)),
            primaryColor: Colors.blue,
            primarySwatch: Colors.blueGrey
        ),
        home: const MyHomePage(title:
        'Google Sign in'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      // backgroundColor: Colors.black,
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot){
          if(snapshot.connectionState==ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator(),);

          }
          else if(snapshot.hasError){
            return Center(child: const Text('Error While Login '),);
          }
          else if(snapshot.hasData){
            return const HomeScreen();
          }
          return  Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Spacer(),
                  const FlutterLogo(size: 220, style: FlutterLogoStyle.stacked,
                    textColor: Colors.blueGrey,),
                  const SizedBox(height: 30,),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Hey There,\n Welcome back ',
                      style: TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 24),),
                  ),
                  const SizedBox(height: 5,),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Login to your account to continue ',
                      style: TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 16),),
                  ),
                  const Spacer(),
                  // const SizedBox(height: 60,),
                  // const Spacer(),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blueGrey,

                    ),
                    onPressed: () {
                      final provider=Provider.of<GoogleSignInProvider>(context,listen: false);
                      provider.googleLogin();


                    }, label: const Text('Sign in With Google',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),),
                    icon: const FaIcon(FontAwesomeIcons.google,
                        color: Colors.white),
                  ),
                  const SizedBox(height: 20,),
                  RichText(
                    text: const TextSpan(
                        text: 'Already have an account?',
                        style: TextStyle(decoration: TextDecoration.none,
                            color: Colors.black, fontSize: 20), children: [
                      TextSpan(text: 'Login In ',
                          style: TextStyle(decoration: TextDecoration.underline,
                              color: Colors.blue, fontSize: 16))
                    ]
                    ),


                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
