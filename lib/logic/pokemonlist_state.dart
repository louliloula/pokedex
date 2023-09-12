
import 'package:equatable/equatable.dart';

import '../model/pokemon.dart';

abstract class PokemonListState extends Equatable{
  const PokemonListState();



  @override
  List<Object> get props =>[];

}

class PokemonListScreenInitial extends PokemonListState {
  const PokemonListScreenInitial();
}

class PokemonListLoaded extends PokemonListState {
  final List<Pokemon> pokemonList;
  PokemonListLoaded(this.pokemonList);

  @override
  List<Object> get props => [];
}

class PokemonListError extends PokemonListState {
  final String errorMessage;
  PokemonListError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

class PokemonListLoading extends PokemonListState{
  const PokemonListLoading();
}

class PokemonListFilteredScreen extends PokemonListState{
  final List<Pokemon> filteredList;
  const PokemonListFilteredScreen(this.filteredList);

}

class PokemonListScreenSortAlphabetically extends PokemonListState{
  final List<Pokemon> sortListAz;
  const PokemonListScreenSortAlphabetically(this.sortListAz);
}

