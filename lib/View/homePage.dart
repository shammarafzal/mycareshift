import 'package:becaring/Controllers/me_controller.dart';
import 'package:becaring/View/account.dart';
import 'package:becaring/View/myDay.dart';
import 'package:becaring/View/earnings.dart';
import 'package:becaring/View/feedback.dart';
import 'package:becaring/View/rewards.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'VideosViewer/VideosScreen.dart';
import 'calenderView.dart';
import 'helpScreen.dart';
import 'inbox_list.dart';
import 'notifications.dart';
import 'offerScreen.dart';
import 'offerScreenDrawer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final MeController meController = Get.put(MeController());
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: My Day',
      style: optionStyle,
    ),
    Text(
      'Index 1: Offers',
      style: optionStyle,
    ),
    Text(
      'Index 2: Inbox',
      style: optionStyle,
    ),
    Text(
      'Index 3: Notifications',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  //
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => !Navigator.of(context).userGestureInProgress,
      child: Scaffold(
        appBar: new AppBar(
          elevation: 0.0,
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        drawer: new Drawer(
            child: ListView(
              children: <Widget>[
                      Obx(() {
                        return UserAccountsDrawerHeader(
                        currentAccountPicture: CircleAvatar(
                          backgroundImage: AssetImage("assets/logo-app.png"),

                        ),
                        accountName: Text(meController.meList[0].name,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                        accountEmail: Text(meController.meList[0].email),
                        decoration: new BoxDecoration(color: Colors.blue),
                      );
                      }),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: ListTile(
                    title: Text('Home'),
                    leading: Icon(Icons.home, color: Colors.blue),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) =>
                              OfferScreenDrawer()
                      ),
                    );
                  },
                  child: ListTile(
                    title: Text('Offers'),
                    leading: Icon(Icons.local_offer_outlined, color: Colors.blue),
                  ),
                ),
                Divider(),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) =>
                              TableEventsExample()
                      ),
                    );
                  },
                  child: ListTile(
                    title: Text('Calender'),
                    leading: Icon(Icons.calendar_today_outlined, color: Colors.blue),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) =>
                              EarningCardList()
                      ),
                    );
                  },
                  child: ListTile(
                    title: Text('Earnings'),
                    leading: Icon(Icons.monetization_on_outlined, color: Colors.blue),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) =>
                              RewardsScreen()
                      ),
                    );
                  },
                  child: ListTile(
                    title: Text('Rewards'),
                    leading: Icon(Icons.stars_rounded, color: Colors.blue),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                        builder: (context) =>
                        new AccountPage(),
                      ),
                    );
                  },
                  child: ListTile(
                    title: Text('Account'),
                    leading: Icon(Icons.account_box_outlined, color: Colors.blue),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) =>
                              VideosViewer()
                      ),
                    );
                  },
                  child: ListTile(
                    title: Text('Videos'),
                    leading: Icon(Icons.video_collection_sharp, color: Colors.blue),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) =>
                            HelpCardList()
                    ),
                  );
                  },
                  child: ListTile(
                    title: Text('Help'),
                    leading: Icon(Icons.help_center_outlined, color: Colors.blue),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) =>
                              FeedBack()
                      ),
                    );
                  },
                  child: ListTile(
                    title: Text('Feedback'),
                    leading: Icon(Icons.feedback_outlined, color: Colors.blue),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed('/login');
                  },
                  child: ListTile(
                    title: Text('Logout'),
                    leading: Icon(Icons.logout, color: Colors.blue),
                  ),
                ),
              ],
            )
        ),
        body: new IndexedStack(
          index: _selectedIndex,
          children: <Widget>[
            MyDayCardList(),
            OfferCardList(),
            ChatList(),
            NotificationList(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'My Day',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_offer_outlined),
              label: 'Offers',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble_rounded),
              label: 'Inbox',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: 'Notifications',
            ),
          ],
          currentIndex: _selectedIndex,
          showUnselectedLabels: true,
          selectedItemColor: Colors.blueAccent,
          onTap: _onItemTapped,
          unselectedItemColor: Colors.grey,
        ),
      ),
    );
  }
}
