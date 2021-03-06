import 'package:becaring/Controllers/rewards_controller.dart';
import 'package:becaring/Settings/SizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';

class RewardsScreen extends StatefulWidget {
  const RewardsScreen({Key? key}) : super(key: key);

  @override
  _RewardsScreenState createState() => _RewardsScreenState();
}

class _RewardsScreenState extends State<RewardsScreen> {
  final RewardController rewardController = Get.put(RewardController());

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: ListView(
        children: [
          Container(
            color: Colors.black,
            child: Align(
              alignment: Alignment.centerLeft,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 50, left: 20),
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.pink,
                  ),
                ),
              ),
            ),
          ),
          Stack(
            children: [
              Container(
                height: SizeConfig.screenHeight * 0.5,
                width: double.infinity,
                color: Colors.black,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      child: Image.asset(
                        'assets/ethereum.png',
                        fit: BoxFit.cover,
                        // height: double.infinity,
                        // width: double.infinity,
                        alignment: Alignment.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'MyCareShift Pro Diamond',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                    Text(
                      'Through Jan 01',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 300),
                child: Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 50),
                    child: Container(
                      height: 280,
                      width: 300,
                      child: Card(
                        color: Colors.white,
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Obx(() {
                            return ListView.builder(
                                itemCount: rewardController.rewardList.length,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, index) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Center(child: Text('${rewardController.rewardList[index].referalCode}', style: TextStyle(color: Colors.red, fontSize: 18, fontWeight: FontWeight.bold),textAlign: TextAlign.center,)),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10, bottom: 10),
                                        child: Text(
                                          rewardController
                                              .rewardList[index].points,
                                          style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10, bottom: 5),
                                        child: LinearPercentIndicator(
                                          width: 250.0,
                                          animation: true,
                                          animationDuration: 1000,
                                          lineHeight: 20.0,
                                          percent: double.parse(
                                                  '${rewardController.rewardList[index].points}') /
                                              1500 *
                                              100 /
                                              10,
                                          // center: Text("20.0%"),
                                          linearStrokeCap: LinearStrokeCap.butt,
                                          progressColor: Colors.black,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 20, left: 10, right: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('0'),
                                            Text('1500'),
                                          ],
                                        ),
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.black,
                                          ),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: 'Earn 1,000 more points ',
                                                style: new TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            TextSpan(text: 'and '),
                                            TextSpan(
                                                text: 'give great service ',
                                                style: new TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            TextSpan(
                                                text:
                                                    'to keep Diamond for another 3-month period'),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 30),
                                        child: Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Text(
                                              'See Details',
                                              style: TextStyle(
                                                  color: Colors.blue,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                      ),
                                    ],
                                  );
                                });
                          }),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
