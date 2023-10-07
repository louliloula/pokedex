import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/logic/pokemondetail_cubit.dart';
import 'package:pokedex/repository/pokemon_repository.dart';
import 'package:pokedex/screen/favoritepokemonlist.dart';

import '../logic/pokemondetail_state.dart';
import '../model/pokemon.dart';
import '../model/pokemon_type.dart';

class PokemonDetailScreen extends StatelessWidget {
  const PokemonDetailScreen(
      {super.key, required this.pokemon, required this.repository});

  final PokemonRepository repository;
  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PokemonDetailCubit(repository, pokemon),
      child: Material(
        child: Padding(
          padding: const EdgeInsets.only(top: 45,left: 15),
          child: BlocBuilder<PokemonDetailCubit, PokemonDetailState>(
              builder: (blocContext, state) {
            if (state is PokemonDetail) {
              return Column(
                children: [
                  Row(
                    children: [
                      Hero(
                        tag: 'pokemon-${pokemon.nationalId}',
                        child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.arrow_back, color: Colors.blueGrey,)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Center(
                     child: Padding(
                       padding: EdgeInsets.only(right: 15),
                      child: Card(
                        child: Column(
                          children: [
                            Align(
                                alignment: Alignment.topRight,
                                child: IconButton(
                                  icon: Icon(
                                  state.isFavorite
                                        ? Icons.favorite
                                        :Icons.favorite_border,
                                    color: state.isFavorite
                                        ? Colors.red
                                        : Colors.blueGrey,
                                  ),
                                  onPressed: () {
                                    blocContext
                                        .read<PokemonDetailCubit>()
                                        .displayPokemon();

                                  },
                                )
                            ),

                            Image(image: NetworkImage(state.pokemon.imageUrl!),fit: BoxFit.fill,),
                            Text(state.pokemon.name!,
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Divider(
                              thickness: 3,
                              color: Colors.black12,
                            ),
                            SizedBox(
                              height: 11,
                            ),
                            // Text(pokemonDetail.types!.join(" - "),
                            //     style: TextStyle(fontWeight: FontWeight.bold)),
                            SizedBox(
                              height: 20,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: state.pokemon.types!.length,
                                  itemBuilder: (context, index) {
                                    return PokemonTypeChip(
                                        type: state.pokemon.types![index]);
                                  }),
                            ),
                            SizedBox(
                              height: 11,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 13, right: 13, bottom: 15),
                              child: Text(
                                state.pokemon.description!,
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return Text("Erreur");
            }
          }),
        ),
      ),
    );
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
