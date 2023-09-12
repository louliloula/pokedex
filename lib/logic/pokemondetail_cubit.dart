import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/logic/pokemondetail_state.dart';
import 'package:pokedex/repository/pokemon_repository.dart';

import '../model/pokemon.dart';

class PokemonDetailCubit extends Cubit<PokemonDetailState> {
  final PokemonRepository repository;

  PokemonDetailCubit(this.repository)
      :super(const PokemonDetailScreenInitial());

  void favouritePokemon(Pokemon pokemon) {

      pokemon.isFavorite = !pokemon.isFavorite;
      emit(FavouritePokemonHeart(pokemon,pokemon.isFavorite));

    }
}
