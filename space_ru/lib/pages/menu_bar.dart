import 'package:flutter/material.dart';
import 'package:space_ru/models/heading_item.dart';
import 'package:space_ru/models/list_item.dart';
import 'package:space_ru/widgets/card_chat.dart';

class DrawerMenu extends StatefulWidget {
  const DrawerMenu({super.key});

  @override
  State<DrawerMenu> createState() => _DrawerMenuState();
}

List<ListItem> _list = List<ListItem>.generate(
    10, (i) => MessageItem('Sender $i', 'Message body $i'));

class _DrawerMenuState extends State<DrawerMenu> {
  int _selectedIndex = 0;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  List<Widget> _widgetOptions = <Widget>[
    CardExample(items: _list),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(216, 213, 215, 1),
        toolbarHeight: 40.0,
        title: TextField(
          cursorColor: Colors.white,
          decoration: InputDecoration(
              hintText: "Поиск",
              border: InputBorder.none,
              suffixIcon: IconButton(
                icon: Icon(Icons.search),
                color: Color.fromRGBO(61, 60, 61, 1),
                onPressed: () {},
              )),
          style: TextStyle(color: Colors.black, fontSize: 15.0),
        ),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      body: Center(
        child: _widgetOptions[_selectedIndex],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const UserAccountsDrawerHeader(
              // <-- SEE HERE
              decoration: BoxDecoration(color: Colors.grey),
              accountName: Text(
                "Черноусов Валерий",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              accountEmail: Text(
                "valerychernousov@gmail.com",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              currentAccountPicture: FlutterLogo(),
            ),
            ListTile(
              title: const Text('Сообщения'),
              trailing: Icon(Icons.chat),
              selected: _selectedIndex == 0,
              onTap: () {
                // Update the state of the app
                _onItemTapped(0);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Конференции'),
              trailing: Icon(Icons.voice_chat_outlined),
              selected: _selectedIndex == 1,
              onTap: () {
                // Update the state of the app
                _onItemTapped(1);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              trailing: Icon(Icons.settings),
              title: const Text(
                'Настройки',
              ),
              selected: _selectedIndex == 2,
              onTap: () {
                // Update the state of the app
                _onItemTapped(2);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
