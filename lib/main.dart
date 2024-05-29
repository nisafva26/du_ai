import 'dart:developer';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:alan_voice/alan_voice.dart';
import 'package:simpleflutterapp/home_screen.dart';
import 'package:simpleflutterapp/provider/mobile_plan_provider.dart';

// Import the provider

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => MobilePlanProvider(),
      child: MyApp(),
    ),
  );
}
class MyApp extends StatelessWidget {
  const MyApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Avenir',
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomeWidget(),
    );
  }
}




class MyPlansPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AlanVoice.playText("Hi");
    return Scaffold(
      backgroundColor: Color(0xff53389E),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child:
            AppBar(backgroundColor: Colors.blue, title: const Text('My Plans')),
      ),
      body: Consumer<MobilePlanProvider>(
        builder: (context, provider, child) {
          return ListView.builder(
            itemCount: provider.myPlans.length,
            itemBuilder: (context, index) {
              final plan = provider.myPlans[index];
              return Container(
                child: Column(
                  children: [Text(plan.name)],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
