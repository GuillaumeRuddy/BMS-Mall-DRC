import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mall_drc/app/appUtil.dart';
import 'package:mall_drc/model/utilisateur.dart';
import 'package:mall_drc/pages/profil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app/app_constatns.dart';
import '../controler/utilisateurs/utilisateurController.dart';

class EditProfil extends StatefulWidget {
  Utilisateur? user;
  EditProfil({super.key, this.user});

  @override
  State<EditProfil> createState() => _EditProfilState();
}

class _EditProfilState extends State<EditProfil> {
  TextEditingController nomController = new TextEditingController();
  TextEditingController prenomController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController telephoneController = new TextEditingController();
  TextEditingController motdePasseController = new TextEditingController();
  TextEditingController motdePVerif1Controller = new TextEditingController();
  TextEditingController motdePVerif2Controller = new TextEditingController();
  TextEditingController imageController = new TextEditingController();
  bool showPassword = true;
  bool showPassword1 = true;
  bool showPassword2 = true;
  var resultat;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    rempliDonne();
  }

  void rempliDonne() {
    nomController.text = widget.user!.nom!;
    prenomController.text = widget.user!.prenom!;
    telephoneController.text = widget.user!.telephone!;
    emailController.text = widget.user!.email!;
    motdePasseController.text = widget.user!.motDePasse!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Modification du profile",
          style: Theme.of(context).textTheme.subtitle1!.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 20,
              color: AppColors.ecrit),
        ),
        elevation: 0.0,
        backgroundColor: AppColors.blueR,
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(23.0),
        child: Column(
          children: [
            TextFormField(
              controller: nomController,
              decoration: InputDecoration(
                  hintText: "Saisisez le nom svp",
                  labelText: 'Nom',
                  hintStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.blue, width: 1)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 1))),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: prenomController,
              decoration: InputDecoration(
                  hintText: "Saisisez le prenom svp",
                  labelText: 'Prenom',
                  hintStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.blue, width: 1)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 1))),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: telephoneController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: "Saisisez le numéro svp",
                  labelText: 'Telephone',
                  hintStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.blue, width: 1)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 1))),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  hintText: "Saisisez l'email svp",
                  labelText: 'Email',
                  hintStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.blue, width: 1)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 1))),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              autofocus: false,
              controller: motdePasseController,
              keyboardType: TextInputType.visiblePassword,
              textAlignVertical: TextAlignVertical.bottom,
              obscureText: showPassword,
              decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.security,
                    color: Colors.blue,
                    size: 26,
                  ),
                  contentPadding:
                      EdgeInsets.only(bottom: 10, top: 22, left: 10),
                  // counterText: '$counterText/09',
                  counterStyle: TextStyle(fontSize: 10),
                  labelText: 'Mot de passe',
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Saisisez l'ancien mot de passe svp",
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: this.showPassword ? Colors.blue : Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                  ),
                  border: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.blue, width: 1)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 1)),
                  hintStyle: TextStyle(fontSize: 15, color: Colors.grey)),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              autofocus: false,
              controller: motdePVerif1Controller,
              keyboardType: TextInputType.visiblePassword,
              textAlignVertical: TextAlignVertical.bottom,
              obscureText: showPassword1,
              decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.security,
                    color: Colors.blue,
                    size: 26,
                  ),
                  contentPadding:
                      EdgeInsets.only(bottom: 10, top: 22, left: 10),
                  // counterText: '$counterText/09',
                  counterStyle: TextStyle(fontSize: 10),
                  labelText: 'Nouveau mot de passe',
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Saisisez votre nouveau mot de passe',
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: this.showPassword1 ? Colors.blue : Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        showPassword1 = !showPassword1;
                      });
                    },
                  ),
                  border: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.blue, width: 1)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 1)),
                  hintStyle: TextStyle(fontSize: 15, color: Colors.grey)),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              autofocus: false,
              controller: motdePVerif2Controller,
              keyboardType: TextInputType.visiblePassword,
              textAlignVertical: TextAlignVertical.bottom,
              obscureText: showPassword2,
              decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.security,
                    color: Colors.blue,
                    size: 26,
                  ),
                  contentPadding:
                      EdgeInsets.only(bottom: 10, top: 22, left: 10),
                  // counterText: '$counterText/09',
                  counterStyle: TextStyle(fontSize: 10),
                  labelText: 'Repete nouveau mot de passe',
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Saisisez encore votre nouveau mot de passe',
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: this.showPassword2 ? Colors.blue : Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        showPassword2 = !showPassword2;
                      });
                    },
                  ),
                  border: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.blue, width: 1)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 1)),
                  hintStyle: TextStyle(fontSize: 15, color: Colors.grey)),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.all(12.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: AppColors.ecrit),
                onPressed: () {
                  if (motdePVerif1Controller.text ==
                      motdePVerif2Controller.text) {
                    MAJProfile();
                  } else {
                    utilitaire.afficherSnack(context,
                        "veuillez verifier le nouveau mot de passe saisie");
                  }
                },
                child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text(
                    "Modifier le profile",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }

  void MAJProfile() async {
    utilitaire.lancerChargementDialog4(context);
    SharedPreferences pref = await SharedPreferences.getInstance();
    int? ident = await pref.getInt("id");

    // appel requete API
    Map data = {
      "id": ident,
      "nom": nomController.text,
      "prenom": prenomController.text,
      "telephone": telephoneController.text,
      "email": emailController.text,
      "motdepasse": (motdePVerif1Controller.text == "")
          ? motdePasseController.text
          : motdePVerif1Controller.text,
    };

    print(data);

    var userCtrl = context.read<UtilisateurController>();
    resultat = await userCtrl.MajProfile(data);
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
      Navigator.pop(context);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => DetailUser()));
    }
  }
}
