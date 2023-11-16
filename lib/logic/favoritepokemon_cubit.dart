
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/logic/favoritepokemon_state.dart';
import 'package:pokedex/model/pokemonWrapper.dart';

import '../model/pokemon.dart';
import '../repository/pokemon_repository.dart';
import '../usecase/pokemon_usecase.dart';

class FavoritePokemonCubit extends Cubit<FavoritePokemonState>{
  final PokemonUseCase useCase;

  FavoritePokemonCubit( this.useCase):super(FavoritePokemonInitial());


  void displayFavoritePokemonList() async{
    //final favoritePokemonList = await repository.getFavoritePokemons();
    final favoritePokemonList = await useCase.getFavoritePokemonsWrapper();
    emit(ListOfFavoritePokemon(favoritePokemonList));

  }

  void removePokemonFromFavoriteList(PokemonWrapper pokemonWrapper) async {
    await useCase.toogleFavoritePokemons(pokemonWrapper);
     displayFavoritePokemonList();

  }


}

