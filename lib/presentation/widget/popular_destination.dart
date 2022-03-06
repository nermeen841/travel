import 'package:flutter/material.dart';
import 'package:travel/constants/colors.dart';
import 'package:travel/presentation/screens/detail/detail.dart';

class PopularDestinations extends StatefulWidget {
  const PopularDestinations({Key? key}) : super(key: key);

  @override
  _PopularDestinationsState createState() => _PopularDestinationsState();
}

class _PopularDestinationsState extends State<PopularDestinations> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return SizedBox(
      height: h * 0.2,
      child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => InkWell(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DetailScreen())),
                child: Container(
                  width: w * 0.4,
                  height: h * 0.15,
                  decoration: BoxDecoration(
                    color: MyColors.backgroundColor,
                    borderRadius: BorderRadius.circular(w * 0.05),
                    boxShadow: const [
                      BoxShadow(
                          offset: Offset(0, 3),
                          color: MyColors.backgroundColor,
                          spreadRadius: 3,
                          blurRadius: 3),
                    ],
                    image: const DecorationImage(
                        image: NetworkImage(
                            "https://as2.ftcdn.net/v2/jpg/01/70/66/75/1000_F_170667573_7EnaDhe9xo1elwC9fAVjy02BPiJrZ9PW.jpg"),
                        fit: BoxFit.cover),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: h * 0.15, left: w * 0.02, right: w * 0.02),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Dubai",
                        style: headingStyle.copyWith(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
          separatorBuilder: (context, index) => SizedBox(
                width: w * 0.03,
              ),
          itemCount: 5),
    );
  }
}
