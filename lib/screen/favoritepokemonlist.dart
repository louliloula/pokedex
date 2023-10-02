import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/logic/favoritepokemon_cubit.dart';
import 'package:pokedex/logic/favoritepokemon_state.dart';
import 'package:pokedex/repository/pokemon_repository.dart';

import '../model/pokemon.dart';

class FavoritePokemonList extends StatelessWidget {
  final PokemonRepository repository;
  final List<Pokemon>? allFavorites;
  const FavoritePokemonList({super.key,required this.repository, this.allFavorites});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context)=>FavoritePokemonCubit(repository),
         child: BlocBuilder<FavoritePokemonCubit,FavoritePokemonState>(
           builder: (blocContext,state) {
             if (state is FavoritePokemonList) {
               return Column(
                 children: [
                   ListView.builder(
                       itemCount: allFavorites?.length ?? 0,
                       itemBuilder: (context, index) {

                       })
                 ],
               );
             }else{
               return Center(
                child: Text("Vous n'avez pas de pokemons favoris")
               );
             }
           }
         ),
    );
  }
}


