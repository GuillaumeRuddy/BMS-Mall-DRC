import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mall_drc/app/app_constatns.dart';
import 'package:mall_drc/pages/home.dart';
import 'package:mall_drc/pages/profil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app/endPoint.dart';
import '../model/utilisateur.dart';
import '../pages/categories.dart';
import '../pages/login.dart';

class DrawerMarch extends StatefulWidget {
  /*final String userName;
  final String idUser;*/
  const DrawerMarch({
    Key? key,
    /*required this.userName, required this.idUser*/
  }) : super(key: key);

  @override
  State<DrawerMarch> createState() => _DrawerMarchState();
}

class _DrawerMarchState extends State<DrawerMarch> {
  /*Future recupSession() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("user");
  }*/

  recupUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? ident = pref.getInt("id").toString();
    String? nom = pref.getString("nom");
    String? prenom = pref.getString("prenom");
    String? email = pref.getString("email");
    String? telephone = pref.getString("telephone");
    String? motdepasse = pref.getString("motdepasse");
    String? image = pref.getString("image");
    setState(() {});
    Utilisateur unUser = Utilisateur(
        id: ident.toString(),
        nom: nom,
        prenom: prenom,
        email: email,
        telephone: telephone,
        motDePasse: motdepasse,
        image: image);
    print(unUser.email);
    return unUser;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: AppColors.blueR,
              padding: EdgeInsets.only(
                  top: 24 + MediaQuery.of(context).padding.top, bottom: 24),
              child: Column(
                children: [
                  FutureBuilder(
                      future: recupUser(),
                      builder: (context, snapshot) {
                        Utilisateur user = snapshot.data as Utilisateur;
                        return Column(
                          children: [
                            CircleAvatar(
                                radius: 52,
                                backgroundImage: NetworkImage(
                                    "${ApiUrl.baseUrl}/${user.image}")),
                            SizedBox(
                              height: 12,
                            ),
                            Text(
                              "${user.nom}" + "${user.prenom}",
                              style: GoogleFonts.poppins(
                                  color: Colors.blue,
                                  fontSize: 23,
                                  fontWeight: FontWeight.w400),
                            ),
                            Text(
                              "${user.email}",
                              style: GoogleFonts.poppins(
                                  color: Colors.blue,
                                  fontSize: 23,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        );
                      }),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(24),
              child: Wrap(
                spacing: 16,
                children: [
                  ListTile(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (_) => Home()));
                    },
                    leading: Icon(
                      Icons.home,
                      color: Colors.blue,
                    ),
                    title: Text(
                      "Accueil",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => Categories()));
                    },
                    leading: Icon(
                      Icons.category,
                      color: Colors.blue,
                    ),
                    title: Text(
                      "Categorie",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => DetailUser()));
                    },
                    leading: Icon(
                      Icons.person,
                      color: Colors.blue,
                    ),
                    title: Text(
                      "Profile",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  //Divider(height: 1.0, color: Colors.black),
                  ListTile(
                    onTap: null,
                    leading: Icon(
                      Icons.settings,
                      color: Colors.blue,
                    ),
                    title: Text(
                      "parametre",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  //Divider(height: 1.0, color: Colors.black),
                  ListTile(
                    onTap: null,
                    leading: Icon(
                      Icons.info,
                      color: Colors.blue,
                    ),
                    title: Text(
                      "A propos de nous",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  //Divider(height: 1.0, color: Colors.black),
                  ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Login()));
                    },
                    leading: Icon(
                      FontAwesomeIcons.signOutAlt,
                      color: Colors.blue,
                    ),
                    title: Text(
                      "Se deconnecter",
                      style: TextStyle(fontSize: 18),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
