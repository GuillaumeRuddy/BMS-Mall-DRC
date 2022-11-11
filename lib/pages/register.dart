import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mall_drc/app/api.dart';
import 'package:mall_drc/app/app_constatns.dart';
import 'package:mall_drc/pages/login.dart';
import 'package:mall_drc/pages/success.dart';
import 'package:mall_drc/widgets/loading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

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
                          height: MediaQuery.of(context).size.height / 5.5,
                          width: MediaQuery.of(context).size.width,
                        ),
                        /*CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.red.shade200,
                          backgroundImage: AssetImage("assets/splash_icon.png"),*/
                        /* child: Icon(CupertinoIcons.person_alt_circle,
                      color: Colors.red,
                      size: 60,),*/

                        /*SizedBox(
                          height: 5,
                        ),*/
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
                                /*mdp = passwordController.text;
                                user = userController.text;*/

                                //loger(user, mdp);

                                /*Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Home(
                                      userName: user,
                                      idUser: "1",
                                    )));*/

                                String nom = nomController.text;
                                String prenom = prenomController.text;
                                String email = emailController.text;
                                //String residence = residenceontroller.text;
                                String telephone = telephoneController.text;
                                String mdp = passwordController.text;

                                loger(nom, prenom, email, telephone, mdp);
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
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => Login()));
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

  /*Future loger(String nom, String prenom, String email, String telephone,
      String mdp) async {
    print("mon nom ************ " + nom);
    print("mon prenom ************ " + prenom);
    print("mon email ************ " + email);
    print("ma residence ************ " + telephone);
    print("ma residence ************ " + mdp);
    //Debut Test de connection, pour voir si l'utilisateur est connecter
    var connectivityResult = await (Connectivity().checkConnectivity());
    print(" ******  Nous sommes dans le check internet   ****** ");
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      //S'il est connecter on vas vers l'API ici...
      /*setState(() {
        _loading = true;
      });*/
      try {
        print(" ******  debut try   ****** ");
        print("url que jutilise pour enregistrer" +
            ApiUrl().baseUrl +
            ApiUrl().enregistrement);
        final response = await http
            .post(Uri.parse(ApiUrl().baseUrl + ApiUrl().enregistrement),
                headers: <String, String>{
                  "Content-type": "application/json; chartset=UTF-8"
                },
                body: jsonEncode(<String, String>{
                  "nom": nom,
                  "prenom": prenom,
                  "email": email,
                  "telephone": telephone,
                  "motdepasse": mdp
                }))
            .timeout(const Duration(seconds: 20), onTimeout: () {
          //<----Gestion du time out dans le cas ou sa prend trop de temps
          print(" ******  tozo zela  ****** ");
          snackBar("Delais d'attente depasser, veuillez reessaie plus tard");
          throw TimeoutException(
              'The connection has timed out, Please try again!');
        });
        print(" ******  response  ****** ");
        if (response.statusCode == 200) {
          print(" ******  200  ****** ");
          //<------ Teste si la requette vers l'API marche
          var data = jsonDecode(response
              .body); //<---- recuperation des données qui sont en format JSON
          print("les datas que recupere *********** " + data.toString());

          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Success()));

          //var retour = data["status"];
          /*if (retour == "success") {
            print(data["donnees"]["id"]);
            idUser = data["donnees"]["id"];

            // enregistrement des élements de l'utilisateur comme valeur de session qui sera repris dans les différents écrans
            /*SharedPreferences pref = await SharedPreferences.getInstance();
            pref.setString("user", login);
            pref.setString("id_user", idUser.toString());
            pref.setString("mdp", pass);*/

            

            /*Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        Acceuil(userName: login, idUser: idUser.toString())));*/

            setState(() {
              toast("Enregistrer");
              bool _loading = false;
            });
          } else {
            var msg = "Le nom utilisateur ou mot de passe est incorrecte";
            setState(() {
              snackBar(msg);
            });
          }*/

          //ici tu met la redirection en fonction de l'action qui vas suivre...
        } else {
          print("la reponse du status est éééééééééé ");
          print(response.statusCode);
          setState(() {
            bool _loading = false;
            var msg = "vérification impossible";
            snackBar(msg);
          });
        }
      } on SocketException {
        setState(() {
          snackBar(
              "Nous rencontrons un problème, veuillez réessaie ulterieuement");
        });
      } on TimeoutException {
        setState(() {
          snackBar("Delais d'attente dépasser");
        });
      } catch (e) {
        print("erreur: $e");
        setState(() {
          snackBar("Nous rencontrons un problème $e");
        });
      }
    } else {
      setState(() {
        toast("Impossible de se connecter à internet");
      });
    }
  }
}*/

  Future loger(String nom, String prenom, String email, String telephone,
      String mdp) async {
    // Les valeurs que j'envoie vers le serveur
    /*print("mon nom ************ " + nom);
    print("mon prenom ************ " + prenom);
    print("mon email ************ " + email);
    print("ma residence ************ " + telephone);
    print("ma residence ************ " + mdp);*/

    // le end point de ma methode pour enregistrer le client
    var url = Uri.parse(ApiUrl().baseUrl + ApiUrl().enregistrement);
    print("url que jutilise pour enregistrer");
    print(url);

    Map data = {
      "nom": nom,
      "prenom": prenom,
      "email": email,
      "telephone": telephone,
      "motdepasse": mdp
    };

    print(data);

    String final_data = json.encode(data);
    print(final_data);
    var myHeaders = {'Content-Type': 'application/json'};

    try {
      print(" ******  debut try   ****** ");
      var reponse = await http.post(url, body: final_data, headers: myHeaders);
      print("******* LE STATUS CODE EST: ********");
      print(reponse.statusCode);
      print(reponse.body);
      print(" ******  fin try   ****** ");
    } catch (e, stack) {
      print(" ******  debut catch   ****** ");
      print(e);
      print(stack);
      print(" ******  fin catch   ****** ");
    }
  }
}
