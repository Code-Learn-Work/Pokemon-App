import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:pokeapp/pokemon.dart';
import 'package:pokeapp/pokemondetail.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "PokeApp",
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> {

  var url =
"https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";

 PokeHub pokeHub;

  @override
  void initState() {
      super.initState();
      fetchData();
    }

  fetchData() async{
    var res = await http.get(url);
    var deCoded = jsonDecode(res.body);

    pokeHub = PokeHub.fromJson(deCoded);
    setState(() {
          
        });    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Poke App"),
        backgroundColor: Colors.cyan,
      ),
      body: pokeHub == null?Center(child: CircularProgressIndicator(),):GridView.count(
        crossAxisCount: 2,
        children: pokeHub.pokemon.map((poke)=>
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>PokeDetail(
                  pokemon: poke,
                )));
              },
              child: Hero(
                tag: poke.img,
                              child: Card(
                elevation: 3.0,
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    new Container(
                      height: 100.0,
                      width: 100.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(poke.img),
                        )
                      ),
                    ),
                    new Text(poke.name,style: new TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),)
                  ],
                ),
            ),
              ),
          ),)
        ).toList(),
      ),
      drawer: new Drawer(),
      floatingActionButton: new FloatingActionButton(
        onPressed: (){},
        backgroundColor: Colors.cyan,
        child: new Icon(Icons.refresh),
      ),
    );
  }
}