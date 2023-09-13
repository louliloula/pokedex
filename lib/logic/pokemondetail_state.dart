import 'package:equatable/equatable.dart';
import 'package:pokedex/model/pokemon.dart';

class PokemonDetailState extends Equatable{
  const PokemonDetailState();

  @override
  List<Object?> get props => [];

}
class PokemonDetailScreenInitial extends PokemonDetailState{
  const PokemonDetailScreenInitial();
}
class FavouritePokemonHeart extends PokemonDetailState{
  final Pokemon pokemon;
  final bool isFavorite;
  const FavouritePokemonHeart(this.pokemon,this.isFavorite);

  @override

  List<Object?> get props => [pokemon,isFavorite];
}

class PokemonFavoriteListLoading extends PokemonDetailState{
  const PokemonFavoriteListLoading();
}

