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
      :super(PokemonDetail(false, pokemon)){
    loadFavorite();
  }


  Future<void> loadFavorite() async {
    final prefs = await SharedPreferences.getInstance();
    isFavorite = prefs.getBool('favorite_${pokemon.sId}') ?? false;
    emit(PokemonDetail(isFavorite, pokemon));
  }


  void displayPokemon() async {
    await repository.updateFavoritePokemon(pokemon);
    isFavorite = !isFavorite;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('favorite_${pokemon.sId}', isFavorite);
    print(isFavorite);
    emit(PokemonDetail(isFavorite,pokemon));


  }
}
