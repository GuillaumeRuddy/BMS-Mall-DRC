import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mall_drc/controler/adresse/adresseController.dart';
import 'package:mall_drc/model/adresse.dart';
import 'package:mall_drc/pages/coordoner.dart';
import 'package:mall_drc/widgets/cardAdresse.dart';
import 'package:provider/provider.dart';

import '../app/app_constatns.dart';

class MesAdresses extends StatefulWidget {
  const MesAdresses({super.key});

  @override
  State<MesAdresses> createState() => _MesAdressesState();
}

class _MesAdressesState extends State<MesAdresses> {
  @override
  late Future<List<Adresse>> listAdresse;
  void initState() {
    // TODO: implement initState
    super.initState();
    /*WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var adrCtrl = context.read<adresseController>();
      await adrCtrl.getDataAdresse();
      listAdresse = adrCtrl.ToutesLesAdresses as List<Adresse>;
      setState(() {});
    });*/
  }

  recupAdresse() async {
    var adrCtrl = context.read<adresseController>();
    await adrCtrl.getDataAdresse();
    listAdresse = adrCtrl.ListAdresse;
    return listAdresse;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Adresse",
          style: Theme.of(context)
              .textTheme
              .subtitle1!
              .copyWith(fontWeight: FontWeight.w700, color: AppColors.ecrit),
        ),
        elevation: 0.0,
        backgroundColor: AppColors.blueR,
      ),
      body: FutureBuilder(
          future: recupAdresse(),
          builder: (context, snapshot) {
            List<Adresse>? adr = snapshot.data as List<Adresse>?;
            print("Le type de valeur dans adresse");
            print(adr.runtimeType);
            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: adr!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return CardAdresse(
                          nom: adr[index].nom,
                          adresse: adr[index].adresse,
                          description: adr[index].description,
                        );
                        ;
                      },
                    )
                  ],
                ),
              );
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Aucune adresse enregistrer"),
                  ],
                ),
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: (() {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => Coordonne()));
        }),
        backgroundColor: AppColors.blueR,
        tooltip: "Ajouter une adresse",
        child: Icon(Icons.add),
      ),
    );
  }
}
