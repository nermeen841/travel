import 'package:flutter/material.dart';
import 'package:travel/constants/colors.dart';

class ViewMoreScreen extends StatefulWidget {
  final String title;
  const ViewMoreScreen({Key? key, required this.title}) : super(key: key);

  @override
  State<ViewMoreScreen> createState() => _ViewMoreScreenState();
}

class _ViewMoreScreenState extends State<ViewMoreScreen> {
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
          widget.title,
          style: headingStyle.copyWith(
              fontWeight: FontWeight.bold, fontSize: w * 0.06),
        ),
        actions: [
          InkWell(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.clear,
              color: MyColors.mainColor,
              size: w * 0.09,
            ),
          ),
        ],
      ),
      body: Container(
        width: w,
        height: h,
        padding: EdgeInsets.symmetric(horizontal: w * 0.041),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: h * 0.03,
              ),
              SizedBox(
                width: w,
                height: h * 0.8,
                child: GridView.builder(
                  itemCount: 12,
                  shrinkWrap: false,
                  primary: false,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: w * 0.00236,
                    mainAxisSpacing: w * 0.02,
                    crossAxisSpacing: h * 0.02,
                  ),
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          width: w * 0.4,
                          height: h * 0.16,
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
                                    "https://img.freepik.com/free-photo/served-christmas-table-setting-dark-tones-with-golden-deco_1220-6601.jpg?w=740"),
                                fit: BoxFit.cover),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: w * 0.35,
                          child: Text(
                            "Meuseum Meuseum Meuseum Meuseum",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: headingStyle.copyWith(
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
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
