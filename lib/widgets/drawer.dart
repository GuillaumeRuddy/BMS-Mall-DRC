import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mall_drc/app/app_constatns.dart';

class DrawerAdd extends StatelessWidget {
  /*final String userName;
  final String idUser;*/
  const DrawerAdd({
    Key? key,
    /*required this.userName, required this.idUser*/
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
                  Text("numéro 1 des ventes en lignes",
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
    );
  }
}
