import 'package:flutter/material.dart';
import 'package:rent_bike/scr/resources/app_color.dart';

class BuildLoginButton extends StatelessWidget {
  const BuildLoginButton({Key? key, onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(AppColor.kPrimaryColor)),
          // padding: EdgeInsets.symmetric(vertical:18, horizontal: 40),
          // color: AppColor.kPrimaryColor,
          onPressed: () {},
          //Navigator.of(context).push(MaterialPageRoute(builder: (context) => MainPage()));
          //},
          child: const Text(
            "LOGIN",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
