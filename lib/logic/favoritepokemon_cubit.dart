import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/logic/favoritepokemon_state.dart';

import '../model/pokemon.dart';
import '../repository/pokemon_repository.dart';

class FavoritePokemonCubit extends Cubit<FavoritePokemonState>{
  final PokemonRepository repository;
  late final List<Pokemon> allFavorites;
  FavoritePokemonCubit(this.repository):super(FavoritePokemonList([]));

  void loadFavoritePokemon() async{
    final favoritePokemonList = await repository.getFavoritePokemons(allFavorites);
    print('il y a :$favoritePokemonList');
    emit(FavoritePokemonList(favoritePokemonList));
  }

}