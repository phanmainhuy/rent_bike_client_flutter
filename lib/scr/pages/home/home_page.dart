import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rent_bike/scr/models/vehicle_model.dart';
import 'package:rent_bike/scr/pages/home/home_provider.dart';
import 'package:rent_bike/scr/pages/home/nav_drawer_widget.dart';
import 'package:rent_bike/scr/resources/app_color.dart';

import '../../utils/constants.dart';
import '../../utils/format.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeProvider>(
      create: (context) => HomeProvider(),
      child: _HomePage(),
    );
  }
}

class _HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        backgroundColor: AppColor.kPrimaryColor,
      ),
      drawer: NavDrawerWidget(),
      body: _buildCard(),
    );
  }

  Widget _buildCard() {
    return Container(
      padding: EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,

          children: <Widget>[
            //okay with duplicate widget
            Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: 220,
                  margin: EdgeInsets.all(5),
                  child: CarouselSlider(
                    options: CarouselOptions(
                      aspectRatio: 2.0,
                      enlargeCenterPage: true,
                      enableInfiniteScroll: false,
                      initialPage: 2,
                      autoPlay: true,
                    ),
                    items: _buildImageSliders,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: double.infinity,
              height: 1,
              child: Container(
                // margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 5,),
            Text(
              'Welcome to Rent Bike App',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5,),
            SizedBox(
              width: double.infinity,
              height: 1,
              child: Container(
                // margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 5,),
            Container(
              width: double.infinity,
              height: 1000,
              // color: Colors.greenAccent,
              child: _buildTopTen,
            )
          ],
        ),
      ),
    );
  }

  Widget get _buildTopTen => Selector<HomeProvider, List<VehicleModel>>(
        shouldRebuild: (v1, v2) => true,
        selector: (context, provider) => provider.topVehicle,
        builder: (context, topvehicle, _) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
          child: Card(
            elevation: 4.0,
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 2.0,
              mainAxisSpacing: 2.0,
              children: List.generate(
                topvehicle.length,
                (index) {
                  return Center(
                    child: Card(
                        color: Colors.white,
                        child: Center(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                    child: Image.network(
                                  "${Constants.urlImage}${topvehicle[index].image ?? ''}",
                                  width: 130,
                                )),
                                Text(topvehicle[index].name ?? '',
                                    style:TextStyle(fontWeight: FontWeight.bold)),
                                Text('${Format.moneyFormat(topvehicle[index].rent_price ?? 0)} VND',
                                style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 20,)
                              ]),
                        )),
                  );
                },
              ),
            ),
          ),
        ),
      );

  //get list Carousel
  List<String> imgList = [
    'assets/images/slides/1.png',
    'assets/images/slides/2.png',
    'assets/images/slides/3.png',
    'assets/images/slides/4.png',
  ];

  List<Widget> get _buildImageSliders => imgList
      .map((item) => Container(
            margin: const EdgeInsets.all(5.0),
            child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                child: Stack(
                  children: <Widget>[
                    Image.asset(
                      item,
                      fit: BoxFit.cover,
                      width: 1000.0,
                      height: 200,
                    ),
                    Positioned(
                      bottom: 0.0,
                      left: 0.0,
                      right: 0.0,
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(200, 0, 0, 0),
                              Color.fromARGB(0, 0, 0, 0)
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                      ),
                    ),
                  ],
                )),
          ))
      .toList();
}
