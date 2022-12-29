import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mall_drc/controler/marchants/marchandController.dart';
import 'package:mall_drc/model/categorie.dart';
import 'package:mall_drc/model/marchant.dart';
import 'package:mall_drc/widgets/cardMarchant.dart';
import 'package:provider/provider.dart';

import '../app/app_constatns.dart';
import '../widgets/cardCategorie.dart';

class Marchant extends StatefulWidget {
  String? nomCategorie;
  Marchant({super.key, this.nomCategorie});

  @override
  State<Marchant> createState() => _MarchantState();
}

class _MarchantState extends State<Marchant> {
  List<Marchand> listMarchand = [];
  // ici créé une map
  late String idmarchant;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      //await recupidSession();
      idmarchant = widget.nomCategorie!;
      await recupMarchand();
    });
  }

  Future recupMarchand() async {
    var MarchCtrl = context.read<MarchandController>();
    await MarchCtrl.RecupMarchand(idmarchant);
    listMarchand = MarchCtrl.listDesMarchands;
    print("----------- les marchands ----------");
    print(listMarchand);
    print("------ fin list des marchands ------");
    setState(() {});
  }

  recupMarchand2() async {
    var MarchCtrl = context.read<MarchandController>();
    await MarchCtrl.RecupMarchand(idmarchant);
    listMarchand = MarchCtrl.listDesMarchands;
    return listMarchand;
  }

  @override
  Widget build(BuildContext context) {
    List<Map> cat = AppColors.listMarchand;
    return Scaffold(
      body: ListView(
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
                    "${widget.nomCategorie!}",
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          //details
          Container(
            //height: MediaQuery.of(context).size.height / 1,
            //padding: EdgeInsets.only(top: 15),
            decoration: BoxDecoration(
                color: Color.fromARGB(77, 233, 230, 230),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(35),
                    topRight: Radius.circular(35))),
            child: FutureBuilder(
                future: recupMarchand2(),
                builder: (context, snapshot) {
                  List<Marchand>? user = snapshot.data as List<Marchand>?;
                  print("Le type de valeur dans marchant");
                  print(user.runtimeType);
                  if (snapshot.hasData) {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: user!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return MarchantCard(vendeur: listMarchand[index]);
                            },
                          )
                        ],
                      ),
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }),

            /*SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: listMarchand.length,
                    itemBuilder: (BuildContext context, int index) {
                      print("le marchant dans le body");
                      print(listMarchand[index]);
                      print(listMarchand[index].runtimeType);
                      print("fin de marchant dans le body");
                      return MarchantCard(vendeur: listMarchand[index]);
                      /*CategorieCard(
                          nom: listMarchand[index].nomEntreprise,
                          text: listMarchand[index].numeroEntreprise,
                          icone: listMarchand[index].image);*/
                      // ici je vais créée un larchant via les donnée de la liste
                      //MarchantCard()
                    },
                  )
                ],
              ),
            ),*/
          ),
        ],
      ),
    );
  }
}
