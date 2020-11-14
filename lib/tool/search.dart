import 'package:flutter/material.dart';
import 'package:flutter_ezansaatleri/Screens/sehirler.dart';
import 'package:flutter_ezansaatleri/models/model_ulke.dart';
import 'package:animations/animations.dart';

final onlycountryname = [];
final suggestions1 = [];
String selected = "";
int theindex;

class DataSearch extends SearchDelegate {
  List<ModelUlke> ulkeler;

  DataSearch({this.ulkeler});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    for (int i = 0; i < ulkeler.length; i++) {
      onlycountryname.add(ulkeler[i].ulkeAdi);
    }

    final suggestions = query.isEmpty
        ? suggestions1
        : onlycountryname
            .where((p) => p.toLowerCase().startsWith(query.toLowerCase()))
            .toSet()
            .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            // showResults(context);
            // selected = suggestions[index];
            // theindex = onlycountryname.indexOf(selected);
            // suggestions1.add(selected);

            print(suggestions[index]);
            print(onlycountryname.indexOf(suggestions[index]));
            print(ulkeler[onlycountryname.indexOf(suggestions[index])].ulkeId);

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Sehirler(
                  UlkeID: ulkeler[onlycountryname.indexOf(suggestions[index])].ulkeId,
                ),
              ),
            );
          },
          title: RichText(
            text: TextSpan(
              text: suggestions[index].substring(0, query.length),
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                  text: suggestions[index].substring(query.length),
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.normal),
                )
              ],
            ),
          ),
          trailing: GestureDetector(
            onTap: () {
              suggestions.removeAt(index);
            },
            child: Icon(Icons.arrow_back_ios),
          ),
        );
      },
    );
  }
}

