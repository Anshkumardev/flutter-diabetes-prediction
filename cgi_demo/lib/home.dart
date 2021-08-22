import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late var pregnancy;
  late var glucose;
  late var bp;
  late var skinThickness;
  late var insulin;
  late var BMI;
  late var DPF;
  late var age;

  final fieldText = TextEditingController();
  late String output = "";

  void clearText() {
    fieldText.clear();
  }

  func() async {
    var r = await http.get(Uri.http("18.221.23.189", "/cgi-bin/diabetes.py", {
      "pregnancy": pregnancy,
      "glucose": glucose,
      "bp": bp,
      "skinThickness": skinThickness,
      "insulin": insulin,
      "BMI": BMI,
      "DPF": DPF,
      "age": age
    }));
    print(r.body);
    setState(() {
      output = r.body;
    });
  }

  _predictionbottomsheet(String output) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            height: MediaQuery.of(context).size.height * .60,
            child: Column(
              children: [
                Row(
                  children: [
                    Spacer(),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(Icons.cancel),
                      color: Colors.purple.shade900,
                    )
                  ],
                ),
                Text(
                  "Result",
                  style: TextStyle(fontSize: 18),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Text(
                    output,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 26,
                        color: Colors.purple.shade900,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  "This prediction is 80% accurate and totally based on our dataset.",
                  textAlign: TextAlign.center,
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.grey.shade300,
          child: Column(
            children: [
              Container(
                height: 220,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.purple.shade900,
                  borderRadius: BorderRadius.vertical(
                      bottom: Radius.elliptical(
                          MediaQuery.of(context).size.width, 80.0)),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.all(10),
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: new DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage("assets/images/logo.png"),
                                )
                                // borderRadius: BorderRadius.circular(100),
                                // color: Colors.blue),
                                ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              "Diabetes Diagnosis",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: IconButton(
                              alignment: Alignment.centerLeft,
                              onPressed: () {},
                              icon: Icon(
                                Icons.info,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Card(
                          color: Colors.grey.shade300,
                          margin: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container(
                            padding: EdgeInsets.all(10),
                            width: double.infinity,
                            height: 70,
                            child: Text(
                              "This Application is based on machine learning and have an accuracy of 80%. Click on the info button at top right corner to know more about inputs.",
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Container(
                      child: Text(
                        "Pregnancy count",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      margin: EdgeInsets.fromLTRB(20, 5, 0, 0))
                ],
              ),
              Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Container(
                  height: 50,
                  padding: EdgeInsets.all(5),
                  width: double.infinity,
                  child: Center(
                    child: TextField(
                      onChanged: (value) {
                        pregnancy = value;
                      },
                      decoration: InputDecoration(
                          hintText: "0", border: InputBorder.none),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Container(
                    child: Text(
                      "Glucose",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                  ),
                ],
              ),
              Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.white70, width: 1),
                  borderRadius: BorderRadius.circular(0),
                ),
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Container(
                  height: 50,
                  padding: EdgeInsets.all(5),
                  width: double.infinity,
                  child: Center(
                    child: TextField(
                      onChanged: (value) {
                        glucose = value;
                      },
                      decoration: InputDecoration(
                          hintText: "Plasma glucose concentration",
                          border: InputBorder.none),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Container(
                    child: Text(
                      "Diastolic blood pressure",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                  ),
                ],
              ),
              Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Container(
                  height: 50,
                  padding: EdgeInsets.all(5),
                  width: double.infinity,
                  child: Center(
                    child: TextField(
                      onChanged: (value) {
                        bp = value;
                      },
                      decoration: InputDecoration(
                          hintText: "mm Hg", border: InputBorder.none),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Container(
                    child: Text(
                      "Skin Thickness",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                  ),
                ],
              ),
              Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Container(
                  height: 50,
                  padding: EdgeInsets.all(5),
                  width: double.infinity,
                  child: Center(
                    child: TextField(
                      onChanged: (value) {
                        skinThickness = value;
                      },
                      decoration: InputDecoration(
                          hintText: "Triceps skin fold thickness (mm)",
                          border: InputBorder.none),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Container(
                    child: Text(
                      "Insulin",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                  ),
                ],
              ),
              Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Container(
                  height: 50,
                  padding: EdgeInsets.all(5),
                  width: double.infinity,
                  child: Center(
                    child: TextField(
                      onChanged: (value) {
                        insulin = value;
                      },
                      decoration: InputDecoration(
                          hintText: "2-Hour serum insulin (mu U/ml)",
                          border: InputBorder.none),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Container(
                    child: Text(
                      "BMI",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                  ),
                ],
              ),
              Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Container(
                  height: 50,
                  padding: EdgeInsets.all(5),
                  width: double.infinity,
                  child: Center(
                    child: TextField(
                      onChanged: (value) {
                        BMI = value;
                      },
                      decoration: InputDecoration(
                          hintText: "BMI (weight in kg/(height in m)^2)",
                          border: InputBorder.none),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Container(
                    child: Text(
                      "Diabetes pedigree function",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                  ),
                ],
              ),
              Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Container(
                  height: 50,
                  padding: EdgeInsets.all(5),
                  width: double.infinity,
                  child: Center(
                    child: TextField(
                      onChanged: (value) {
                        DPF = value;
                      },
                      decoration: InputDecoration(
                          hintText: "Diabetes pedigree function",
                          border: InputBorder.none),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Container(
                    child: Text(
                      "Age",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                  ),
                ],
              ),
              Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                margin: EdgeInsets.fromLTRB(20, 5, 20, 25),
                child: Container(
                  height: 50,
                  padding: EdgeInsets.all(5),
                  width: double.infinity,
                  child: Center(
                    child: TextField(
                      onChanged: (value) {
                        age = value;
                      },
                      decoration: InputDecoration(
                          hintText: "Age (years)", border: InputBorder.none),
                    ),
                  ),
                ),
              ),
              FloatingActionButton.extended(
                splashColor: Colors.purple.shade900,
                backgroundColor: Colors.red.shade900,
                onPressed: () {
                  func();
                  _predictionbottomsheet(output);
                  clearText();
                },
                icon: Icon(Icons.search),
                label: Text("Diagnose"),
              ),
              SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
