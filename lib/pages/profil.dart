import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mall_drc/app/appUtil.dart';
import 'package:mall_drc/app/app_constatns.dart';
import 'package:mall_drc/model/adresse.dart';
import 'package:mall_drc/pages/editProfil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';

import '../app/endPoint.dart';
import '../controler/utilisateurs/utilisateurController.dart';
import '../model/utilisateur.dart';

class DetailUser extends StatefulWidget {
  @override
  State<DetailUser> createState() => _DetailUserState();
}

class _DetailUserState extends State<DetailUser> {
  //late Utilisateur user;
  int? ident;
  String? nom;
  String? prenom;
  String? email;
  String? telephone;
  String? motdepasse;
  String image = "mall/mall.jpg";
  Utilisateur? user;
  var image_file;
  String photoIdent = "";
  File? photo;
  var resultat;
  var imageProf;

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
    user = Utilisateur(
        id: ident.toString(),
        nom: nom,
        prenom: prenom,
        email: email,
        telephone: telephone,
        motDePasse: motdepasse,
        image: image);
    setState(() {});
    /*return user;*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profil utilisateur",
          style: Theme.of(context)
              .textTheme
              .subtitle1!
              .copyWith(fontWeight: FontWeight.w700, color: AppColors.ecrit),
        ),
        elevation: 0.0,
        backgroundColor: AppColors.blueR,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              /*Container(
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
              ),*/
              SizedBox(
                height: 40,
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    Center(
                      child: CircleAvatar(
                        radius: 80,
                        backgroundColor: Colors.white,
                        child: Material(
                            color: Colors.transparent,
                            child: photo == null || photo == ""
                                ? Image.network(
                                    "${ApiUrl.baseUrl}/${image}",
                                    fit: BoxFit.cover,
                                    height: 120.0,
                                  )
                                : Image.file(
                                    photo!,
                                    //height: 120.0,
                                    //fit: BoxFit.contain,
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
                        const SizedBox(width: 5),
                        Text(
                          prenom ?? "",
                          style: TextStyle(color: Colors.grey, fontSize: 24),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    editerPhoto(),
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
                      height: 40,
                    ),
                    editerProfilButton()
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

  Widget infoNomVue() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          nom ?? "",
          /*${agent.nom}*/
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        SizedBox(width: 5),
        Text(
          prenom ?? "",
          style: TextStyle(color: Colors.grey, fontSize: 24),
        )
      ],
    );
  }

  editerPhoto() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: StadiumBorder(),
        primary: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
      ),
      child: Text(
        "changer photo",
        style: TextStyle(color: AppColors.blueR),
      ),
      onPressed: () {
        menuContextuel(context);
      },
    );
  }

  editerProfilButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: StadiumBorder(),
        primary: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      ),
      child: Text(
        "Editer profil",
        style: TextStyle(color: AppColors.blueR),
      ),
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (ctx) => EditProfil(
                      user: user!,
                    )));
      },
    );
  }

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

  menuContextuel(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext ctxt) {
          return Wrap(
            children: [
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Prendre une photo",
                      style: GoogleFonts.poppins(
                          fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    Divider(
                      height: 2,
                    ),
                    ListTile(
                      leading: Icon(Icons.camera_alt_outlined),
                      title: Text(
                        "Caméra",
                        style: GoogleFonts.poppins(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        capturePhoto(ImageSource.camera);
                      },
                    ),
                    ListTile(
                        leading: Icon(Icons.photo),
                        title: Text(
                          "Gallery",
                          style: GoogleFonts.poppins(
                              fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          capturePhoto(ImageSource.gallery);
                        }),
                  ],
                ),
              )
            ],
          );
        });
  }

  capturePhoto(ImageSource source) async {
    final imagePath = await ImagePicker()
        .getImage(source: source, maxWidth: 500, maxHeight: 500);
    if (imagePath != null) {
      setState(() {
        photo = File(imagePath.path);
        photoIdent = base64Encode(photo!.readAsBytesSync());
        print(
            ' ###### la photo convertie lors de la capture :  ########  *****   ' +
                photoIdent);
        print(photo);
        MAJPhoto(photo!);
      });
    }
  }

  void MAJPhoto(File myPhoto) async {
    utilitaire.lancerChargementDialog4(context);
    SharedPreferences pref = await SharedPreferences.getInstance();
    int? ident = await pref.getInt("id");

    print("Voila my photo : ${myPhoto}");

    // appel requete API
    Map data = {"id": ident, "image": myPhoto.path};

    print(data);

    var userCtrl = context.read<UtilisateurController>();
    resultat = await userCtrl.MajPhotoProfile(data);
    print('resulta de la mise a jour a afficher ++++++++++++');
    print(resultat);
    utilitaire.afficherSnack(context, resultat["msg"],
        resultat["status"] ? Colors.green : Colors.red);

    //Sur une ligne
    //context.read<AgentController>().envoyerDonnerVersAPI(data);

    await Future.delayed(Duration(milliseconds: 1800));

    // quitter la boite de dialogue de chargement
    Navigator.pop(context);

    if (resultat['status']) {
      setState(() {
        imageProf = myPhoto;
      });
      /*Navigator.pop(context);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => DetailUser()));*/
    }
  }
}
