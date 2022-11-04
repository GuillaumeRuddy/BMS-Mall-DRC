import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mall_drc/app/app_constatns.dart';
import 'package:mall_drc/pages/notification.dart';
import 'package:mall_drc/pages/panier.dart';
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
  var utilisateur;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //recupSession();
  }

  Future recupSession() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("utilisateur");
  }

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
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => Message()));
              },
              icon: Icon(Icons.card_giftcard_sharp))
          /*Badge(
            badgeColor: Colors.red,
            padding: EdgeInsets.all(5),
            badgeContent: Text(
              "0",
              style: TextStyle(color: Colors.white),
            ),
            child: IconButton(
                onPressed: () /*async*/ {
                  /*final pref = await SharedPreferences.getInstance();
                pref.setBool("showPres", false);*/
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => Message()));
                },
                icon: Icon(Icons.card_giftcard_sharp)),
          ),*/
        ],
      ),
      drawer: DrawerAdd(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /*Container(
              color: AppColors.blueR,
              padding: EdgeInsets.all(20),
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
                      "Panier",
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  Spacer(),
                  Icon(
                    Icons.more_vert,
                    size: 25.0,
                    color: Colors.white,
                  )
                ],
              ),
            ),*/
            Container(
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
                          FutureBuilder(
                              future: recupSession(),
                              builder: (context, snapshot) {
                                var user = snapshot.data;
                                return Row(
                                  children: [
                                    Text(
                                      "Salut! $user",
                                      style: GoogleFonts.poppins(
                                          color: Colors.blue,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                );
                              }),

                          /*CircleButton(
                            icon: Icons.account_circle,
                            onPressed: () {},
                          ),*/
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
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "voir plus",
                          style: TextStyle(
                              color: Colors.red[800],
                              fontSize: 15,
                              fontWeight: FontWeight.w700),
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
                      InkWell(
                        onTap: () {},
                        child: Container(
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
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
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
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
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
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
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
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
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
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            "voir plus",
                            style: TextStyle(
                                color: Colors.red[800],
                                fontSize: 15,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                GridView.builder(
                  shrinkWrap: true,
                  //scrollDirection: Axis.horizontal,
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
          ],
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
                Icons.home,
                size: 24.0,
              ),
              icon: Icon(
                Icons.home_outlined,
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
              activeIcon: Badge(
                badgeColor: Colors.red,
                padding: EdgeInsets.all(5),
                badgeContent: Text(
                  "3",
                  style: TextStyle(color: Colors.white),
                ),
                child: InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (_) => Panier()));
                    },
                    child: Icon(
                      Icons.shopping_cart,
                      size: 30,
                    )),
              ),
              icon: Badge(
                badgeColor: Colors.red,
                padding: EdgeInsets.all(5),
                badgeContent: Text(
                  "3",
                  style: TextStyle(color: Colors.white),
                ),
                child: InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (_) => Panier()));
                    },
                    child: Icon(
                      Icons.shopping_cart_outlined,
                      size: 30,
                    )),
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
