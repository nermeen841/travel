import 'package:flutter/material.dart';
import 'package:travel/constants/colors.dart';
import 'package:travel/presentation/screens/detail/detail.dart';
import 'package:travel/presentation/screens/search/componnent/componnent.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        title: Text(
          "Search",
          style: headingStyle.copyWith(
              fontWeight: FontWeight.bold, fontSize: w * 0.06),
        ),
      ),
      body: Container(
        width: w,
        height: h,
        padding:
            EdgeInsets.symmetric(vertical: h * 0.025, horizontal: w * 0.05),
        child: SingleChildScrollView(
          child: Column(
            children: [
              searchButton(w: w, h: h),
              SizedBox(
                height: h * 0.035,
              ),
              headerText(h: h, w: w, press: () {}),
              SizedBox(
                height: h * 0.015,
              ),
              SizedBox(
                width: w,
                height: h * 0.6,
                child: GridView.builder(
                  shrinkWrap: true,
                  primary: true,
                  itemCount: 2,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.8,
                    mainAxisSpacing: w * 0.07,
                    crossAxisSpacing: h * 0.03,
                  ),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const DetailScreen())),
                      child: GridTile(
                        child: Container(
                          width: w * 0.4,
                          height: h * 0.3,
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
                                    "https://img.freepik.com/free-photo/beautiful-tropical-beach-sea-with-chair-blue-sky_74190-7488.jpg?w=740"),
                                fit: BoxFit.cover),
                          ),
                        ),
                        footer: Container(
                          height: h * 0.09,
                          padding: EdgeInsets.symmetric(
                              horizontal: w * 0.015, vertical: h * 0.01),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(w * 0.05),
                              bottomRight: Radius.circular(w * 0.05),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Blue hole",
                                style: headingStyle.copyWith(
                                    fontWeight: FontWeight.bold),
                              ),
                              Text("Dahab", style: headingStyle),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
