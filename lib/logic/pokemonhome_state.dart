import 'package:equatable/equatable.dart';

import '../model/pokemon.dart';
import '../model/pokemonWrapper.dart';

abstract class PokemonHomeState extends Equatable {
  const PokemonHomeState();

  @override
  List<Object?> get props => [];
}

class PokemonLoading extends PokemonHomeState {
  const PokemonLoading();
}

class GenerateHomeScreenSucessfully extends PokemonHomeState {
  final PokemonWrapper randomPokemon;
  final List<PokemonWrapper> myRandomPokemonsList;

  const GenerateHomeScreenSucessfully(this.randomPokemon, this.myRandomPokemonsList);

  @override
  List<Object?> get props => [randomPokemon, myRandomPokemonsList];
}

class HomeScreenMessageError extends PokemonHomeState {
  String errorMessage;
  HomeScreenMessageError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
