import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mall_drc/controler/marchants/marchandController.dart';
import 'package:mall_drc/model/categorie.dart';
import 'package:mall_drc/model/marchant.dart';
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
                    "Marchant",
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
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: cat.length,
                    itemBuilder: (BuildContext context, int index) {
                      return CategorieCard(
                          nom: cat[index]["nom"],
                          text: cat[index]["desc"],
                          icone: cat[index]["icon"]);
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
