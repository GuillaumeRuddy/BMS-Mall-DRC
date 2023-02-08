import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mall_drc/app/appUtil.dart';
import 'package:mall_drc/controler/commande/commandeController.dart';
import 'package:mall_drc/model/adresse.dart';
import 'package:mall_drc/model/produit.dart';
import 'package:mall_drc/pages/home.dart';
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
  String? ident;
  String? nom;
  String? coord;
  String? det;
  String? num;
  bool? recup;
  String livr = "100";
  String? monTot;
  String monTotArt = "8.500";
  int? nombrePanier;
  var operateur;
  int numOperateur = 0;
  List<Produit> ListProduit = [];
  Map resultat = {};
  TextEditingController telController = new TextEditingController();
  DbMAll baseDD = DbMAll();
  double? montantTot;

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
    /*{"Reseau": "MPESA", "id": "17"},
    {"Reseau": "AIRTEL-MONEY", "id": "17"},
    {"Reseau": "ORANGE-MONEY", "id": "5"},
    {"Reseau": "AFRI-MONEY", "id": "19"},
    {"Reseau": "ECOBANK", "id": "23"},
    {"Reseau": "EQUITY", "id": "20"}*/
  ];

  List<DropdownMenuItem<String>> listOpe = [];

  void typeMouv() {
    listOpe.clear();
    for (var com in listeOperateur) {
      print(com);
      listOpe.add(
        DropdownMenuItem(
          value: com, //com["id"],
          child: Text(
            com, //com["Reseau"],
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
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      ident = pref.getInt("id").toString();
      var ctrlPanier = context.read<PanierController>();
      nombrePanier = await ctrlPanier.getNbrItemPanier(ident!);
      setState(() {});
    });
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
                      recup != false
                          ? Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => MesAdresses()))
                          : null;
                    },
                    child: Text(
                      recup != false ? "Changer" : "",
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Center(
                    child: Text(
                      'Mode de reception',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  /*InkWell(
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
                  ),*/
                ],
              ),
              const SizedBox(height: 13.0),
              Container(
                child: recup != true
                    ? Text(
                        'Passer à la boutique',
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
              const SizedBox(height: 72.0),
              Consumer<PanierController>(builder: (context, value, child) {
                montantTot = int.parse(livr) + value.getPrixTotal();
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Nombre d'article:",
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${nombrePanier}",
                          style:
                              Theme.of(context).textTheme.subtitle2!.copyWith(),
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.black,
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Montant:",
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${value.getPrixTotal()} \CDF",
                          style:
                              Theme.of(context).textTheme.subtitle2!.copyWith(),
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.black,
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Livraison:",
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          livr + " CDF",
                          style:
                              Theme.of(context).textTheme.subtitle2!.copyWith(),
                        )
                      ],
                    ),
                    Divider(
                      color: Colors.black,
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Montant TTC:",
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${montantTot!} CDF",
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2!
                              .copyWith(color: Colors.red),
                        )
                      ],
                    ),
                  ],
                );
              }),
              const SizedBox(height: 64.0),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    if (recup == true) {
                      showModalBottomSheet(
                          context: context,
                          builder: (builder) {
                            typeMouv();
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
                                        dropdownColor: AppColors.ecrit,
                                        onChanged: (value) {
                                          operateur = value;
                                          /*setState(() {
                                            switch (value) {
                                              case "MPESA":
                                                operateur = "9";
                                                break;
                                              case "AIRTEL-MONEY":
                                                operateur = "17";
                                                break;
                                              case "ORANGE-MONEY":
                                                operateur = "10";
                                                break;
                                              case "AFRI-MONEY":
                                                operateur = "19";
                                                break;
                                              default:
                                                null;
                                            }
                                            ;*/
                                          //operateur = value;
                                          /*});*/
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
                                          String? op;
                                          switch (operateur) {
                                            case "MPESA":
                                              numOperateur = 9;
                                              break;
                                            case "AIRTEL-MONEY":
                                              numOperateur = 17;
                                              break;
                                            case "ORANGE-MONEY":
                                              numOperateur = 10;
                                              break;
                                            case "AFRI-MONEY":
                                              numOperateur = 19;
                                              break;
                                            default:
                                              null;
                                          }
                                          paiement(
                                              codeInt: numOperateur.toString());
                                          envoyerCommande();
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
                      envoyerCommande();
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
        SizedBox(
          height: 10,
        ),
        Center(
          child: Text(
            'Aucune adresse pour ce mode de recepetion',
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ),
        /*const SizedBox(height: 6.0),
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
        ),*/
      ],
    );
  }

  void paiement({String? codeInt}) async {
    utilitaire.lancerChargementDialog4(context);

    Map paie = {
      "customer": telController.text,
      "amount": "${montantTot!}", //"${livr + monTotArt}",
      "currency": "CDF",
      "code": codeInt!.isEmpty ? "9" : codeInt
    };

    print(paie);
    // appel requete API
    var ctrlPaie = context.read<CommandeController>();
    var retour = await ctrlPaie.Payement(paie);
    print("retour du paiement vers jeremie");
    print(retour);

    if (retour["msg"] == "Succed") {
      Map dataCallBack = retour["body"];
      print("La map du call back provenant de jeremie");
      print(dataCallBack);
      var retourPaieAvada = await ctrlPaie.PayementUniPesa(dataCallBack);
      var repStatut = retourPaieAvada["status"];
      print("le statut du paiement-----------");
      print(repStatut);
      switch (repStatut) {
        case 1:
          utilitaire.afficherSnack(
              context, "payement en cours...", Colors.green);
          await Future.delayed(Duration(milliseconds: 800));
          Navigator.pop(context, true);
          //Navigator.of(context).push(MaterialPageRoute(builder: (_) => Home()));
          break;
        case 2:
          envoyerCommande();
          break;
        case 3:
          utilitaire.afficherSnack(context, "payement echouet", Colors.green);
          await Future.delayed(Duration(milliseconds: 800));
          Navigator.pop(context, true);
          break;
        default:
          utilitaire.afficherSnack(
              context, "payement en cours de traitement...", Colors.green);
          await Future.delayed(Duration(milliseconds: 800));
          Navigator.pop(context, true);
          break;
      }
      Navigator.pop(context, true);
      //Navigator.pop(context, true);
    }
  }

  void envoyerCommande() async {
    utilitaire.lancerChargementDialog4(context);

    var ctrlCommande = context.read<CommandeController>();

    SharedPreferences pref = await SharedPreferences.getInstance();
    var idUser = pref.getInt("id").toString();

    var ctrlPanier = context.read<PanierController>();
    ListProduit = await ctrlPanier.getDataById(idUser);
    print(ListProduit);

    for (var prod in ListProduit) {
      Map data = {
        "marchand_id": prod.marchand_id,
        "id_client": idUser,
        "id_produit": prod.id,
        "prix": prod.prix,
        "quantite": prod.quantite,
        "adresse": recup != false ? coord : "Aucune",
        "description": recup != false ? det : "Aucune",
        "modelivraison": recup != true ? "oui" : "non",
        "prixdriver": 10000,
        "aretirer": recup != true ? "oui" : "non"
      };
      print(data);

      resultat = await ctrlCommande.CommandeProduit(data);
      print('la commande a afficher ++++++++++++');
      print(resultat);
    }

    /*utilitaire.afficherSnack(context, resultat["msg"],
        resultat["status"] ? Colors.green : Colors.red);

    await Future.delayed(Duration(milliseconds: 800));*/

    if (resultat['status']) {
      Navigator.pop(context, true);
      baseDD.suppressionTousProduitPanier();
      reinit();
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => Success()));
      //Navigator.pop(context, true);
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
