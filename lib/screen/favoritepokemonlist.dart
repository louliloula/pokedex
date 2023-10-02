import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/logic/favoritepokemon_cubit.dart';
import 'package:pokedex/logic/favoritepokemon_state.dart';
import 'package:pokedex/repository/pokemon_repository.dart';

import '../model/pokemon.dart';

class FavoritePokemonList extends StatelessWidget {
  final PokemonRepository repository;

  const FavoritePokemonList({super.key,required this.repository});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context)=>FavoritePokemonCubit(repository),
         child: BlocBuilder<FavoritePokemonCubit,FavoritePokemonState>(
           builder: (blocContext,state) {
             if (state is FavoritePokemonList) {
               return FavoriteList(allFavorites:[]);
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

class FavoriteList extends StatelessWidget{
  FavoriteList({super.key,required this.allFavorites});
  final List<Pokemon> allFavorites;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: allFavorites.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title:Text(allFavorites[index].name!),
                );
              }),
        )
      ],
    );
  }

}

