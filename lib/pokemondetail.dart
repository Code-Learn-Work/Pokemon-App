import 'package:flutter/material.dart';
import 'package:pokeapp/pokemon.dart';

class PokeDetail extends StatelessWidget {
 
  final Pokemon pokemon;

  PokeDetail({this.pokemon});
  
  bodyWidget(BuildContext context)=>Stack(
    children: <Widget>[
      Positioned(
        height: MediaQuery.of(context).size.height/1.5,
        width: MediaQuery.of(context).size.width-20,
        left: 10.0,
        top: MediaQuery.of(context).size.height*0.1,
              child: new Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)
                ),
          child: new Column( 
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[

              SizedBox(height: 90.0,), 

              new Text(pokemon.name,style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold),),
              new Text("Height: ${pokemon.height}"),
              new Text("Weight: ${pokemon.weight}"),
              new Text("Types",style: TextStyle(fontWeight: FontWeight.bold),),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: pokemon.type.map((t)=>FilterChip(
                  backgroundColor: Colors.amber,
                  label: Text(t),
                  onSelected: (b){},
                )).toList(),
              ),
              Text("Weakness",style: TextStyle(fontWeight: FontWeight.bold)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: pokemon.weaknesses.map((n)=>FilterChip(
                  backgroundColor: Colors.red,
                  label: Text(n,style: TextStyle(color: Colors.white),),
                  onSelected: (b){},
                )).toList(),
              ),
              Text("Next Evolution",style: TextStyle(fontWeight: FontWeight.bold)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: pokemon.nextEvolution?.map((n) => FilterChip( backgroundColor: Colors.green, label: Text(n.name, style: TextStyle(color: Colors.white),), onSelected: (b){} ))?.toList() ?? [Text('No more evolutions')],
              ),

            ],
          ),
        ),
      ),
      Align(
        alignment: Alignment.topCenter,
        child: Hero(
          tag: pokemon.img,
          child: Container(
            height: 200.0,
            width: 200.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(pokemon.img), 
                fit: BoxFit.cover
              )
              
            ),
          ),
        ),
      )
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      appBar: new AppBar(
        elevation: 0.0,
        title: new Text(pokemon.name),
        backgroundColor: Colors.cyan,
      ),
      body: bodyWidget(context),
    );
  }
}