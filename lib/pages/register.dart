import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mall_drc/app/appUtil.dart';
import 'package:mall_drc/app/endPoint.dart';
import 'package:mall_drc/app/app_constatns.dart';
import 'package:mall_drc/pages/login.dart';
import 'package:mall_drc/pages/success.dart';
import 'package:mall_drc/widgets/loading.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../controler/utilisateurs/utilisateurController.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _loading = false;

  TextEditingController nomController = new TextEditingController();
  TextEditingController prenomController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController residenceontroller = new TextEditingController();
  TextEditingController telephoneController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController userController = new TextEditingController();

  String counterText = '0';
  bool valid = false;
  bool validPassword = false;
  bool showPassword = true;
  String mdp = "";
  String mdp2 = "";
  String user = "";
  String nomUser = "";
  String prenom = "";
  String email = "";
  String adresse = "";
  String telephone = "";
  var idUser;

  GlobalKey<ScaffoldState> key = GlobalKey();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? Loading()
        : Center(
            child: Scaffold(
              backgroundColor: AppColors.blueR,
              key: key,
              body: Form(
                child: SafeArea(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image(
                            image: AssetImage("assets/splash_icon.png"),
                            height: MediaQuery.of(context).size.height / 5.5,
                            width: MediaQuery.of(context).size.width,
                          ),
                          SizedBox(
                            height: 1,
                          ),
                          Container(
                              alignment: Alignment.topLeft,
                              child: Text("Création compte.",
                                  style: GoogleFonts.poppins(
                                    color: Colors.blue[800],
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold,
                                  ))),
                          SizedBox(
                            height: 30,
                          ),
                          TextField(
                            autofocus: true,
                            controller: nomController,
                            keyboardType: TextInputType.text,
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
                                  Icons.account_circle,
                                  color: Colors.blue,
                                  size: 26,
                                ),
                                contentPadding: EdgeInsets.only(
                                    bottom: 10, top: 22, left: 10),
                                //counterText: '$counterText/09',
                                counterStyle: TextStyle(fontSize: 10),
                                labelText: 'Nom',
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
                                    fontSize: 10, color: Colors.grey)),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          TextField(
                            autofocus: true,
                            controller: prenomController,
                            keyboardType: TextInputType.text,
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
                                  Icons.account_circle,
                                  color: Colors.blue,
                                  size: 26,
                                ),
                                contentPadding: EdgeInsets.only(
                                    bottom: 10, top: 22, left: 10),
                                //counterText: '$counterText/09',
                                counterStyle: TextStyle(fontSize: 10),
                                labelText: 'Prenom',
                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'Entrez le prenom d\'utilisateur',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: Colors.blue, width: 1)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blue, width: 1)),
                                hintStyle: TextStyle(
                                    fontSize: 10, color: Colors.grey)),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          TextField(
                            autofocus: true,
                            controller: emailController,
                            keyboardType: TextInputType.text,
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
                                  Icons.home,
                                  color: Colors.blue,
                                  size: 26,
                                ),
                                contentPadding: EdgeInsets.only(
                                    bottom: 10, top: 22, left: 10),
                                //counterText: '$counterText/09',
                                counterStyle: TextStyle(fontSize: 10),
                                labelText: 'Email',
                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'Entrez l\'Email',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: Colors.blue, width: 1)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blue, width: 1)),
                                hintStyle: TextStyle(
                                    fontSize: 10, color: Colors.grey)),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          TextField(
                            autofocus: true,
                            controller: telephoneController,
                            keyboardType: TextInputType.number,
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
                                  Icons.phone,
                                  color: Colors.blue,
                                  size: 26,
                                ),
                                contentPadding: EdgeInsets.only(
                                    bottom: 10, top: 22, left: 10),
                                //counterText: '$counterText/09',
                                counterStyle: TextStyle(fontSize: 10),
                                labelText: 'Telephone',
                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'Entrez le numéro de téléphone',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: Colors.blue, width: 1)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blue, width: 1)),
                                hintStyle: TextStyle(
                                    fontSize: 10, color: Colors.grey)),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          TextField(
                            autofocus: true,
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
                                    borderSide: BorderSide(
                                        color: Colors.blue, width: 1)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blue, width: 1)),
                                hintStyle: TextStyle(
                                    fontSize: 10, color: Colors.grey)),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          TextField(
                            autofocus: true,
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
                                labelText: 'Répéter mot de passe',
                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'Tapez encore votre mot de passe',
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
                                    borderSide: BorderSide(
                                        color: Colors.blue, width: 1)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blue, width: 1)),
                                hintStyle: TextStyle(
                                    fontSize: 10, color: Colors.grey)),
                          ),
                          SizedBox(
                            height: 15.0,
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
                                },
                                child: Padding(
                                  padding: EdgeInsets.all(12.0),
                                  child: Text(
                                    "CREER UN COMPTE",
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
                          //redirection vers la connexion
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Déja inscrit?",
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    /*Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (_) => Login()));*/
                                  },
                                  child: Text("CONNEXION",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold))),
                            ],
                          ),
                        ],
                      ),
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
    utilitaire.lancerChargementDialog(context);

    // appel requete API

    Map data = {
      "nom": nomController.text,
      "prenom": prenomController.text,
      "email": emailController.text,
      "telephone": telephoneController.text,
      "motdepasse": passwordController.text
    };

    print(data);

    var userCtrl = context.read<UtilisateurController>();
    Map resultat = await userCtrl.EnregistrementClient(data);
    utilitaire.snackBar(resultat['msg'], context);

    //Sur une ligne
    //context.read<AgentController>().envoyerDonnerVersAPI(data);

    await Future.delayed(Duration(milliseconds: 800));

    // quitter la boite de dialogue de chargement
    Navigator.pop(context);

    if (resultat['status']) {
      Navigator.pop(context, true);
    }
  }
}
