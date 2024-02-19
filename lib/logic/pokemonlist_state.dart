import 'package:equatable/equatable.dart';
import 'package:pokedex/model/pokemonWrapper.dart';

import '../model/pokemon.dart';

abstract class PokemonListState extends Equatable {
  const PokemonListState();

  @override
  List<Object> get props => [];
}

class PokemonListScreenInitial extends PokemonListState {
  const PokemonListScreenInitial();
}

class PokemonListLoading extends PokemonListState {
  const PokemonListLoading();
}

class PokemonListLoaded extends PokemonListState {
   List<PokemonWrapper> pokemonsList;
  PokemonListLoaded(this.pokemonsList);

  @override
  List<Object> get props => [pokemonsList];
}

class PokemonListMessageError extends PokemonListState {
  final String errorMessage;
  const PokemonListMessageError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
