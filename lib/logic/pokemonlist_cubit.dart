import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/logic/pokemonlist_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/pokemon.dart';
import '../repository/pokemon_repository.dart';

class PokemonListCubit extends Cubit<PokemonListState> {
  final PokemonRepository repository;


  PokemonListCubit(this.repository) :super(const PokemonListScreenInitial());


  late List<Pokemon> _pokemonList;
  late final SharedPreferences _prefs;



  Future<void> loadPokemonList() async {
    emit(PokemonListLoading());
    try {
      _pokemonList = await repository.getPokemonListFromLocal();
      emit(PokemonListLoaded(_pokemonList));
    } catch (e) {
      emit(PokemonListError("Une erreur s'est produite"));
    }
  }

  void filterPokemonList(String value) {
    final List <Pokemon> pokemon = [];
    for (var element in _pokemonList) {
      if (element.name?.toLowerCase().startsWith(value.toLowerCase()) == true) {
        pokemon.add(element);
      }
      if (int.tryParse(value) == element.nationalId) {
        pokemon.add(element);
      }
    }
    emit(PokemonListFilteredScreen(pokemon));
  }

  void filterPokemonListAlphabetically(int sortAZ) {
    List<Pokemon> temp = _pokemonList;
    emit(PokemonListLoading());
    if (sortAZ == 0) {
      var flag = true;
      while (flag) {
        flag = false;
        for (var i = 0; i < temp.length - 1; i ++) {
          if (temp[i].name!.compareTo(temp[i + 1].name!) > 0) {
            flag = true;
            var tempPokemon = temp[i];
            temp[i] = temp[i + 1];
            temp[i + 1] = tempPokemon;
          }
        }
      }

    }
    else if (sortAZ == 1) {
      temp.sort((a, b) =>
          b.name!.compareTo(a.name!));
    }
    else if(sortAZ == 2){

    }
    else if (sortAZ == 3) {
      loadPokemonList();
    }



    emit(PokemonListScreenSortAlphabetically(temp));
  }



}
