import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/logic/pokemonhome_state.dart';
import 'package:pokedex/model/pokemon_type.dart';
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
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10,right: 10),
                    child: Column(
                      children: [
                        _HeaderPokemonHome(randomPokemonName: state.randomPokemon.pokemon.name!,
                            randomPokemonImage: state.randomPokemon.pokemon.imageUrl!,
                            randomPokemonDescription: state.randomPokemon.pokemon.description!),
                        //MyPokemonCard(myPokemonWrapper: state.myRandomPokemonsList, useCase: useCase)
                        _MyPokemonsList(myPokemonsWrapper: state.myRandomPokemonsList,useCase: useCase,)
                      ],
                    ),
                  ),

              );
              /*Container(
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
              );*/
            } else if (state is HomeScreenMessageError) {
              return Text(state.errorMessage);
            } else {
              return const Text("Aucune donnée disponible");
            }
          },
        ));
  }
}

class _HeaderPokemonHome extends StatelessWidget {
  final String randomPokemonName;
  final String randomPokemonImage;
  final String randomPokemonDescription;
  _HeaderPokemonHome({super.key, required this.randomPokemonName, required this.randomPokemonImage, required this.randomPokemonDescription});
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

     return  Container(
       height: screenHeight/2.5,
       width: screenWidth ,
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Padding(
             padding: const EdgeInsets.only(top: 25, bottom: 15),
             child: Text("Pokemon of the day",
                 style: GoogleFonts.cabinSketch(textStyle: TextStyle(fontSize:25,color: Colors.blueGrey ),
                 ),
             ),
           ),
           Card(
             color: Colors.white,
             elevation: 5,
             child: Row(
               children: [
                 Container(
                   height: 150,
                   width: 100,
                   child: Image.network(randomPokemonImage),
                 ),
                 Flexible(
                  flex: 2,
                  child: ListTile(
                    title: Padding(
                      padding: const EdgeInsets.only(bottom: 3),
                      child: Text(randomPokemonName),
                    ),
                    subtitle: Text(randomPokemonDescription),
                  ),
                )

               ],
             )
             ,
           ),

         ],
       ),
     );
  }

}


class _MyPokemonsList extends StatelessWidget{
  final List<PokemonWrapper> myPokemonsWrapper;
  final PokemonUseCase useCase;
  final List<Color> colorsTypes =
  TypeColors.colors.entries.map((color) => color.value).toList();

   _MyPokemonsList({super.key, required this.myPokemonsWrapper, required this.useCase});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: screenHeight/ 2,
      width: screenWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Padding(
             padding: const EdgeInsets.only(bottom: 10),
             child: Text("My pokemons",style: GoogleFonts.cabinSketch(textStyle: TextStyle(fontSize: 25, color: Colors.blueGrey))),
           ),
           Flexible(
             flex: 2,
               child: GridView.builder(
                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                       crossAxisCount: 2,
                       childAspectRatio: 2,
                       mainAxisSpacing: 1),
                   itemCount: myPokemonsWrapper.length,
                   itemBuilder: (context, index) {
                     return GestureDetector(
                       onTap: () {
                         Navigator.push(
                             context,
                             MaterialPageRoute(
                                 builder: (context) => PokemonDetailScreen(
                                   pokemonWrapper: myPokemonsWrapper[index],
                                   useCase: useCase,)));
                       },
                       child: Card(
                         color: Colors.white,
                         shape: const RoundedRectangleBorder(
                             borderRadius: BorderRadius.all(
                                 Radius.circular(5)
                             ),
                             side: BorderSide(color: Colors.blueGrey)),
                         child: Row(
                           children: [
                             Container(
                               height: 50,
                               width: 50,
                               child: Image.network(
                                 myPokemonsWrapper[index].pokemon.imageUrl!,
                               ),
                             ),
                             Flexible(
                               flex: 2,
                               child: ListTile(
                                 title: Text(
                                   myPokemonsWrapper[index].pokemon.name!,
                                   overflow: TextOverflow.ellipsis,
                                   maxLines: 1,style: GoogleFonts.specialElite(),
                                 ),
                                 subtitle: Text(myPokemonsWrapper[index].pokemon.types!.join("-"),style: GoogleFonts.specialElite(textStyle: TextStyle(color:colorsTypes[index] ))),
                                 ),
                               ),

                           ],
                         ),
                       ),
                     );
                   }) )
         ],
      ),

    );
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
                      })
              ),
            ],
          ),
        ),

    );
  }
}
