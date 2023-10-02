import 'package:equatable/equatable.dart';

import '../model/pokemon.dart';

abstract class FavoritePokemonState extends Equatable{
  const FavoritePokemonState();
  @override
  List<Object?> get props => [];

}

class FavoritePokemonList extends FavoritePokemonState{
  List <Pokemon> favoritePokemonList;
  FavoritePokemonList(this.favoritePokemonList);

  @override
  List<Object?> get props => [];


}