import 'package:equatable/equatable.dart';
import 'package:pokedex/model/pokemon.dart';

import '../model/pokemonWrapper.dart';

class PokemonDetailState extends Equatable {
  const PokemonDetailState();

  @override
  List<Object?> get props => [];
}

class PokemonDetailScreenInitial extends PokemonDetailState {
  const PokemonDetailScreenInitial();
}

class PokemonDetail extends PokemonDetailState {
  final bool isFavorite;
  final PokemonWrapper pokemonWrapper;
  //final List<PokemonWrapper> nextEvolution;
  const PokemonDetail(this.isFavorite, this.pokemonWrapper);
  @override
  List<Object?> get props => [pokemonWrapper, isFavorite];
}

class FutureEvolutionOfPokemon extends PokemonDetailState{
  final List<PokemonWrapper> getPokemonsWrapperEvolution;
  const FutureEvolutionOfPokemon( this.getPokemonsWrapperEvolution);
  @override
  List<Object?> get props => [getPokemonsWrapperEvolution];


}
