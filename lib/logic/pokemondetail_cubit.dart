import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/logic/pokemondetail_state.dart';
import 'package:pokedex/repository/pokemon_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/pokemon.dart';

class PokemonDetailCubit extends Cubit<PokemonDetailState> {
  final PokemonRepository repository;
  bool isFavorite=false;
  final Pokemon pokemon;

  PokemonDetailCubit(this.repository, this.pokemon)
      :super(PokemonDetail(false, pokemon));


  // //add methode d'envoie sur liste
  // void favouritePokemon() {
  //   bool isFavorite = false;
  //   isFavorite = !isFavorite;
  //   //repository.updateFavoritePokemon(pokemon);
  //   emit(FavouritePokemonHeart(isFavorite, pokemon));
  // }

  //repository.updateFavoritePokemon(pokemon);


  void displayPokemon() async {
    await repository.updateFavoritePokemon(pokemon);
    isFavorite = !isFavorite;
    print(isFavorite);
    emit(PokemonDetail(isFavorite,pokemon));


  }
}
