import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mall_drc/app/appUtil.dart';
import 'package:mall_drc/app/app_constatns.dart';
import 'package:mall_drc/pages/home.dart';
import 'package:mall_drc/pages/register.dart';
import 'package:mall_drc/widgets/loading.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controler/utilisateurs/utilisateurController.dart';

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
  Map resultat = {};

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
                              //user
                              child: TextFormField(
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
                                    border: UnderlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color: Colors.blue, width: 1)),
                                    focusedBorder: UnderlineInputBorder(
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
                        //Motdepasse
                        TextFormField(
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
                              border: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      BorderSide(color: Colors.blue, width: 1)),
                              focusedBorder: UnderlineInputBorder(
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
                                  /*Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => Register()));*/
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
                                envoyerDonnees();
                                savSession();
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
                                  /*Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => Register()));*/
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

  void envoyerDonnees() async {
    // verifier si tous les champs sont valides
    /*if (!key.currentState!.validate()) {
      utilitaire.snackBar("Tous les champs sont obligatoires", context);
      return;
    }*/

    // lancer une boite de dialogue de chargement
    // pour empecher l'utilisateur
    // de faire une action inattendue
    utilitaire.lancerChargementDialog4(context);

    // appel requete API

    Map data = {
      "email": userController.text,
      "motdepasse": passwordController.text
    };

    print(data);

    var userCtrl = context.read<UtilisateurController>();
    resultat = await userCtrl.Connexion(data);
    print('lutilisateur a afficher ++++++++++++');
    print(resultat);
    utilitaire.afficherSnack(context, resultat["msg"],
        resultat["status"] ? Colors.green : Colors.red);

    //Sur une ligne
    //context.read<AgentController>().envoyerDonnerVersAPI(data);

    await Future.delayed(Duration(milliseconds: 800));

    // quitter la boite de dialogue de chargement
    Navigator.pop(context);

    if (resultat['status']) {
      Navigator.pop(context, true);
      saveInfosPersonnel();
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => Home()));
    }
  }

  //Sauvegarde dans le préférence
  void saveInfosPersonnel() async {
    print('Inside savepref');
    //_password = _passcontroller.text;
    Map personne = resultat["utilisateur"];
    print("******** dans le shared preference ***********");
    print(personne);
    print("******** le prenom ***********");
    print(personne["prenom"]);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', personne["prenom"]);
    await prefs.setString('email', personne["email"]);
    await prefs.setInt('id', personne["id"]);
    await prefs.setString('telephone', personne["telephone"]);
  } //fin savepref

  fermerClavier() {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }
}
