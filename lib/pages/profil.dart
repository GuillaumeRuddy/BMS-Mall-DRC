import 'package:flutter/material.dart';
import 'package:mall_drc/app/appUtil.dart';
import 'package:mall_drc/app/app_constatns.dart';

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //user = widget.data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: entete(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            profileImageVue(),
            SizedBox(
              height: 20,
            ),
            infoNomVue(),
            SizedBox(
              height: 20,
            ),
            editerButtonVue(),
            SizedBox(
              height: 20,
            ),
            chiffresVue(),
            SizedBox(
              height: 50,
            ),
            rapportVue(title: "Salaire Net"),
            SizedBox(
              height: 20,
            ),
            rapportVue(title: "IPR à payer"),
            SizedBox(
              height: 20,
            ),
            rapportVue(title: "INSS à payer"),
            SizedBox(
              height: 20,
            ),
            rapportVue(title: "Dons"),
            SizedBox(
              height: 20,
            ),
          ],
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

  Widget profileImageVue() {
    return Center(
      child: ClipOval(
        child: Material(
          color: Colors.transparent,
          child: Icon(
            Icons.face,
            size: 128,
          ),
        ),
      ),
    );
  }

  Widget infoNomVue() {
    return Column(
      children: [
        Text(
          "Jeremie",
          /*${agent.nom}*/
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        const SizedBox(height: 4),
        Text(
          "Utilisateur",
          style: TextStyle(color: Colors.grey),
        )
      ],
    );
  }

  editerButtonVue() {
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

  chiffresVue() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      chiffreButton(context, '4,800', 'Salaire Brute'),
      Container(
        height: 24,
        child: VerticalDivider(),
      ),
      chiffreButton(context, '35%', 'IPR'),
      Container(
        height: 24,
        child: VerticalDivider(),
      ),
      chiffreButton(context, '16%', 'INSS')
    ]);
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
              Text('2300', style: TextStyle(fontWeight: FontWeight.bold))
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
