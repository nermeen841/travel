import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:travel/constants/colors.dart';

class AddReviewScreen extends StatefulWidget {
  const AddReviewScreen({Key? key}) : super(key: key);

  @override
  State<AddReviewScreen> createState() => _AddReviewScreenState();
}

class _AddReviewScreenState extends State<AddReviewScreen> {
  TextEditingController ratting = TextEditingController();
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
          "Pyramids",
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
      body: ListView(
        primary: true,
        shrinkWrap: true,
        padding:
            EdgeInsets.symmetric(vertical: h * 0.025, horizontal: w * 0.035),
        children: [
          SizedBox(
            height: h * 0.04,
          ),
          Row(
            children: [
              CircleAvatar(
                backgroundColor: MyColors.backgroundColor,
                radius: w * 0.08,
                backgroundImage: const NetworkImage(
                    "https://img.freepik.com/free-photo/handsome-confident-smiling-man-with-hands-crossed-chest_176420-18743.jpg?w=740"),
              ),
              SizedBox(
                width: w * 0.025,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Emul Ezep",
                    style: headingStyle.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Posting publicly",
                    style: headingStyle.copyWith(
                        fontWeight: FontWeight.w400, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: h * 0.05,
          ),
          Center(
            child: RatingBar.builder(
              ignoreGestures: false,
              tapOnlyMode: true,
              initialRating: 0,
              minRating: 0,
              itemSize: w * 0.1,
              direction: Axis.horizontal,
              itemPadding: EdgeInsets.symmetric(horizontal: w * 0.015),
              allowHalfRating: false,
              itemCount: 5,
              unratedColor: MyColors.unslectedIconColor.withOpacity(0.4),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: MyColors.mainColor,
              ),
              onRatingUpdate: (rating) {},
            ),
          ),
          SizedBox(
            height: h * 0.05,
          ),
          Center(
            child: Text(
              "Share more about your experience",
              style: headingStyle.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: h * 0.02,
          ),
          Center(
            child: TextFormField(
              controller: ratting,
              maxLines: 7,
              keyboardType: TextInputType.text,
              cursorColor: MyColors.mainColor,
              decoration: InputDecoration(
                hintText: "Share details of your own experience at this place",
                hintStyle: headingStyle.copyWith(
                    fontSize: w * 0.035,
                    color: Colors.grey,
                    fontWeight: FontWeight.w400),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(w * 0.05),
                  borderSide: BorderSide(color: MyColors.mainColor),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(w * 0.05),
                  borderSide: BorderSide(color: MyColors.mainColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(w * 0.05),
                  borderSide: BorderSide(color: MyColors.mainColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(w * 0.05),
                  borderSide: BorderSide(color: MyColors.mainColor),
                ),
              ),
            ),
          ),
          SizedBox(
            height: h * 0.03,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: w * 0.04),
            child: Center(
              child: MaterialButton(
                height: h * 0.09,
                elevation: 4,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(w * 0.08),
                ),
                onPressed: () {},
                child: Center(
                  child: Text(
                    "Submit",
                    style: headingStyle.copyWith(
                        fontWeight: FontWeight.bold, fontSize: w * 0.06),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
