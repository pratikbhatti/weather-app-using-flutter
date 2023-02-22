import 'package:demo37/screens/home/controller/home_controller.dart';
import 'package:demo37/screens/home/modal/home_modal.dart';
import 'package:demo37/screens/utility/apis/api_call.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  height: MediaQuery.of(context).size.height / 14,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    border: Border.all(width: 2, color: Colors.black),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  // color: Colors.amber,
                  child: Row(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height / 2,
                        width: MediaQuery.of(context).size.width / 1.25,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: TextField(
                            onSubmitted: (value) {
                              homeController.city.value =
                                  homeController.cityName.text;
                              ApiCall().getData(homeController.city.value);
                            },
                            controller: homeController.cityName,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Enter City Name',
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          homeController.city.value =
                              homeController.cityName.text;
                          ApiCall().getData(homeController.city.value);
                          print(homeController.city.value);
                          // ApiCall().getData(homeController.cityName);
                        },
                        icon: Icon(Icons.search),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Obx(
                () => Text(
                  "${homeController.city}",
                  style: GoogleFonts.roboto(
                      fontSize: 20.sp, color: Colors.blueGrey),
                ),
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  Lottie.asset(
                    'assets/animation/cloud.json',
                    fit: BoxFit.fill,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 35),
                    child: Obx(
                      () => FutureBuilder<HomeModal?>(
                        future: ApiCall().getData(homeController.city.value),
                        builder: (context, snapshot) {
                          HomeModal? data = snapshot.data;
                          if (snapshot.hasError) {
                            return Center(
                              child: Text("Not Found"),
                            );
                          } else if (snapshot.hasData) {
                            return Text(
                              "${((data!.wind!.deg! - 32) * 5 / 9).toStringAsFixed(0)}",
                              style: TextStyle(
                                  fontSize: 30.sp, color: Colors.blueGrey),
                            );
                          } else {
                            return CircularProgressIndicator();
                          }
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 90),
                    child: Text(
                      "o",
                      style: TextStyle(color: Colors.blueGrey),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 110),
                    child: Text(
                      "C",
                      style: TextStyle(color: Colors.blueGrey),
                    ),
                  )

                  // Padding(
                  //   padding: const EdgeInsets.only(top: 35),
                  //   child: Text(
                  //     "data",
                  //     style: TextStyle(fontSize: 35, color: Colors.blueGrey),
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
