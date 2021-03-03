import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;


var format = DateFormat.yMd('ar');
var dateString = format.format(DateTime.now());

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Forfaits Voyages',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: AccueilForfaitsVoyages(title: 'Forfaits Voyages'),
    );
  }
}

class AccueilForfaitsVoyages extends StatefulWidget {
  AccueilForfaitsVoyages({Key key, this.title}) : super(key: key);

  final String title;

  @override
  AccueilForfaitsVoyagesState createState() => AccueilForfaitsVoyagesState();
}

class AccueilForfaitsVoyagesState extends State<AccueilForfaitsVoyages> {
   Future<List<Forfait>> futursForfaits;

  initState() {
    super.initState();
    futursForfaits = _fetchForfaits();
  }

/*
class AccueilForfaitsVoyagesState extends State<AccueilForfaitsVoyages> {
  List<Forfait> forfaits = [];

  initState() {
    super.initState();
    Iterable list = json.decode('[{"_id":"6000ff360efa3fd999621bed","destination":"Jamaïque","villeDepart":"Montreal", "hotel":{"nom":"Hotel #6","coordonnees":"...","nombreEtoiles":1,"nombreChambres":1,"caracteristiques":["Face à la plage","Miniclub"]},"dateDepart":"2021-01-01","dateRetour":"2021-01-08","dateDepartD":"2020-01-01T00:00:00.000Z","dateRetourD":"2020-01-08T00:00:00.000Z","prix":300,"rabais":0,"vedette":true,"image" : "", "da":"0000000"},{"_id":"6000ff370efa3fd999621c03","destination":"Alaska","villeDepart":"Montreal","hotel":{"nom":"Hotel #6","coordonnees":"...","nombreEtoiles":1,"nombreChambres":1,"caracteristiques":["Face à la plage","Miniclub"]},"dateDepart":"2021-01-01","dateRetour":"2021-01-08","dateDepartD":"2020-01-01T00:00:00.000Z","dateRetourD":"2020-01-08T00:00:00.000Z","prix":300,"rabais":0,"vedette":true,"image" : "", "da":"0000000"},{"_id":"6000ff380efa3fd999621c19","destination":"Japon","villeDepart":"Montreal","hotel":{"nom":"Hotel #6","coordonnees":"...","nombreEtoiles":1,"nombreChambres":1,"caracteristiques":["Face à la plage","Miniclub"]},"dateDepart":"2021-01-01","dateRetour":"2021-01-08","dateDepartD":"2020-01-01T00:00:00.000Z","dateRetourD":"2020-01-08T00:00:00.000Z","prix":300,"rabais":0,"vedette":true,"image" : "", "da":"0000000"},{"_id":"6000ff390efa3fd999621c2f","destination":"Cuba","villeDepart":"Montreal","hotel":{"nom":"Hotel #6","coordonnees":"...","nombreEtoiles":1,"nombreChambres":1,"caracteristiques":["Face à la plage","Miniclub"]},"dateDepart":"2021-01-01","dateRetour":"2021-01-08","dateDepartD":"2020-01-01T00:00:00.000Z","dateRetourD":"2020-01-08T00:00:00.000Z","prix":300,"rabais":0,"vedette":false,"image" : "", "da":"0000000"},{"_id":"6000ff3a0efa3fd999621c45","destination":"Cuba","villeDepart":"Montreal","hotel":{"nom":"Hotel #7","coordonnees":"...","nombreEtoiles":2,"nombreChambres":20,"caracteristiques":[]},"dateDepart":"2021-01-01","dateRetour":"2021-01-08","dateDepartD":"2020-01-01T00:00:00.000Z","dateRetourD":"2020-01-08T00:00:00.000Z","prix":3000,"rabais":0,"vedette":false,"image" : "", "da":"0000000"},{"_id":"6000ff3c0efa3fd999621c5b","destination":"Cuba","villeDepart":"Montreal","hotel":{"nom":"Hotel #8","coordonnees":"...","nombreEtoiles":3,"nombreChambres":300,"caracteristiques":["Face à la plage","Miniclub","..."]},"dateDepart":"2021-01-01","dateRetour":"2021-01-08","dateDepartD":"2020-01-01T00:00:00.000Z","dateRetourD":"2020-01-08T00:00:00.000Z","prix":30000,"rabais":100,"vedette":false,"image" : "", "da":"0000000"},{"_id":"6000ff3e0efa3fd999621c71","destination":"Costa Rica","villeDepart":"Québec","hotel":{"nom":"Hotel #6","coordonnees":"...","nombreEtoiles":1,"nombreChambres":1,"caracteristiques":["Face à la plage","Miniclub"]},"dateDepart":"2021-01-01","dateRetour":"2021-01-08","dateDepartD":"2020-01-01T00:00:00.000Z","dateRetourD":"2020-01-08T00:00:00.000Z","prix":300,"rabais":0,"vedette":false,"image" : "", "da":"0000000"},{"_id":"6000ff3f0efa3fd999621c87","destination":"Costa Rica","villeDepart":"Québec","hotel":{"nom":"Hotel #7","coordonnees":"...","nombreEtoiles":2,"nombreChambres":20,"caracteristiques":[]},"dateDepart":"2021-01-01","dateRetour":"2021-01-08","dateDepartD":"2020-01-01T00:00:00.000Z","dateRetourD":"2020-01-08T00:00:00.000Z","prix":3000,"rabais":0,"vedette":false,"image" : "", "da":"0000000"},{"_id":"6000ff400efa3fd999621c9d","destination":"Costa Rica","villeDepart":"Québec","hotel":{"nom":"Hotel #8","coordonnees":"...","nombreEtoiles":3,"nombreChambres":300,"caracteristiques":["Face à la plage","Miniclub","..."]},"dateDepart":"2021-01-01","dateRetour":"2021-01-08","dateDepartD":"2020-01-01T00:00:00.000Z","dateRetourD":"2020-01-08T00:00:00.000Z","prix":30000,"rabais":100,"vedette":false,"image" : "", "da":"0000000"}]');
    forfaits = list.map((model) => Forfait.fromJson(model)).toList();
  }
*/
  Widget build(BuildContext context) {
    return FutureBuilder<List<Forfait>>(
      future: futursForfaits,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
              appBar: AppBar(
                title: Text(widget.title),
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:
                  <Widget>[
                    Card(
                      child: Image(
                        image: NetworkImage('https://images.pexels.com/photos/3601422/pexels-photo-3601422.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260'),
                      ),

                    ),
                    new Padding(padding: EdgeInsets.only(right: 10.0)),
                    new Container(
                        child: new Row (
                          children: <Widget>[
                            Container(


                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.only(bottom: 12.0, top:12.0,right: 12.0 ),
                                        child:
                                        Text( 'Voyage tout inclus : Forfait et voyage sud tout inclus',
                                          style: TextStyle(
                                            fontSize: 11.0,
                                            color: Colors.grey[500],
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ), Text(
                                        '        Réserver un forfait vacances, un séjour tout-compris!',

                                        style: TextStyle(
                                          fontSize: 19.0,
                                          color: Colors.pink[300],
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 8.0),
                                      RaisedButton(
                                        color: Colors.deepPurple[100],
                                        child: Text('Réserver maintenant',
                                        style: TextStyle(
                                          color: Colors.deepPurple[400],
                                          fontWeight: FontWeight.bold,
                                        ),
                                        ),
                                        onPressed: () {print('button pressed');},
                                      ),
                                      new Padding(padding: EdgeInsets.only(top: 13.0)),

                                      Text( ' Découvrez toutes les destinations Sud offertes ',
                                        style: TextStyle(
                                          fontSize: 11.0,
                                          color: Colors.grey[500],
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text( 'Et vous serez assuré de vivre des vacances inoubliables à la hauteur de vos attentes',
                                        style: TextStyle(
                                          fontSize: 11.0,
                                          color: Colors.grey[500],
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),

                                      Container(
                                          color: Colors.red,
                                          child: SizedBox(
                                            height: 30.0,
                                          )
                                      )

                                    ]

                                )
                            )
                          ],



                        )
                    ),
                    new Padding(padding: EdgeInsets.only(right: 10.0)),
                    Expanded(
                        child: ListView.builder(
                            itemCount: snapshot.data?.length,
                            itemBuilder: (context, index) {
                              return
                                new Card(
                                    child:
                                    new Container(
                                        padding: EdgeInsets.all(8.0),
                                        child: new Row(
                                            children: [
                                              new CircleAvatar(child: new Icon(Icons.card_travel ,color: Colors.deepPurple[50],)),
                                              new Padding(padding: EdgeInsets.only(right: 10.0)),
                                              Text(snapshot.data[index].hotel.nom ?? '',
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.deepPurple[600],
                                                ),),
                                              new Padding(padding: EdgeInsets.only(right: 6)),
                                              Text('Destination: ' +  snapshot.data[index].destination?? '',
                                                style: TextStyle(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.pink[400],
                                                ),),
                                              new Padding(padding: EdgeInsets.only(right: 10)),
                                              Text(new DateFormat('yyyy-MM-dd').format(snapshot.data[index].dateDepart),
                                                style: TextStyle(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey[400],
                                                ),
                                              ),
                                              new Padding(padding: EdgeInsets.only(right: 5.0)),
                                              Text(new NumberFormat('a partir de:  ').format(snapshot.data[index].prix)+ " dollars,",
                                                style: TextStyle(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey[500],
                                                ),
                                              ),
                                              new Padding(padding: EdgeInsets.only(right: 4.0)),
                                              Text(new NumberFormat('').format(snapshot.data[index].hotel.nombreEtoiles),
                                                style: TextStyle(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.yellow[600],
                                                ),
                                              ),
                                              Icon(
                                                Icons.star,
                                                color: Colors.yellow[600],
                                              ),

                                              new Padding(padding: EdgeInsets.only(right: 4.0)),
                                              Icon(
                                                Icons.share,
                                                color: Colors.deepPurple[100],
                                              ),

                                            ]
                                          //children
                                        )));
                            }))

                  ],
                ),
              )
          ); // Cette partie a été comprimée dans les notes pour une meilleure visibilité
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator();
      },
    );
  }
}



class Forfait {
  final String id;
  final String destination;
  final String villeDepart;
  final DateTime dateDepart;
  final DateTime dateRetour;
  final String image;
  final int prix;
  final int rabais;
  final bool vedette;
  final Hotel hotel;

  Forfait({this.id, this.destination, this.villeDepart, this.hotel, this.dateDepart, this.dateRetour, this.image, this.prix, this.rabais, this.vedette});

  factory Forfait.fromJson(Map<String, dynamic> json) {
    return Forfait(
      id: json['_id'],
      destination: json['destination'],
      dateDepart: DateTime.parse("2021-01-01"), //DateTime.parse(json['dateDepartD']),
      dateRetour: DateTime.parse("2021-01-01"), //DateTime.parse(json['dateRetourD']),
      image: json['image'],
      prix: json['prix'],
      rabais: json['rabais'],
      vedette: json['vedette'],
      hotel:Hotel.fromJson(json['hotel']),

    );
  }

}

class Hotel {
  final String nom;
  final String coordonnees;
  final int nombreEtoiles;
  final int nombreChambres;
  final List<String> caracteristiques;

  Hotel({this.nom, this.coordonnees, this.nombreEtoiles, this.nombreChambres, this.caracteristiques});

  factory Hotel.fromJson(Map<String, dynamic> json) {
    return Hotel(
        nom:json['nom'],
        coordonnees:json['coordonnees'],
        nombreEtoiles: json['nombreEtoiles'],
        nombreChambres: json['nombreChambres'],
        caracteristiques: new List<String>.from(json['caracteristiques'])
    );
  }
}


Future<List<Forfait>> _fetchForfaits() async {
  final response = await http.get(Uri.https('forfaits-voyages.herokuapp.com', '/api/forfaits/da/1996458', {}));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((forfait) => new Forfait.fromJson(forfait)).toList();
  } else {
    throw Exception('Erreur de chargement des forfaits');
  }
}

