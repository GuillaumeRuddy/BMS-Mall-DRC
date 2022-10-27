import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mall_drc/app/app_constatns.dart';
import 'package:mall_drc/pages/home.dart';
import 'package:mall_drc/pages/login.dart';
import 'package:mall_drc/widgets/partialPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Presentation extends StatefulWidget {
  const Presentation({Key? key}) : super(key: key);

  @override
  State<Presentation> createState() => _PresentationState();
}

class _PresentationState extends State<Presentation> {
  final controlle = PageController();
  bool lastPage = false;

  @override
  void dispose() {
    // TODO: implement dispose
    controlle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 12),
        child: PageView(
          controller: controlle,
          onPageChanged: (index) {
            setState(() => lastPage = index == 2);
          },
          children: [
            buildPage(
                coleur: AppColors.blueR,
                image: 'assets/img/online.png',
                titre: "Numéro 1 des ventes en ligne",
                sousTitre:
                    "nous vendons et livrons dans plusieurs pays en temps records"),
            buildPage(
                coleur: AppColors.blueR,
                image: 'assets/img/2.png',
                titre: "Pas une vente sans Mall DRC",
                sousTitre:
                    "nous vendons et livrons dans plusieurs pays en temps records"),
            buildPage(
                coleur: AppColors.blueR,
                image: 'assets/img/3.png',
                titre: "Leader dans le marcher des ventes",
                sousTitre:
                    "nous vendons et livrons dans plusieurs pays en temps records"),
          ],
        ),
      ),
      bottomSheet: lastPage
          ? TextButton(
              style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(1)),
                  primary: Colors.white,
                  backgroundColor: Colors.teal.shade700,
                  minimumSize:
                      Size.fromHeight(MediaQuery.of(context).size.height / 12)),
              onPressed: () async {
                /*final pref = await SharedPreferences.getInstance();
                pref.setBool("showPres", true);*/
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => Login()));
              },
              child: Text(
                "Commencer",
                style: TextStyle(fontSize: 24),
              ))
          : Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              color: AppColors.ecrit,
              height: MediaQuery.of(context).size.height / 12,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () => controlle.jumpToPage(2),
                      child: Text(
                        'Passer',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      )),
                  Center(
                    child: SmoothPageIndicator(
                      controller: controlle,
                      count: 3,
                      effect: WormEffect(
                        dotHeight: 16,
                        dotWidth: 16,
                        type: WormType.thin,
                        // strokeWidth: 5,
                      ),
                      onDotClicked: (index) => controlle.animateToPage(index,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeIn),
                    ),
                  ),
                  TextButton(
                      onPressed: () => controlle.nextPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.bounceInOut),
                      child: Text('Suivant',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold))),
                ],
              ),
            ),
    );
  }
}
