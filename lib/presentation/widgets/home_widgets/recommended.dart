import 'package:flutter/material.dart';
import 'package:travel/constants/colors.dart';
import 'package:travel/presentation/screens/detail/detail.dart';

class RecommendedSection extends StatefulWidget {
  const RecommendedSection({Key? key}) : super(key: key);

  @override
  _RecommendedSectionState createState() => _RecommendedSectionState();
}

class _RecommendedSectionState extends State<RecommendedSection> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return SizedBox(
      height: h * 0.2,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => InkWell(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DetailScreen())),
                child: Container(
                  margin: EdgeInsets.all(w * 0.01),
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
                          blurRadius: 3)
                    ],
                    image: const DecorationImage(
                        image: NetworkImage(
                            "https://img.freepik.com/free-photo/egyptian-desert-design_1048-1862.jpg?w=740"),
                        fit: BoxFit.cover),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: h * 0.1, left: w * 0.02, right: w * 0.02),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Pyramids",
                            style: headingStyle.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on_outlined,
                                    color: Colors.white,
                                    size: w * 0.035,
                                  ),
                                  Text(
                                    "Cairo",
                                    style: headingStyle.copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "5.0",
                                    style: headingStyle.copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Colors.white,
                                    size: w * 0.035,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          itemCount: 5),
    );
  }
}
