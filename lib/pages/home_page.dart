import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../provider/google_sign_in.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user=FirebaseAuth.instance.currentUser;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:  [
              const Text('Profile',style: TextStyle(
                fontSize: 24,fontWeight: FontWeight.bold
              ),),
              const SizedBox(height: 20,),
              CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(user!.photoURL!),
              ),
              const SizedBox(height: 20,),
              Text('Name: ${user.displayName!}',style: const TextStyle(
                fontSize: 20,fontWeight: FontWeight.bold
              )),
              const SizedBox(height: 5,),
              Text('Email: ${user.email!}',style: const TextStyle(
                fontSize: 18,fontWeight: FontWeight.bold
              )),
              Spacer(),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blueGrey,

                ),
                onPressed: () {
                  final provider=Provider.of<GoogleSignInProvider>(context,listen: false);
                  provider.googleLogOut();


                }, label: const Text('Log Out',
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 18),),
                icon: const Icon(Icons.logout,
                    color: Colors.white),
              ),


            ],
          ),
        ),
      ),
    );
  }
}
