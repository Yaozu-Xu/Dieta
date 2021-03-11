import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DietCard extends StatelessWidget {
  const DietCard(
      {@required this.description,
      @required this.name,
      @required this.link,
      @required this.photoUrl});

  final String photoUrl;
  final String name;
  final String description;
  final String link;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(20),
      child: Column(children: <Widget>[
        Container(
            margin: const EdgeInsets.all(20),
            width: MediaQuery.of(context).size.width,
            height: 250,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(photoUrl),
              ),
            )),
        ListTile(
          isThreeLine: true,
          title: Text(name),
          subtitle: Container(
              margin: const EdgeInsets.only(top: 10, bottom: 10),
              child: Text(
                description,
                textAlign: TextAlign.justify,
              )),
          trailing: IconButton(
              icon: const Icon(Icons.link_rounded),
              onPressed: () async {
                if(await canLaunch(link)) {
                  await launch(link);
                }
                
              }),
        )
      ]),
    );
  }
}
