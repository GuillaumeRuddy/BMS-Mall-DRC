import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mall_drc/pages/login.dart';
import 'package:mall_drc/widgets/loading.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _loading = false;

  TextEditingController nomController = new TextEditingController();
  TextEditingController prenomController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController addresseController = new TextEditingController();
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
  Widget build(BuildContext context) {
    return _loading
        ? Loading()
        : Center(
            child: Scaffold(
              key: key,
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.red.shade200,
                          backgroundImage: AssetImage("assets/splash_icon.png"),
                          /* child: Icon(CupertinoIcons.person_alt_circle,
                      color: Colors.red,
                      size: 60,),*/
                        ),
                        /*SizedBox(
                          height: 5,
                        ),*/
                        SizedBox(
                          height: 40,
                        ),
                        Container(
                            alignment: Alignment.topLeft,
                            child: Text("Register.",
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
                                autofocus: true,
                                controller: userController,
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
                                    contentPadding: EdgeInsets.only(
                                        bottom: 10, top: 22, left: 10),
                                    //counterText: '$counterText/09',
                                    counterStyle: TextStyle(fontSize: 10),
                                    labelText: 'Pseudo',
                                    hintText:
                                        'Entrez le pseudo de l\'utilisateur',
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
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        TextField(
                          autofocus: true,
                          controller: userController,
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
                              contentPadding: EdgeInsets.only(
                                  bottom: 10, top: 22, left: 10),
                              //counterText: '$counterText/09',
                              counterStyle: TextStyle(fontSize: 10),
                              labelText: 'Nom',
                              hintText: 'Entrez le nom d\'utilisateur',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      BorderSide(color: Colors.blue, width: 1)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.blue, width: 1)),
                              hintStyle:
                                  TextStyle(fontSize: 10, color: Colors.grey)),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        TextField(
                          autofocus: true,
                          controller: userController,
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
                              contentPadding: EdgeInsets.only(
                                  bottom: 10, top: 22, left: 10),
                              //counterText: '$counterText/09',
                              counterStyle: TextStyle(fontSize: 10),
                              labelText: 'Prenom',
                              hintText: 'Entrez le prenom d\'utilisateur',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      BorderSide(color: Colors.blue, width: 1)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.blue, width: 1)),
                              hintStyle:
                                  TextStyle(fontSize: 10, color: Colors.grey)),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        TextField(
                          autofocus: true,
                          controller: userController,
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
                              contentPadding: EdgeInsets.only(
                                  bottom: 10, top: 22, left: 10),
                              //counterText: '$counterText/09',
                              counterStyle: TextStyle(fontSize: 10),
                              labelText: 'Adresse',
                              hintText: 'Entrez l\'Adresse',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      BorderSide(color: Colors.blue, width: 1)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.blue, width: 1)),
                              hintStyle:
                                  TextStyle(fontSize: 10, color: Colors.grey)),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        TextField(
                          autofocus: true,
                          controller: userController,
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
                              contentPadding: EdgeInsets.only(
                                  bottom: 10, top: 22, left: 10),
                              //counterText: '$counterText/09',
                              counterStyle: TextStyle(fontSize: 10),
                              labelText: 'Telephone',
                              hintText: 'Entrez le numéro de téléphone',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      BorderSide(color: Colors.blue, width: 1)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.blue, width: 1)),
                              hintStyle:
                                  TextStyle(fontSize: 10, color: Colors.grey)),
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
                              contentPadding: EdgeInsets.only(
                                  bottom: 10, top: 22, left: 10),
                              // counterText: '$counterText/09',
                              counterStyle: TextStyle(fontSize: 10),
                              labelText: 'Mot de passe',
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
                                  TextStyle(fontSize: 10, color: Colors.grey)),
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
                              contentPadding: EdgeInsets.only(
                                  bottom: 10, top: 22, left: 10),
                              // counterText: '$counterText/09',
                              counterStyle: TextStyle(fontSize: 10),
                              labelText: 'Répéter mot de passe',
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
                                  borderSide:
                                      BorderSide(color: Colors.blue, width: 1)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.blue, width: 1)),
                              hintStyle:
                                  TextStyle(fontSize: 10, color: Colors.grey)),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Deja inscrit?",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.blue[900],
                                    fontWeight: FontWeight.bold)),
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => Login()));
                                },
                                child: Text("Connexion",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.red[900],
                                        fontWeight: FontWeight.bold))),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.all(12.0),
                          //ce bouton fonctionne uniquement si le numero est valid
                          child: AbsorbPointer(
                            absorbing: valid == true ? false : true,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                //Prend la couleur bleu si numero valid sinon grise
                                primary: valid == true && validPassword == true
                                    ? Colors.green[700]
                                    : Colors.grey,
                              ),
                              onPressed: () {
                                mdp = passwordController.text;
                                user = userController.text;

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
                                  "Enregistrer",
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
