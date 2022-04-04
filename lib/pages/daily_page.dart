// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter/rendering.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:test_app/json/daily_json.dart';
import 'package:test_app/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:test_app/widget/calender.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:test_app/json/users.dart';

class DailyPage extends StatefulWidget {
  @override
  _DailyPageState createState() => _DailyPageState();
}

List<bool> chipState = List.filled(users.length, false);
List getFilterList() {
  List flist = [];
  for (int i = 0; i < chipState.length; i++) {
    if (chipState[i]) {
      String user = users[i]['user'];
      flist.addAll(daily
          .where((element) => element['user'].toString().contains(user))
          .toList());
    }
  }
  return flist;
}

class _DailyPageState extends State<DailyPage> {
  int activeDay = 3;
  List filteredList = daily;
  @override
  Widget build(BuildContext context) {
    // print(filteredList.length);
    return Scaffold(
      backgroundColor: grey.withOpacity(0.05),
      body: getBody(),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    //get user chips from the json file
    List<FilterChip> userChips() {
      List<FilterChip> chips = [];
      for (var _index = 0; _index < users.length; _index++) {
        FilterChip chip = FilterChip(
            selected: chipState[_index],
            label: Text(users[_index]['fname']),
            avatar: const CircleAvatar(
              foregroundImage: AssetImage("assets/images/profile.png"),
            ),
            onSelected: (bool value) {
              setState(() {
                chipState[_index] = value;
                filteredList =
                    chipState.reduce((value, element) => value || element)
                        ? getFilterList()
                        : daily;
              });
            });
        chips.add(chip);
      }
      return chips;
    }

//main body
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            //height: size.height * 0.58,
            decoration: BoxDecoration(color: white, boxShadow: [
              BoxShadow(
                color: grey.withOpacity(0.01),
                spreadRadius: 10,
                blurRadius: 3,
                // changes position of shadow
              ),
            ]),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 60, right: 20, left: 20, bottom: 25),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Daily Transaction",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: black),
                      ),
                      IconButton(
                          onPressed: () {
                            print('pressed');
                          },
                          icon: Icon(AntDesign.search1))
                    ],
                  ),
                 const  SizedBox(
                    height: 10,
                  ),
                   Container(child: Calender_Widget()),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Card(
              child: Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: grey.withOpacity(0.01),
                        spreadRadius: 10,
                        blurRadius: 3,
                        // changes position of shadow
                      ),
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Members:",
                      style: TextStyle(fontWeight: FontWeight.w400),
                    ),
                    LayoutGrid(
                      columnSizes: [auto, auto, auto],
                      rowSizes: [auto, auto],
                      children: userChips(),
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 0,
            child: Container(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                  children: List.generate(filteredList.length, (index) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: (size.width - 40) * 0.40,
                              child: Row(
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: grey.withOpacity(0.1),
                                    ),
                                    child: Center(
                                      child: Image.asset(
                                        filteredList[index]['icon'],
                                        width: 30,
                                        height: 30,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Container(
                                    width: (size.width - 40) * 0.20,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          filteredList[index]['name'],
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: black,
                                              fontWeight: FontWeight.w500),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          filteredList[index]['date'],
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: black.withOpacity(0.5),
                                              fontWeight: FontWeight.w400),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          filteredList[index]['user'],
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: black.withOpacity(0.5),
                                              fontWeight: FontWeight.w400),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              width: (size.width - 40) * 0.20,
                              child: Text(
                                "This is a description ",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            Container(
                              width: (size.width - 40) * 0.3,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    filteredList[index]['price'],
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15,
                                        color: Colors.green),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.only(left: 65, top: 8),
                        //   child: Divider(
                        //     thickness: 0.8,
                        //   ),
                        // )
                      ],
                    ),
                  ),
                );
              })),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              children: [
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 80),
                  child: Text(
                    "Total",
                    style: TextStyle(
                        fontSize: 16,
                        color: black.withOpacity(0.4),
                        fontWeight: FontWeight.w600),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(
                    "\$1780.00",
                    style: TextStyle(
                        fontSize: 20,
                        color: black,
                        fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}
