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


class PokemonFavoriteListLoading extends PokemonDetailState{
  const PokemonFavoriteListLoading();
}
class PokemonDetail extends PokemonDetailState{
  final Pokemon pokemon;
  final bool isFavorite;

   PokemonDetail(this.isFavorite,this.pokemon);

   @override
  List<Object?> get props => [pokemon,isFavorite];

}

class FavouritePokemonHeart extends PokemonDetailState{
  final bool isFavorite;
  final Pokemon pokemon;
  FavouritePokemonHeart(this.isFavorite,this.pokemon);

  @override
List<Object?> get props => [pokemon,isFavorite];

}



