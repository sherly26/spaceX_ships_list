import 'package:flutter/material.dart';
import 'package:ji_mobile_app/components/main_app_bar.dart';
import 'package:ji_mobile_app/models/ship.dart';
import 'package:provider/provider.dart';

import '../providers/api_provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Ship> shipsList = [];
  bool isToggleButtonActive = false;

  @override
  void initState() {
    getApiData();
    super.initState();
  }

  Future getApiData() async {
    List<String> shipsNameList = [];
    final provider = Provider.of<ApiProvider>(context, listen: false);
    final List<Ship> ships = await provider.getApiData();
    ships.forEach((element) {
      shipsNameList.add(element.shipName);
    });
    setState(() {
      shipsList = ships;
      provider.shipsNameList = shipsNameList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: MainAppBar(), body: SingleChildScrollView(child: SafeArea(child: Container(child: _buildBody()))));
  }

  Widget _buildBody() {
    return Column(children: [
      Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text('Ocultar naves inactivas', style: TextStyle(fontSize: 17)), _buildToggleButton()],
        ),
      ),
      ..._handleShipsVisualizationByStatus()
    ]);
  }

  Widget _buildToggleButton() {
    return InkWell(
      onTap: _handleToggleButton,
      child: AnimatedContainer(
          duration: Duration(milliseconds: 400),
          height: 40.0,
          width: 80.0,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0), color: isToggleButtonActive ? Colors.blue[100] : Colors.grey[300]),
          child: Stack(children: [
            AnimatedPositioned(
              duration: Duration(milliseconds: 400),
              curve: Curves.easeIn,
              top: 6.0,
              left: isToggleButtonActive ? 30.0 : 0.0,
              right: isToggleButtonActive ? 0.0 : 30.0,
              child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 400),
                  transitionBuilder: (Widget child, Animation<double> animation) {
                    return RotationTransition(turns: animation, child: child);
                  },
                  child: isToggleButtonActive
                      ? Icon(Icons.check_circle, color: Colors.blue, size: 25, key: UniqueKey())
                      : Icon(Icons.remove_circle_outline, color: Colors.grey, size: 25, key: UniqueKey())),
            ),
          ])),
    );
  }

  List<Widget> _handleShipsVisualizationByStatus() {
    List<ListTile> shipTiles = [];
    isToggleButtonActive
        ? shipsList.forEach((element) {
            if (element.shipStatus == true) {
              shipTiles.add(ListTile(
                  title: Text(element.shipName),
                  leading: Icon(Icons.airplanemode_active, color: Colors.black, size: 35),
                  trailing: Checkbox(
                    value: element.shipStatus,
                    onChanged: null,
                  )));
            }
          })
        : shipsList.forEach((element) {
            shipTiles.add(ListTile(
                title: Text(element.shipName),
                leading: Icon(Icons.airplanemode_active, color: Colors.black, size: 35),
                trailing: Checkbox(
                  value: element.shipStatus,
                  onChanged: null,
                )));
          });
    return shipTiles;
  }

  void _handleToggleButton() {
    setState(() {
      isToggleButtonActive = !isToggleButtonActive;
    });
  }
}
