import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nuli/dataclass.dart';
import 'package:nuli/pages/ProjectDetail.dart';
import 'package:nuli/pages/TaskDetail.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../dbservices.dart';
import 'all_project.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String user_firstname;
  late String uid;
  int taskCount = 0;

  // String progressMsg(int progressPercentage) {
  //   if (progressPercentage < 50) {
  //     return 'Still a long way to go, you got this!';
  //   } else {
  //     return 'Great, your progress is almost done!';
  //   }
  // }

  String getDateText(Timestamp t) {
    DateTime dt = t.toDate();
    DateFormat formatter = DateFormat('d MMMM y');
    String hasil = formatter.format(dt);
    return hasil;
  }

  DateTime getDate(Timestamp t) {
    DateTime dt = t.toDate();
    return dt;
  }

  String getTimeText(Timestamp t) {
    DateTime dt = t.toDate();
    var hour = dt.hour;
    var mins = dt.minute;

    String hourStr =
        hour < 10 ? hour.toString().padLeft(2, '0') : hour.toString();
    String minsStr =
        mins < 10 ? mins.toString().padLeft(2, '0') : mins.toString();

    String hasil = '${hourStr}:${minsStr}';
    return hasil;
  }

  // void getCurrentUser() async {
  //   userData = await UserService.getUserFromFirestore();
  // }

  @override
  void initState() {
    super.initState();
    var user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      uid = user.uid;
    }
    // getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Color.fromARGB(255, 246, 250, 253),
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const CircleAvatar(
                    radius: 45,
                    backgroundImage: NetworkImage(
                        'https://images.unsplash.com/photo-1484399172022-72a90b12e3c1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80'),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          // StreamBuilder<QuerySnapshot>(
                          //   stream: UserService().getUserFrom
                          // ),
                          // Text(
                          //   'Hello, ${userData.}',
                          //   style: TextStyle(
                          //       fontWeight: FontWeight.bold, fontSize: 16),
                          // ),
                          const Text(
                            '👋',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          const Text('🔥 ', style: TextStyle(fontSize: 12)),
                          StreamBuilder<QuerySnapshot>(
                            stream: TaskService().getData(uid, ""),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return const Text('ERROR');
                              } else if (snapshot.hasData) {
                                taskCount = snapshot.data!.docs.length;

                                if (taskCount == 1) {
                                  Text(
                                      '${taskCount.toString()} task is waiting for you today');
                                } else {
                                  Text(
                                      '${taskCount.toString()} tasks are waiting for you today');
                                }
                              }
                              return Text('0 task for today!');
                            },
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              // Container(
              //   // color: Color.fromRGBO(28, 84, 157, 255),
              //   padding: const EdgeInsets.all(20),
              //   decoration: BoxDecoration(
              //     color: const Color.fromARGB(255, 28, 84, 157),
              //     borderRadius: BorderRadius.circular(12),
              //   ),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Flexible(
              //           child: Text(
              //         progressMsg(72),
              //         style: const TextStyle(
              //             color: Colors.white, fontSize: 18, height: 2),
              //       )),
              //       //circular progress
              //       CircularPercentIndicator(
              //         radius: 50,
              //         lineWidth: 12,
              //         percent: 0.72,
              //         progressColor: const Color.fromARGB(255, 250, 153, 85),
              //         backgroundColor: Colors.white,
              //         circularStrokeCap: CircularStrokeCap.round,
              //         center: const Text(
              //           '72%',
              //           style: TextStyle(fontSize: 20, color: Colors.white),
              //         ),
              //       )
              //     ],
              //   ),
              // ),
              // const SizedBox(
              //   height: 30,
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Projects",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      )),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AllProjectsPage()));
                    },
                    child: const Text("See all",
                        style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 0.6),
                          fontSize: 12,
                        )),
                  )
                ],
              ),
              Container(
                  padding: const EdgeInsets.all(5),
                  child: StreamBuilder<QuerySnapshot>(
                    stream: ProjectService().getData(uid, ""),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return const Text('ERROR');
                      } else if (snapshot.hasData || snapshot.data != null) {
                        return Expanded(
                            child: ListView.separated(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            taskCount = snapshot.data!.docs.length;
                            DocumentSnapshot _data = snapshot.data!.docs[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ProjectDetail(
                                              projectDet: Project(
                                                  projectid: _data['projectid'],
                                                  title: _data['title'],
                                                  deadline: getDate(
                                                      _data['deadline']),
                                                  desc: _data['desc'],
                                                  isdone: _data['isdone'],
                                                  reminder: _data['reminder']),
                                            )));
                              },
                              child: Container(
                                // constraints: BoxConstraints(maxWidth: 270),
                                padding: const EdgeInsets.all(15),
                                decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment(1, -1),
                                        end: Alignment(0, 0),
                                        colors: [
                                          Color.fromARGB(255, 250, 153, 85),
                                          Color.fromARGB(255, 255, 255, 255)
                                        ]),
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 10,
                                      )
                                    ],
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(7))),
                                child: Column(children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        _data['title'],
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Icon(Icons.more_horiz),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text("Progress",
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: Color.fromARGB(
                                                  255, 28, 84, 157))),
                                      const Text("82%",
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: Color.fromARGB(
                                                  255, 28, 84, 157)))
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  LinearPercentIndicator(
                                    padding: const EdgeInsets.all(0),
                                    lineHeight: 7,
                                    percent: 0.63,
                                    progressColor:
                                        const Color.fromARGB(255, 28, 84, 157),
                                    backgroundColor:
                                        const Color.fromARGB(40, 0, 0, 0),
                                    // linearStrokeCap: LinearStrokeCap.roundAll,
                                    barRadius: const Radius.circular(16),
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          "Due " +
                                              getDateText(_data['deadline']),
                                          style: const TextStyle(fontSize: 14)),
                                      const Text("7 days left",
                                          style: TextStyle(
                                              fontSize: 10,
                                              color:
                                                  Color.fromARGB(200, 0, 0, 0)))
                                    ],
                                  ),
                                ]),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 20.0),
                        ));
                      }
                      return const Center(
                        child: Text(
                          'No preview available',
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      );
                    },
                  )),
              const SizedBox(
                height: 30,
              ),
              const Text("Tasks",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  )),
              Container(
                  padding: const EdgeInsets.all(5),
                  child: StreamBuilder<QuerySnapshot>(
                    stream: TaskService().getData(uid, ""),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return const Text('ERROR');
                      } else if (snapshot.hasData || snapshot.data != null) {
                        return Expanded(
                          child: ListView.separated(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              DocumentSnapshot _data =
                                  snapshot.data!.docs[index];
                              return Dismissible(
                                key: Key(_data['taskid']),
                                background: Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  alignment: Alignment.centerLeft,
                                  color: Colors.green,
                                  child: const Text("Done", style: TextStyle(color: Colors.white),),
                                ),
                                secondaryBackground: Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                  alignment: Alignment.centerRight,
                                  color: Colors.red,
                                  child: const Text("Delete", style: TextStyle(color: Colors.white),),
                                ),
                                confirmDismiss: (direction) async {
                                  if (direction ==
                                      DismissDirection.startToEnd) {
                                    final isdone = TaskService()
                                        .toggleTodoStatus(
                                            uid,
                                            Task(
                                                taskid: _data['taskid'],
                                                title: _data['title'],
                                                date_time:
                                                    getDate(_data['date_time']),
                                                reminder: _data['reminder'],
                                                desc: _data['desc'],
                                                isdone: _data['isdone']));
                                    return false;
                                  } else {
                                    TaskService.deleteData(
                                        uid, _data['taskid']);
                                    return false;
                                  }
                                },
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => TaskDetail(
                                                taskDet: Task(
                                                    taskid: _data['taskid'],
                                                    title: _data['title'],
                                                    date_time: getDate(
                                                        _data['date_time']),
                                                    reminder: _data['reminder'],
                                                    desc: _data['desc'],
                                                    isdone: _data['isdone']))));
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(18),
                                    decoration: const BoxDecoration(
                                        gradient: LinearGradient(
                                            begin: Alignment(1, -1),
                                            end: Alignment(0, 0),
                                            colors: [
                                              Color.fromARGB(255, 237, 233, 98),
                                              Color.fromARGB(255, 255, 255, 255)
                                            ]),
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 2,
                                          )
                                        ],
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(14))),
                                    child: Row(
                                      children: [
                                        Checkbox(
                                            activeColor:
                                                Color.fromARGB(255, 71, 221, 0),
                                            checkColor: Colors.white,
                                            shape: CircleBorder(),
                                            value: _data['isdone'],
                                            onChanged: (_) {
                                              final isdone = TaskService()
                                                  .toggleTodoStatus(
                                                      uid,
                                                      Task(
                                                          taskid:
                                                              _data['taskid'],
                                                          title: _data['title'],
                                                          date_time: getDate(
                                                              _data[
                                                                  'date_time']),
                                                          reminder:
                                                              _data['reminder'],
                                                          desc: _data['desc'],
                                                          isdone:
                                                              _data['isdone']));
                                            }),
                                        const SizedBox(width: 12),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(_data['title'],
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                    getDateText(
                                                        _data['date_time']),
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        color: Color.fromARGB(
                                                            178, 0, 0, 0))),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                    getTimeText(
                                                        _data['date_time']),
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        color: Color.fromARGB(
                                                            178, 0, 0, 0))),
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 20.0),
                          ),
                        );
                      }
                      return const Center(
                        child: Text(
                          'No preview available',
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      );
                    },
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
