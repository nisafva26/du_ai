import 'dart:developer';

import 'package:alan_voice/alan_voice.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simpleflutterapp/main.dart';
import 'package:simpleflutterapp/provider/mobile_plan_provider.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget();

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  @override
  void initState() {
    super.initState();

    AlanVoice.init();

    AlanVoice.addButton(
      "e741a0395f40e2daf99e4b11efd3e51a2e956eca572e1d8b807a3e2338fdd0dc/stage", // Replace with your Alan AI project key
      buttonAlign: AlanVoice.BUTTON_ALIGN_RIGHT,
    );

    AlanVoice.onCommand.add((command) {
      log('new command received');

      _handleCommand(command.data);
    });
  }

  void _handleCommand(Map<String, dynamic> command) {
    final provider = Provider.of<MobilePlanProvider>(context, listen: false);
    // showSnackBar(context, 'message received');
    // showSnackBar(context, '${command["command"]}');
    switch (command["command"]) {
      case "showPlansUnder":
        String category = command["category"];
        int price = command["price"];
        provider.showPlansUnder(category, price);
        break;
      case "purchasePlan":
        provider.purchasePlan();
        break;
      case "showPlansUnderPrice":
        int price = command["price"];
        provider.showPlansUnderPrice(price);
        break;
      case "showMyPlans":
        _showMyPlans();
        break;
      case "showCategory":
        String category = command["category"];

        provider.showCategoryPlans(category);
        break;
      case "showAllPlans":
        provider.showAllPlans();
        break;
      case "minimumData":
        int price = command["price"];
        provider.minimumData(price);
        break;
    }
  }

  void _showMyPlans() {
    // Navigate to the My Plans screen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyPlansPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
            child: Consumer<MobilePlanProvider>(
              builder: (context, provider, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Popular plans',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: provider?.availablePlans.length,
                      itemBuilder: (context, index) {
                        final plan = provider.availablePlans[index];
                        return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Stack(
                              children: [
                                Card(
                                  color: Colors.white,
                                  surfaceTintColor: Colors.white,
                                  shadowColor: Colors.grey[900],
                                  child: Container(
                                    //   height: 200,
                                    width: MediaQuery.of(context).size.width,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 18)
                                          .copyWith(left: 25),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            plan.name,
                                            style: const TextStyle(
                                                fontSize: 20,
                                                color: Color(0xff53389E),
                                                fontWeight: FontWeight.w800),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          const Text(
                                            'For 12 months',
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 12),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text:
                                                      '${plan.dataLimitGB} GB ',
                                                  style: const TextStyle(
                                                    fontFamily: 'Avenir',
                                                    color: Colors.black,
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                const TextSpan(
                                                  text: 'National data',
                                                  style: TextStyle(
                                                    fontFamily: 'Avenir',
                                                    color: Colors.black,
                                                    fontSize: 13,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 3,
                                          ),
                                          RichText(
                                            text: const TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: 'Maximum speed ',
                                                  style: TextStyle(
                                                    fontFamily: 'Avenir',
                                                    color: Colors.black,
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: 'Unlimited',
                                                  style: TextStyle(
                                                    fontFamily: 'Avenir',
                                                    color: Colors.black,
                                                    fontSize: 13,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 3,
                                          ),
                                          RichText(
                                            text: const TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: '1500',
                                                  style: TextStyle(
                                                    fontFamily: 'Avenir',
                                                    color: Colors.black,
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: 'Flexi limits',
                                                  style: TextStyle(
                                                    fontFamily: 'Avenir',
                                                    color: Colors.black,
                                                    fontSize: 13,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: 'AED ${plan.price}',
                                                  style: const TextStyle(
                                                    fontFamily: 'Avenir',
                                                    color: Color(0xff53389E),
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                const TextSpan(
                                                  text: ' / month',
                                                  style: TextStyle(
                                                    fontFamily: 'Avenir',
                                                    color: Colors.black,
                                                    fontSize: 13,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                // Add your onPressed logic here
                                              },
                                              style: ElevatedButton.styleFrom(
                                                surfaceTintColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                  side: const BorderSide(
                                                      color: Color(0xff53389E)), // Outline color
                                                ),
                                              ),
                                              child:  const Text(
                                                'Select',
                                                style: TextStyle(
                                                    color: Color(0xff53389E),fontSize: 16,fontWeight: FontWeight.w600),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 0,
                                  top: 0,
                                  bottom: 0,
                                  child: Container(
                                    width: 16, // Adjust width as needed
                                    decoration:   BoxDecoration(
                                      color: Color(0xff53389E), // Shadow color for the left side
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(
                                            12), // Top left corner radius
                                        bottomLeft: Radius.circular(
                                            12), // Bottom left corner radius
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ));
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     // Add functionality for the floating action button here
      //     print('Floating Action Button pressed');
      //     _handleCommand({"command": "showPlansUnderPrice", "price": 30});
      //    // showSnackBar(context, 'helloo');
      //   },
      //   child: Icon(Icons.add),
      //   backgroundColor: Colors.blue,
      // ),
    );
  }
}
