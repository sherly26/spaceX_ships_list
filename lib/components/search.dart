import 'package:flutter/material.dart';
import 'package:ji_mobile_app/providers/api_provider.dart';
import 'package:provider/provider.dart';
import 'package:sweetsheet/sweetsheet.dart';

class Search extends SearchDelegate {
  String selectedResult = '';

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
          icon: Icon(Icons.close, size: 30, color: Colors.blue),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back, size: 30, color: Colors.blue),
        onPressed: () {
          Navigator.pop(context);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(child: Center(child: Text(selectedResult)));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final provider = Provider.of<ApiProvider>(context, listen: false);
    List<String> shipsList = provider.shipsNameList;
    List<String> suggestionsList = [];
    List<String> recentsSearchList = [];

    recentsSearchList.forEach((element) {
      print(element);
    });
    query.isEmpty ? suggestionsList = recentsSearchList : suggestionsList.addAll(shipsList.where((element) => element.toLowerCase().contains(query.toLowerCase())));
    return ListView.builder(
      itemCount: suggestionsList.length,
      itemBuilder: (context, index) {
        return suggestionsList.isNotEmpty
            ? ListTile(
                title: Text(suggestionsList[index]),
                onTap: () {
                  selectedResult = suggestionsList[index];
                  showResults(context);
                },
              )
            : SweetSheet().show(
                context: context,
                description: Text('No se encontraron resultados.'),
                color: SweetSheetColor.DANGER,
                positive: SweetSheetAction(title: 'Ok', onPressed: () => Navigator.of(context).pop()));
      },
    );
  }
}
