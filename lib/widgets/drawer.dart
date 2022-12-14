import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mall_drc/app/app_constatns.dart';
import 'package:mall_drc/pages/home.dart';
import 'package:mall_drc/pages/profil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app/endPoint.dart';
import '../pages/categories.dart';
import '../pages/login.dart';

class DrawerAdd extends StatefulWidget {
  const DrawerAdd({
    Key? key,
    /*required this.userName, required this.idUser*/
  }) : super(key: key);

  @override
  State<DrawerAdd> createState() => _DrawerAddState();
}

class _DrawerAddState extends State<DrawerAdd> {
  String? ident;
  String? nom;
  String? prenom;
  String? email;
  String? telephone;
  String? motdepasse;
  String image = "mall/mall.jpg";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    recupUser();
  }

  recupUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    ident = pref.getInt("id").toString();
    nom = pref.getString("nom");
    prenom = pref.getString("user");
    email = pref.getString("email");
    telephone = pref.getString("telephone");
    motdepasse = pref.getString("motdepasse");
    image = pref.getString("image") ?? "mall/mall.jpg";
    setState(() {});
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
                  CircleAvatar(
                      radius: 52,
                      backgroundImage: NetworkImage(
                        "${ApiUrl.baseUrl}/${image}",
                      )),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        nom ?? "",
                        style: GoogleFonts.poppins(
                            color: Colors.blue,
                            fontSize: 23,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        prenom ?? "",
                        style: GoogleFonts.poppins(
                            color: Colors.blue,
                            fontSize: 23,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  Text(
                    email ?? "",
                    style: GoogleFonts.poppins(
                        color: Colors.blue,
                        fontSize: 17,
                        fontWeight: FontWeight.w400),
                  )
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

    /*Column(
      children: [
        Container(
            color: AppColors.blueR,
            child: Padding(
              padding: EdgeInsets.only(top: 40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                      radius: 30.0,
                      backgroundImage: AssetImage('assets/splash_icon.png')),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    "MALL DRC",
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w800,
                        color: Color.fromARGB(255, 92, 16, 198)),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text("num??ro 1 des ventes en lignes",
                      style: TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w700,
                        color: Color.fromARGB(255, 212, 164, 5),
                      )),
                  //Divider(height: 3, color: Colors.black),
                ],
              ),
            )),
        SizedBox(
          height: 10.0,
        ),
        /* Divider(
          color: Colors.black,
          height: 1.0,
        ), */
        //Divider(height: 1.0, color: Colors.black),

        ListTile(
          onTap: () {
            /*Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => Actualite())); */
            /*Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => Actualite(userName: userName, idUser: idUser)));*/
          },
          leading: Icon(
            Icons.book,
            color: Colors.blue,
          ),
          title: Text("Accueil"),
        ),
        ListTile(
          onTap: null,
          leading: Icon(
            Icons.settings,
            color: Colors.blue,
          ),
          title: Text("Categorie"),
        ),
        //Divider(height: 1.0, color: Colors.black),
        ListTile(
          onTap: null,
          leading: Icon(
            Icons.settings,
            color: Colors.blue,
          ),
          title: Text("parametre"),
        ),
        //Divider(height: 1.0, color: Colors.black),
        ListTile(
          onTap: null,
          leading: Icon(
            Icons.info,
            color: Colors.blue,
          ),
          title: Text("A propos de nous"),
        ),
        Divider(height: 1.0, color: Colors.black),
        ListTile(
          onTap: () {
            /*Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Login()));*/
          },
          leading: Icon(
            FontAwesomeIcons.signOutAlt,
            color: Colors.blue,
          ),
          title: Text("Se deconnecter"),
        )
      ],
    );*/
  }
}
