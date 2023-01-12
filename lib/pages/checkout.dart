import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mall_drc/app/appUtil.dart';
import 'package:mall_drc/controler/commande/commandeController.dart';
import 'package:mall_drc/model/adresse.dart';
import 'package:mall_drc/model/produit.dart';
import 'package:mall_drc/pages/success.dart';
import 'package:mall_drc/widgets/cardAdresse.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app/app_constatns.dart';
import '../controler/panier/panierController.dart';
import '../db/db_mall.dart';
import 'adresse.dart';
import 'coordoner.dart';

class CheckoutPage extends StatefulWidget {
  bool? livraison;
  CheckoutPage({Key? key, this.livraison}) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  String? nom;
  String? coord;
  String? det;
  String? num;
  bool? recup;
  String livr = "100";
  String? monTot;
  String monTotArt = "8.500";
  var operateur;
  List<Produit> ListProduit = [];
  Map resultat = {};
  TextEditingController telController = new TextEditingController();
  DbMAll baseDD = DbMAll();

  void recupValSelect() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    nom = pref.getString("nomAdresseSelec");
    coord = pref.getString("coordAdresseSelec");
    det = pref.getString("descSelec");
    num = pref.getString("telephone");
    setState(() {});
  }

  void recupDefVal() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    nom = pref.getString("nomAdresse");
    coord = pref.getString("coordAdresse");
    det = pref.getString("desc");
    num = pref.getString("telephone");
    setState(() {});
  }

  List listeOperateur = [
    "MPESA",
    "AIRTEL-MONEY",
    "ORANGE-MONEY",
    "AFRI-MONEY"
    /*{"MPESA", "17"},
    {"AIRTEL-MONEY", "24"},
    {"ORANGE-MONEY", "5"},
    {"AFRI-MONEY", "32"}*/
  ];

  List<DropdownMenuItem<String>> listOpe = [];

  void typeMouv() {
    listOpe.clear();
    for (var com in listeOperateur) {
      print(com);
      print(com.runtimeType);
      print("super commmm");
      listOpe.add(
        DropdownMenuItem(
          value: com,
          child: Text(
            com,
            style: TextStyle(color: Colors.black, fontSize: 15),
          ),
        ),
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    recup = widget.livraison;
    recupValSelect();
  }

  @override
  Widget build(BuildContext context) {
    typeMouv();
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Checkout",
          style: Theme.of(context)
              .textTheme
              .subtitle1!
              .copyWith(fontWeight: FontWeight.w700, color: AppColors.ecrit),
        ),
        elevation: 0.0,
        backgroundColor: AppColors.blueR,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Addresse',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => MesAdresses()));
                    },
                    child: Text(
                      'Changer',
                      style: Theme.of(context).textTheme.button!.copyWith(
                            color: Colors.redAccent,
                          ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Container(
                  child: Center(
                child: recup != false
                    ? CardAdresse(nom: nom, adresse: coord, description: det)
                    : pasAdresse(),
              )),
              const SizedBox(height: 24.0),
              /*Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Mode de Payement',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Text(
                      'Change',
                      style: Theme.of(context).textTheme.button!.copyWith(
                            color: Colors.redAccent,
                          ),
                    ),
                  ),
                ],
              ),*/
              /*const SizedBox(height: 8.0),
              Text(
                'OrangeMoney',
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(height: 24.0),
              Text(
                num!,
                style: Theme.of(context).textTheme.headline6,
              ),*/
              const SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Center(
                    child: Text(
                      'Mode de reception',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) => Dialog(
                                //backgroundColor: AppColors.blueR,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                child: Container(
                                  height: 200,
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          color: AppColors.blueR,
                                          child: Image(
                                            image: AssetImage(
                                                "assets/splash_icon.png"),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                3,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                          child: Container(
                                        color: AppColors.blueR,
                                        child: SizedBox.expand(
                                          child: Padding(
                                            padding: EdgeInsets.all(15.0),
                                            child: Column(
                                              children: [
                                                Text(
                                                  "Voulez-vous, vous faire livré?",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                          Navigator.of(context).push(
                                                              MaterialPageRoute(
                                                                  builder: (_) =>
                                                                      MesAdresses()));
                                                        },
                                                        child: Text("Oui",
                                                            style: TextStyle(
                                                                fontSize: 16,
                                                                color:
                                                                    Colors.blue,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold))),
                                                    TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                          Navigator.of(context).push(
                                                              MaterialPageRoute(
                                                                  builder: (_) =>
                                                                      CheckoutPage()));
                                                        },
                                                        child: Text("Non",
                                                            style: TextStyle(
                                                                fontSize: 16,
                                                                color:
                                                                    Colors.blue,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold))),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ))
                                    ],
                                  ),
                                ),
                              ));
                    },
                    child: Text(
                      'Changer',
                      style: Theme.of(context).textTheme.button!.copyWith(
                            color: Colors.redAccent,
                          ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 13.0),
              Container(
                child: recup != true
                    ? Text(
                        'Lieu de vente',
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            fontSize: 17,
                            color: AppColors.ecrit,
                            fontWeight: FontWeight.bold),
                      )
                    : Text(
                        'Livraison',
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            fontSize: 17,
                            color: AppColors.ecrit,
                            fontWeight: FontWeight.bold),
                      ),
              ),
              const SizedBox(height: 32.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Montant:",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Text(
                    monTotArt,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Livraison:",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Text(
                    livr,
                    style: Theme.of(context).textTheme.headline6,
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Montant:",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Text(
                    "${livr + monTotArt}",
                    style: Theme.of(context).textTheme.headline6,
                  )
                ],
              ),
              const SizedBox(height: 64.0),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    if (recup == true) {
                      typeMouv();
                      showModalBottomSheet(
                          context: context,
                          builder: (builder) {
                            return Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Container(
                                /*decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    stops: [0.1, 0.5],
                                    colors: [
                                      AppColors.blue,
                                      AppColors.blueR,
                                    ],
                                  ),
                                ),*/
                                child: Column(
                                  children: [
                                    Text(
                                      "Payement",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6!
                                          .copyWith(),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Text(
                                      "Operateur",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6!
                                          .copyWith(),
                                    ),
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                    DropdownButton(
                                        value: operateur,
                                        elevation: 20,
                                        items: listOpe,
                                        hint: Text(
                                          'Sélectionnez le type d\'opérateur',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16),
                                        ),
                                        onChanged: (value) {
                                          operateur = value;
                                          setState(() {});
                                        }),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: TextFormField(
                                          keyboardType: TextInputType.number,
                                          controller: telController,
                                          cursorColor: Colors.black,
                                          maxLength: 14,
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              labelText: 'Téléphone',
                                              hintText:
                                                  'Saisir le numero de telephone')),
                                    ),
                                    SizedBox(height: 25),
                                    Padding(
                                      padding: EdgeInsets.all(12.0),
                                      //ce bouton fonctionne uniquement si le numero est valid
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            //Prend la couleur bleu si numero valid sinon grise
                                            primary: AppColors.ecrit),
                                        onPressed: () async {
                                          paiement();
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.all(12.0),
                                          child: Text(
                                            "Commander",
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
                              ),
                            );
                          });
                    } else {
                      utilitaire.toast("Je passe la commande");
                      print("Je passe la commande directement");
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: AppColors.ecrit,
                    shape: true
                        ? RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24.0),
                          )
                        : null,
                  ),
                  child: Text(
                    "Summission",
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget pasAdresse() {
    return Column(
      children: [
        Center(
          child: Text(
            'Aucune adresse!',
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ),
        const SizedBox(height: 6.0),
        InkWell(
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => MesAdresses()));
          },
          child: Text(
            'Ajouter une adresse',
            style: Theme.of(context).textTheme.button!.copyWith(
                  color: Colors.redAccent,
                ),
          ),
        ),
      ],
    );
  }

  void paiement() async {
    // CircularBar
    utilitaire.lancerChargementDialog4(context);

    // donnée a envoie à l'API
    Map paie = {
      "customer": telController.text,
      "amount": "${livr + monTotArt}",
      "currency": "CDF"
    };

    // appel requete API
    var ctrlPaie = context.read<CommandeController>();
    var resultat = await ctrlPaie.Payement(paie);
    print(resultat);

    if (resultat == "Succed") {
      envoyerDonner();
    }
  }

  void envoyerDonner() async {
    utilitaire.lancerChargementDialog4(context);

    var ctrlCommande = context.read<CommandeController>();

    var ctrlPanier = context.read<PanierController>();
    ListProduit = await ctrlPanier.getData();

    SharedPreferences pref = await SharedPreferences.getInstance();
    var idUser = pref.getInt("id").toString();

    for (var prod in ListProduit) {
      Map data = {
        "marchand_id": prod.marchand_id,
        "id_client": idUser,
        "id_produit": prod.id,
        "prix": prod.prix,
        "quantite": prod.quantite,
        "adresse": recup != false ? coord : "Aucune",
        "description": recup != false ? det : "Aucune",
        "modelivraison": recup != false ? "oui" : "non",
        "prixdriver": 10000
      };
      print(data);

      resultat = await ctrlCommande.CommandeProduit(data);
      print('la commande a afficher ++++++++++++');
      print(resultat);
    }

    utilitaire.afficherSnack(context, resultat["msg"],
        resultat["status"] ? Colors.green : Colors.red);

    await Future.delayed(Duration(milliseconds: 800));

    if (resultat['status']) {
      Navigator.pop(context, true);
      baseDD.suppressionTousProduitPanier();
      reinit();
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => Success()));
    }
  }

  Future reinit() async {
    var ctrlPanier = await context.read<PanierController>();
    ctrlPanier.reinitAllPanier();
  }

  /*Widget ecranPayement() {
    return ;
  }*/

  /*calculTotal(String tot, String liv){
    int tot = tot;
    int liv = int.parse(liv);
  }*/
}
