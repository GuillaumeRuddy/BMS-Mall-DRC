import 'package:flutter/material.dart';
import 'package:mall_drc/app/appUtil.dart';
import 'package:mall_drc/app/app_constatns.dart';
import 'package:mall_drc/model/adresse.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app/endPoint.dart';
import '../model/utilisateur.dart';

class DetailUser extends StatefulWidget {
  //Utilisateur data;
  //DetailUser({required this.data});
  DetailUser();

  @override
  State<DetailUser> createState() => _DetailUserState();
}

class _DetailUserState extends State<DetailUser> {
  late Utilisateur user;
  int? ident;
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
    //user = widget.data;
    recupUser();
  }

  recupUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    ident = pref.getInt("id");
    nom = pref.getString("nom");
    prenom = pref.getString("user");
    email = pref.getString("email");
    telephone = pref.getString("telephone");
    motdepasse = pref.getString("motdepasse");
    image = pref.getString("image") ?? "mall/mall.jpg";
    setState(() {});
    user = Utilisateur(
        id: ident.toString(),
        nom: nom,
        prenom: prenom,
        email: email,
        telephone: telephone,
        motDePasse: motdepasse,
        image: image);
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: AppColors.blueR,
                padding: EdgeInsets.all(15),
                //entete
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 25.0,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Text(
                        "Information utilisateur",
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    /*Spacer(),
                  Icon(
                    Icons.more_vert,
                    size: 25.0,
                    color: Colors.white,
                  )*/
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              /*FutureBuilder(
                  future: recupUser(),
                  builder: (context, snapshot) {
                    Utilisateur user = snapshot.data! as Utilisateur;
                    print("Le type de valeur dans marchant");
                    print(user.runtimeType);
                    if (snapshot.hasData) */

              /*if(nom == null || nom.isEmpty){*/
              SingleChildScrollView(
                child: Column(
                  children: [
                    Center(
                      child: ClipOval(
                        child: Material(
                            color: Colors.transparent,
                            child: Image.network(
                              "${ApiUrl.baseUrl}/${image}",
                              height: 120.0,
                            )),
                      ),
                    ),
                    //profileImageVue(),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          nom ?? "",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 24),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          prenom ?? "",
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    editerButtonVue(user),
                    SizedBox(
                      height: 70,
                    ),
                    rapportVue(title: "Email", value: email ?? ""),
                    SizedBox(
                      height: 20,
                    ),
                    rapportVue(title: "Telephone", value: telephone ?? ""),
                    SizedBox(
                      height: 20,
                    ),
                    rapportVue(title: "Adresse", value: "N/A"),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ) /*;
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }*/
              /* }),*/
            ],
          ),
        ),
      ),
    );
  }

  AppBar entete() {
    return AppBar(
      title: Text(
        "Nom utilisateur",
        style: TextStyle(color: AppColors.blueR),
      ),
      elevation: 0,
      centerTitle: true,
      backgroundColor: Colors.transparent,
      bottom: PreferredSize(
          child: Container(
            color: Colors.grey,
            height: 1.0,
          ),
          preferredSize: Size.fromHeight(1.0)),
      actions: [],
    );
  }

  /*Widget profileImageVue() {
    return Center(
      child: ClipOval(
        child: Material(
            color: Colors.transparent,
            child: Image.network(
            "${ApiUrl.baseUrl}/$image"??,
            height: 120.0,
          )
                ),
      ),
    );
  }*/

  Widget infoNomVue() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          nom ?? "",
          /*${agent.nom}*/
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        const SizedBox(height: 4),
        Text(
          prenom ?? "",
          style: TextStyle(color: Colors.grey),
        )
      ],
    );
  }

  editerButtonVue(Utilisateur util) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: StadiumBorder(),
        primary: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
      ),
      child: Text(
        "Editer",
        style: TextStyle(color: AppColors.blueR),
      ),
      onPressed: () {
        /*Navigator.push(
            context, MaterialPageRoute(builder: (ctx) => null));*/
      },
    );
  }

  /*chiffresVue() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      chiffreButton(context, email ?? "", 'Adresse Email'),
      Container(
        height: 24,
        child: VerticalDivider(),
      ),
      chiffreButton(context, telephone ?? "", 'Telephone'),
      Container(
        height: 24,
        child: VerticalDivider(),
      ),
      chiffreButton(context, '16%', 'INSS')
    ]);
  }*/

  Widget chiffreButton(BuildContext context, String value, String text) {
    return MaterialButton(
      padding: EdgeInsets.symmetric(vertical: 4),
      onPressed: () {},
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            value,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          SizedBox(height: 2),
          Text(
            text,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget rapportVue({String? title, String? value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title ?? '',
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                      fontWeight: FontWeight.normal)),
              SizedBox(
                width: 30,
              ),
              Text(value ?? '', style: TextStyle(fontWeight: FontWeight.bold))
            ],
          ),
          Divider(
            thickness: 1,
          )
        ],
      ),
    );
  }
}
