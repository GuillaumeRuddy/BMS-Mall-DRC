import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mall_drc/app/app_constatns.dart';
import 'package:mall_drc/model/category.dart';
import 'package:mall_drc/pages/details.dart';

class CategoryCard extends StatelessWidget {
  final Category category;
  const CategoryCard({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => Details()));
      },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.1),
                blurRadius: 4.0,
                spreadRadius: .05,
              )
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Image.asset(
                category.thumbnail,
                height: 80.0,
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              category.name,
              maxLines: 2,
              style: GoogleFonts.poppins(
                  color: AppColors.blueR,
                  fontSize: 15,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 0.0,
            ),
            Text(
              category.noOfCourses.toString() + " USD",
              style: GoogleFonts.poppins(
                  color: Colors.red, fontSize: 15, fontWeight: FontWeight.w700),
            ),
            Expanded(
                child: Container(
              //width: 140.0,
              decoration: BoxDecoration(
                  color: AppColors.ecrit,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10.0),
                      bottomRight: Radius.circular(10.0))),
              child: Center(
                child: Text(
                  "Détails",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
