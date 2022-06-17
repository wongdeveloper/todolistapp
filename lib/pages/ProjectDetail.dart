import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ProjectDetail extends StatefulWidget {
  const ProjectDetail({Key? key}) : super(key: key);

  @override
  State<ProjectDetail> createState() => _ProjectDetailState();
}

class _ProjectDetailState extends State<ProjectDetail> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "NULI - Productive App",
      home: Scaffold(
          appBar: AppBar(
            title: const Text('NULI - Productive App'),
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Column(
                children: [
                  Row(children: [
                    Column(
                      children: [
                        Text(
                          "E-Learning App",
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 20, 85, 0),
                          child: Text(
                            "In progress",
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(60, 0, 0, 0),
                      child: CircularPercentIndicator(
                        radius: 40,
                        lineWidth: 12,
                        percent: 0.36,
                        progressColor: Color(0xFFFF5C00),
                        backgroundColor: Color(0xFFBEC5CC),
                        circularStrokeCap: CircularStrokeCap.round,
                        center: const Text(
                          '36%',
                          style: TextStyle(fontSize: 17, color: Colors.black),
                        ),
                      ),
                    )
                  ]),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                    child: Container(
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            decoration: BoxDecoration(
                              color: Color(0xFFD9D9D9),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      child: Text(
                                        "Due Date",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Color(0xFF9A9A9A)),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left: 15),
                                      child: Image.asset(
                                          "assets/nuli/icon/calendar-bluebg.png",
                                          width: 60),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(0, 0, 60, 10),
                                  child: Text(
                                    "17 Apr 22",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            margin: EdgeInsets.only(left: 10),
                            decoration: BoxDecoration(
                              color: Color(0xFFD9D9D9),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      child: Text(
                                        "Pending Task",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Color(0xFF9A9A9A)),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left: 5),
                                      child: Image.asset(
                                          "assets/nuli/icon/file-yellowbg.png",
                                          width: 60),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(0, 0, 140, 10),
                                  child: Text(
                                    "12",
                                    style: TextStyle(
                                        fontSize: 23,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 265, 0),
                          child: const Text(
                            "Description",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                        Container(
                          child: const Text(
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris euismod viverra elit in tristique. Donec dignissim laoreet enim, quis lacinia.",
                            style: TextStyle(fontSize: 15, color: Colors.grey),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 265, 0),
                    child: const Text("List of Task",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}