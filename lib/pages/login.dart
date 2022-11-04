import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mall_drc/app/app_constatns.dart';
import 'package:mall_drc/pages/home.dart';
import 'package:mall_drc/pages/register.dart';
import 'package:mall_drc/widgets/loading.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _loading = false;

  TextEditingController userController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  String counterText = '0';
  bool valid = false;
  bool validPassword = false;
  bool showPassword = true;
  String mdp = "";
  String user = "";
  var idUser;

  GlobalKey<ScaffoldState> key = GlobalKey();

  @override
  void dispose() {
    super.dispose();
  }

  Future savSession() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("utilisateur", user);
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? Loading()
        : Center(
            child: Scaffold(
              backgroundColor: AppColors.blueR,
              key: key,
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image(
                          image: AssetImage("assets/splash_icon.png"),
                          height: MediaQuery.of(context).size.height / 3,
                          width: MediaQuery.of(context).size.width,
                        ),
                        /*CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.red.shade200,
                          backgroundImage: AssetImage("assets/splash_icon.png"),*/
                        /* child: Icon(CupertinoIcons.person_alt_circle,
                      color: Colors.red,
                      size: 60,),*/
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                            alignment: Alignment.topLeft,
                            child: Text("Login.",
                                style: GoogleFonts.poppins(
                                  color: Colors.blue[800],
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold,
                                ))),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: TextField(
                                autofocus: false,
                                controller: userController,
                                keyboardType: TextInputType.text,
                                cursorColor: Colors.white,
                                textAlignVertical: TextAlignVertical.bottom,
                                //maxLength: 9,
                                onChanged: (value) {
                                  setState(() {
                                    counterText = value.length.toString();
                                  });

                                  if (value.length > 3) {
                                    setState(() {
                                      valid = true;
                                    });
                                  } else {
                                    valid = false;
                                  }
                                },
                                decoration: InputDecoration(
                                    prefixIcon: const Icon(
                                      Icons.account_circle_sharp,
                                      color: Colors.blue,
                                      size: 26,
                                    ),
                                    contentPadding: EdgeInsets.only(
                                        bottom: 10, top: 22, left: 10),
                                    //counterText: '$counterText/09',
                                    counterStyle: TextStyle(
                                      fontSize: 10,
                                    ),
                                    labelText: 'Utilisateur',
                                    //labelStyle: ,
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: 'Entrez le nom d\'utilisateur',
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color: Colors.blue, width: 1)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.blue, width: 1)),
                                    hintStyle: TextStyle(
                                        fontSize: 15, color: Colors.grey)),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        TextField(
                          autofocus: false,
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          textAlignVertical: TextAlignVertical.bottom,
                          obscureText: showPassword,
                          //maxLength: 20,
                          onChanged: (value) {
                            setState(() {
                              counterText = value.length.toString();
                            });

                            if (value.length > 3) {
                              setState(() {
                                validPassword = true;
                              });
                            } else {
                              validPassword = false;
                            }
                          },
                          decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.security,
                                color: Colors.blue,
                                size: 26,
                              ),
                              contentPadding: EdgeInsets.only(
                                  bottom: 10, top: 22, left: 10),
                              // counterText: '$counterText/09',
                              counterStyle: TextStyle(fontSize: 10),
                              labelText: 'Mot de passe',
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Tapez votre mot de passe',
                              suffixIcon: IconButton(
                                icon: Icon(
                                  Icons.remove_red_eye,
                                  color: this.showPassword
                                      ? Colors.blue
                                      : Colors.grey,
                                ),
                                onPressed: () {
                                  setState(() {
                                    showPassword = !showPassword;
                                  });
                                },
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      BorderSide(color: Colors.blue, width: 1)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.blue, width: 1)),
                              hintStyle:
                                  TextStyle(fontSize: 15, color: Colors.grey)),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => Register()));
                                },
                                child: Text("Mot de passe oublier ?",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: AppColors.ecrit,
                                        fontWeight: FontWeight.bold))),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.all(12.0),
                          //ce bouton fonctionne uniquement si le numero est valid
                          child: AbsorbPointer(
                            absorbing: valid == true ? false : true,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  //Prend la couleur bleu si numero valid sinon grise
                                  primary:
                                      valid == true && validPassword == true
                                          ? AppColors.ecrit
                                          : Colors.blueGrey),
                              onPressed: () {
                                mdp = passwordController.text;
                                user = userController.text;
                                savSession();
                                Navigator.of(context).push(
                                    MaterialPageRoute(builder: (_) => Home()));

                                //loger(user, mdp);

                                /*Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Home(
                                      userName: user,
                                      idUser: "1",
                                    )));*/
                              },
                              child: Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Text(
                                  "Se Connecter",
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Vous n'avez pas de compte?",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => Register()));
                                },
                                child: Text("Inscription",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold))),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }

  void toast(String msag) {
    Fluttertoast.showToast(
        msg: msag,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2);
  }

  void snackBar(String msg) {
    SnackBar snackBar = new SnackBar(
        content: Text(msg),
        duration: new Duration(seconds: 5),
        backgroundColor: Color.fromARGB(255, 219, 25, 11),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
            label: 'OK',
            onPressed: ScaffoldMessenger.of(context).hideCurrentSnackBar));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  //Sauvegarde dans le préférence
  void saveInfosPersonnel() async {
    print('Inside savepref');
    //_password = _passcontroller.text;
    user = userController.text;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', user);
  } //fin savepref

}
