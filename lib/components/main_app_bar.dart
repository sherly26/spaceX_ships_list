import 'package:flutter/material.dart';
import 'package:ji_mobile_app/components/search.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String titleKey;

  const MainAppBar({this.titleKey = 'Interview'});

  @override
  Size get preferredSize => Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return Container(padding: EdgeInsets.only(top: statusBarHeight), child: _buildMainAppBar(context));
  }

  Widget _buildMainAppBar(BuildContext context) {
    return Container(
      key: ValueKey('main-appbar-container'),
      alignment: Alignment.center,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.blue,
        padding: EdgeInsets.symmetric(horizontal: 35),
        child: Row(
          children: <Widget>[
            _buildTileContent(context),
            _buildSearchBar(context)
          ],
        ),
      ),
    );
  }

  Widget _buildTileContent(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
                width: double.infinity,
                child: Text('Naves', textAlign: TextAlign.left, style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)))
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.search, size: 30, color: Colors.white),
        onPressed: () {
          showSearch(context: context, delegate: Search());
        });
  }
}
