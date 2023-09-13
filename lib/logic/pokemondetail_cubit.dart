import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/logic/pokemondetail_state.dart';
import 'package:pokedex/repository/pokemon_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/pokemon.dart';

class PokemonDetailCubit extends Cubit<PokemonDetailState> {
  final PokemonRepository repository;

  PokemonDetailCubit(this.repository,this.pokemon)
      :super(const PokemonDetailScreenInitial());
   final Pokemon pokemon;
  //late List<Pokemon> pokemon;
  bool isFavorite = false;



  void favouritePokemon() {
    //gestion du clique sur le pokemon
    //passer d'un etat à un autre

      repository.updateFavoritePokemon(pokemon);
      emit(FavouritePokemonHeart(pokemon, true));
    }
  }

