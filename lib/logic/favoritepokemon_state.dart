import 'package:equatable/equatable.dart';
import 'package:pokedex/model/pokemonWrapper.dart';

import '../model/pokemon.dart';

abstract class FavoritePokemonState extends Equatable {
  const FavoritePokemonState();

  @override
  List<Object?> get props => [];
}

class FavoritePokemonInitial extends FavoritePokemonState {
  const FavoritePokemonInitial();
}

class ListOfFavoritePokemon extends FavoritePokemonState {
  List<PokemonWrapper> favoritePokemonList;
  ListOfFavoritePokemon(this.favoritePokemonList);

  @override
  List<Object?> get props => [favoritePokemonList];
}
