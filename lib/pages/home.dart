import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mall_drc/app/app_constatns.dart';
import 'package:mall_drc/widgets/drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mall_drc/model/category.dart';

import '../model/category.dart';
import '../widgets/category_card.dart';
import '../widgets/circle_button.dart';
import '../widgets/search_testfield.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mall DRC", style: TextStyle(color: AppColors.ecrit)),
        elevation: 0.0,
        backgroundColor: AppColors.blueR,
        actions: [
          IconButton(
              onPressed: () /*async*/ {
                /*final pref = await SharedPreferences.getInstance();
                pref.setBool("showPres", false);*/
              },
              icon: Icon(Icons.card_giftcard_sharp))
        ],
      ),
      drawer: DrawerAdd(),
      body: SingleChildScrollView(
        child: Container(
          child: Center(
              child: Column(children: [
            Container(
              padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
              height: 150,
              width: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
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
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Salut! Guillaume",
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w400),
                      ),
                      CircleButton(
                        icon: Icons.account_circle,
                        onPressed: () {},
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SearchTextField()
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5, left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "CATEGORIE",
                    style: GoogleFonts.poppins(
                      color: AppColors.ecrit,
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "voir plus",
                      style: GoogleFonts.poppins(
                          color: Colors.red[800],
                          fontSize: 15,
                          fontWeight: FontWeight.w900),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 1,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Column(
                      children: [
                        Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.black),
                            child: Center(
                                child: Icon(
                              Icons.shopping_bag,
                              color: Colors.white,
                            ))),
                        Text("Boutique")
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.black),
                            child: Center(
                                child: Icon(
                              Icons.restaurant,
                              color: Colors.white,
                            ))),
                        Text("Restaurant")
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.black),
                            child: Center(
                                child: Icon(
                              Icons.shopping_cart,
                              color: Colors.white,
                            ))),
                        Text("Marcher")
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.black),
                            child: Center(
                                child: Icon(
                              Icons.local_pharmacy,
                              color: Colors.white,
                            ))),
                        Text("Pharmacie")
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.black),
                            child: Center(
                                child: Icon(
                              Icons.dashboard,
                              color: Colors.white,
                            ))),
                        Text("Autres")
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5, left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "NOUVEAUTE",
                    style: GoogleFonts.poppins(
                      color: AppColors.ecrit,
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "voir plus",
                      style: GoogleFonts.poppins(
                          color: Colors.red[800],
                          fontSize: 15,
                          fontWeight: FontWeight.w900),
                    ),
                  )
                ],
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              itemCount: categoryList.length,
              physics: NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 8,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                crossAxisSpacing: 20,
                mainAxisSpacing: 24,
              ),
              itemBuilder: (context, index) {
                return CategoryCard(
                  category: categoryList[index],
                );
              },
            ),
          ])),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.white,
          backgroundColor: AppColors.blueR,
          elevation: 0,
          items: [
            BottomNavigationBarItem(
              activeIcon: Icon(
                Icons.home_outlined,
                size: 24.0,
              ),
              icon: Icon(
                Icons.home,
                size: 24.0,
              ),
              label: "Accueil",
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(
                Icons.category,
                size: 24.0,
              ),
              icon: Icon(
                Icons.category_outlined,
                size: 24.0,
              ),
              label: "Categorie",
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(
                Icons.shopping_cart,
                size: 24.0,
              ),
              icon: Icon(
                Icons.shopping_cart_outlined,
                size: 24.0,
              ),
              label: "Panier",
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(
                Icons.person,
                size: 24.0,
              ),
              icon: Icon(
                Icons.person_outline,
                size: 24.0,
              ),
              label: "Profil",
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          }),
    );
  }
}
