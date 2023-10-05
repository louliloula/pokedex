import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/logic/pokemonhome_state.dart';
import 'package:pokedex/screen/pokemondetail_screen.dart';

import '../logic/pokemonhome_cubit.dart';
import '../model/pokemon.dart';
import '../repository/pokemon_repository.dart';

class PokemonHomeScreen extends StatelessWidget {
  final PokemonRepository repository;


  const PokemonHomeScreen({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PokemonHomeCubit(context.read<PokemonRepository>())
        ..spawnPokemonPerHour(),
      // child: Padding(
      //   padding: EdgeInsets.all(8),
        child: BlocBuilder<PokemonHomeCubit, PokemonHomeState>(
          builder: (blocContext, state) {
            if (state is PokemonLoading) {
              return Center(
                  child: CircularProgressIndicator());
            } else if (state is GeneratorPokemonSucess) {
              return Padding(
                padding: const EdgeInsets.only(top: 25, left: 15, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                      Text(
                        "Bonjour",
                        style:
                            TextStyle( fontSize: 28,fontFamily: 'RobotoMono'),
                      ),
                    SizedBox(
                      height: 25,
                    ),
                    Card(
                      color: Colors.white,
                      elevation: 5,
                      shadowColor: Colors.grey,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Image.network(
                            state.randomPokemon.imageUrl!,
                            height: 180,
                            width: 90,
                          ),
                          Expanded(
                              child: ListTile(
                            title: Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Text('Name : ${state.randomPokemon.name}'),
                            ),
                            subtitle: Text('${state.randomPokemon.description}'),
                          ))
                        ],
                      ),
                    ),

                    SizedBox(height: 25),
                      Container(
                        height: 300,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Text("Mes pokemons",
                                  style:
                                  TextStyle(fontSize:20,),),
                            ),
                            SizedBox(height: 20,),
                            MyPokemonCard(myPokemon:state.myPokemon,repository: repository,),
                          ],

                        ),
                      ),

                  ],
                ),
              );
            } else if (state is GeneratorPokemonError) {
              return Text(state.errorMessage);
            } else {
              return Text("Aucune donnée disponible");
            }
          },
        ));
      //),
    //);
  }
}
 class MyPokemonCard extends StatelessWidget{
   final List<Pokemon> myPokemon;
   final PokemonRepository repository;
  MyPokemonCard({super.key, required this.myPokemon, required this.repository});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2.5,
              mainAxisSpacing: 3
            ),itemCount: myPokemon.length,
            itemBuilder: (context,index){
              return GestureDetector(
                onTap: (){
                  Navigator.push(
                      context,MaterialPageRoute(
                      builder: (context) =>PokemonDetailScreen(pokemon: myPokemon[index], repository: repository))
                  );
                },
                  child: Card(
                    color: Colors.white,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: Colors.blueGrey
                          )
                        ),
                        child: ListTile(
                          leading: Image.network(myPokemon[index].imageUrl!,
                           ),
                          title: Text(myPokemon[index].name!,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,),
                          subtitle: Text(myPokemon[index].types!.join("-")),

                        ),


                  ),


              );
            }));
  }

 }


