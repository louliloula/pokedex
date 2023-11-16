import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokedex/logic/pokemondetail_cubit.dart';
import 'package:pokedex/model/pokemonWrapper.dart';
import 'package:pokedex/repository/pokemon_repository.dart';
import 'package:pokedex/screen/favoritepokemonlist_screen.dart';
import 'package:pokedex/usecase/pokemon_usecase.dart';

import '../logic/pokemondetail_state.dart';
import '../model/pokemon.dart';
import '../model/pokemon_type.dart';

class PokemonDetailScreen extends StatelessWidget {
  const PokemonDetailScreen(
      {super.key, required this.pokemonWrapper, required this.useCase});


  final PokemonWrapper pokemonWrapper;
  final PokemonUseCase useCase;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => PokemonDetailCubit(useCase,pokemonWrapper)..init(),
        child: Material(
          child: BlocBuilder<PokemonDetailCubit, PokemonDetailState>(
              builder: (blocContext, state) {
            if (state is PokemonDetail) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 55, right: 5),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_circle_left_outlined,
                            color: Colors.blueGrey,
                            size: 28,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 75),
                          child: Text("POKEMON DETAIL",
                              style: GoogleFonts.cabinSketch(
                                  textStyle: TextStyle(
                                      fontSize: 20, color: Colors.blueGrey))
                              //TextStyle(color: Colors.blueGrey,fontWeight: FontWeight.normal)
                              ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 180,
                          height: 180,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.blueGrey),
                              borderRadius: BorderRadius.circular(15)),
                          child: Stack(
                            children: [
                              Image.network(
                                state.pokemonWrapper.pokemon.imageUrl!,
                                fit: BoxFit.fill,
                              ),
                              Positioned(
                                  left: 135,
                                  bottom: 138,
                                  child: IconButton(
                                    icon: Icon(
                                      state.isFavorite
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: state.isFavorite
                                          ? Colors.red
                                          : Colors.blueGrey,
                                    ),
                                    onPressed: () {
                                      blocContext
                                          .read<PokemonDetailCubit>()
                                          .onClickFavorite();
                                    },
                                  )),
                            ],
                          ),
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Name : ${state.pokemonWrapper.pokemon.name}',
                              style: GoogleFonts.specialElite(fontSize: 15),
                            ),
                            SizedBox(
                              height: 18,
                            ),
                            SizedBox(
                              height: 20,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: state.pokemonWrapper.pokemon.types!.length,
                                  itemBuilder: (context, index) {
                                    return PokemonTypeChip(
                                        type: state.pokemonWrapper.pokemon.types![index]);
                                  }),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  //HeaderPokemonDetail(pokemon: state.pokemon, isFavorite: state.isFavorite,),
                  SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'DESCRIPTION : ${state.pokemonWrapper.pokemon.description!}',
                      style: GoogleFonts.specialElite(fontSize: 15),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25, left: 8),
                    child: Text(
                      'EVOLUTIONS : ',
                      style: GoogleFonts.specialElite(),
                    ),
                  ),
                ],
              );
            } else {
              return Text("Vide");
            }
          }),
          //),
        ));
  }
}

class PokemonTypeChip extends StatelessWidget {
  final String type;

  const PokemonTypeChip({required this.type, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      decoration: BoxDecoration(
          color: TypeColors.colors[type],
          borderRadius: BorderRadius.circular(5)),
      child: Text(
        type,
        style: TextStyle(
            color: TypeColors.colors[type]!.computeLuminance() < 0.5
                ? Colors.white
                : Colors.black),
      ),
    );
  }
}

class HeaderPokemonDetail extends StatelessWidget {
  final Pokemon pokemon;
  bool isFavorite;

  HeaderPokemonDetail({super.key, required this.pokemon,required this.isFavorite});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 180,
            height: 180,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.blueGrey),
                borderRadius: BorderRadius.circular(15)),
            child: Stack(
              children: [
                Image.network(
                  pokemon.imageUrl!,
                  fit: BoxFit.fill,
                ),
                Positioned(
                    left: 145,
                    top: 5,
                    child: Icon(
                      Icons.favorite_border,
                      color: Colors.red,
                    )),
                IconButton(onPressed: (){}, icon:Icon(
                   isFavorite ?Icons.favorite : Icons.favorite_border, color:isFavorite ?Colors.red : Colors.blueGrey) )
              ],
            ),
            //Image.network(pokemon.imageUrl!, width: 150),
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Name : ${pokemon.name}'),
              SizedBox(height: 15),
              Text('Type : ${pokemon.types?.join("-")}')
            ],
          ),
        ],
      ),
    );
  }
}
