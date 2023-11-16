import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/logic/pokemonhome_state.dart';
import 'package:pokedex/screen/pokemondetail_screen.dart';
import 'package:pokedex/usecase/pokemon_usecase.dart';

import '../logic/pokemonhome_cubit.dart';
import '../model/pokemon.dart';
import '../model/pokemonWrapper.dart';
import '../repository/pokemon_repository.dart';
import 'package:google_fonts/google_fonts.dart';

class PokemonHomeScreen extends StatelessWidget {
  final PokemonUseCase useCase;

  const PokemonHomeScreen({super.key, required this.useCase});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => PokemonHomeCubit(useCase)
          ..displayHomePage(),
        child: BlocBuilder<PokemonHomeCubit, PokemonHomeState>(
          builder: (blocContext, state) {
            if (state is PokemonLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is GenerateHomeScreenSucessfully) {
              return Container(
               decoration: const BoxDecoration(
                 gradient: LinearGradient(
                   begin: AlignmentDirectional.center,
                   end: AlignmentDirectional.bottomCenter,
                   colors:<Color>[
                     Colors.white,
                     Colors.blueGrey,

                   ]
                 ),
               ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 15, top: 35),
                      child: Text(
                        "Pokemon of the day",
                        style: GoogleFonts.cabinSketch(textStyle: TextStyle(fontSize:25,color: Colors.blueGrey ))
                            //TextStyle(fontSize: 20, fontFamily: 'RobotoMono',color: Colors.blueGrey),
                      ),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Card(
                        color: Colors.white,
                        elevation: 5,
                        shadowColor: Colors.grey,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Image.network(
                              state.randomPokemon.pokemon.imageUrl!,
                              height: 180,
                              width: 90,
                            ),
                            Expanded(
                                child: ListTile(
                              title: Padding(
                                padding: const EdgeInsets.only(bottom: 8.0,top: 5),
                                child:
                                    Text('Name : ${state.randomPokemon.pokemon.name}',style: GoogleFonts.specialElite(),),
                              ),
                              subtitle:
                                  Text('${state.randomPokemon.pokemon.description}',style: GoogleFonts.specialElite(),),
                            ))
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 35),
                     Padding(
                      padding: EdgeInsets.only(bottom:18,left: 15),
                        child: Text("My pokemons",style: GoogleFonts.cabinSketch(textStyle: TextStyle(fontSize: 25, color: Colors.blueGrey)),
                        //TextStyle(fontSize: 20,color: Colors.blueGrey,),
                        ),
                      ),

                    MyPokemonCard(
                        myPokemonWrapper: state.myRandomPokemonsList,useCase: useCase,)
                  ],
                ),
              );
            } else if (state is HomeScreenMessageError) {
              return Text(state.errorMessage);
            } else {
              return const Text("Aucune donnée disponible");
            }
          },
        ));
  }
}

class MyPokemonCard extends StatelessWidget {
  final List<PokemonWrapper> myPokemonWrapper;

  final PokemonUseCase useCase;

  MyPokemonCard({super.key, required this.myPokemonWrapper, required this.useCase});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
          //height: 200,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: AlignmentDirectional.topCenter,
              end: AlignmentDirectional.bottomCenter,
              colors: <Color>[
                Colors.white,
                Colors.redAccent
              ]
            ),
              color: Colors.white,


          ),
          child: Column(
            children: [
               const Padding(
                padding: EdgeInsets.only(top: 13),

               ),
              Expanded(
                  child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 2.5,
                          mainAxisSpacing: 1),
                      itemCount: myPokemonWrapper.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PokemonDetailScreen(
                                        pokemonWrapper: myPokemonWrapper[index],
                                        useCase: useCase,)));
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10, left: 10),
                            child: Card(
                              color: Colors.white,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5)
                                ),
                                  side: BorderSide(color: Colors.blueGrey)),
                              child: ListTile(
                                leading: Image.network(
                                  myPokemonWrapper[index].pokemon.imageUrl!,
                                ),
                                title: Text(
                                  myPokemonWrapper[index].pokemon.name!,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,style: GoogleFonts.specialElite(),
                                ),
                                subtitle: Text(myPokemonWrapper[index].pokemon.types!.join("-"),style: GoogleFonts.specialElite(),),
                              ),
                            ),
                          ),
                        );
                      })),
            ],
          ),
        ),

    );
  }
}
