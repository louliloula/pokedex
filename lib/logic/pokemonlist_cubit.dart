import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/logic/pokemonlist_state.dart';
import 'package:pokedex/model/pokemonWrapper.dart';


import '../model/pokemon.dart';
import '../repository/pokemon_repository.dart';
import '../usecase/pokemon_usecase.dart';

class PokemonListCubit extends Cubit<PokemonListState> {

  final PokemonUseCase useCase;


  PokemonListCubit(this.useCase,) : super(const PokemonListScreenInitial());

  late List<PokemonWrapper> _pokemonsWrapperList;

  Future<void> displayPokemonsList() async {
    emit(PokemonListLoading());
    _pokemonsWrapperList =  await useCase.getWrappers() ;
    emit(PokemonListLoaded(_pokemonsWrapperList));
  }

  void pokemonsListFilter(String input) {
    final List<PokemonWrapper> pokemonsFilter = [];
    for (var pokemonWrapper in _pokemonsWrapperList) {
      if (pokemonWrapper.pokemon.name?.toLowerCase().startsWith(input.toLowerCase()) == true) {
        pokemonsFilter.add(pokemonWrapper);
      }
      if (int.tryParse(input) == pokemonWrapper.pokemon.nationalId) {
        pokemonsFilter.add(pokemonWrapper);
      }
    }
    emit(PokemonListLoaded(pokemonsFilter));
  }

  Future<void> listOfPokemonFilterAlphabetically(int popUpMenuValue) async {
    List<PokemonWrapper> sortListAlphabetical = _pokemonsWrapperList;
    emit(PokemonListLoading());
    if (popUpMenuValue == 0) {
      var flag = true;
      while (flag) {
        flag = false;
        for (var i = 0; i < sortListAlphabetical.length - 1; i++) {
          if (sortListAlphabetical[i].pokemon.name!.compareTo(sortListAlphabetical[i + 1].pokemon.name!) > 0) {
            flag = true;
            var tempPokemonInPokemonsList = sortListAlphabetical[i];
            sortListAlphabetical[i] = sortListAlphabetical[i + 1];
            sortListAlphabetical[i + 1] = tempPokemonInPokemonsList;
          }
        }
      }
    } else if (popUpMenuValue == 1) {
      sortListAlphabetical.sort((a, b) => b.pokemon.name!.compareTo(a.pokemon.name!));
    } else if (popUpMenuValue == 2) {
      displayPokemonsList();
    } else if (popUpMenuValue == 3) {
      List<PokemonWrapper> onlyFavoritePokemons =
          await useCase.getFavoritePokemonsWrapper();
      sortListAlphabetical = onlyFavoritePokemons;
    }

    emit(PokemonListLoaded(sortListAlphabetical));
  }

  void DisplayErrorMessageForPokemonList() {
    emit(PokemonListMessageError("une erreur s'est produite"));
  }
}
