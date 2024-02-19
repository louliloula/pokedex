import 'dart:math';

import 'package:pokedex/model/pokemon.dart';
import 'package:pokedex/repository/pokemon_repository.dart';
import 'package:collection/collection.dart';

import '../model/pokemonWrapper.dart';

class PokemonUseCase {
  PokemonRepository repository;

  PokemonUseCase(this.repository);

  Future<List<PokemonWrapper>> getWrappers() async {
    final getAllPokemons = await repository.getPokemonListFromLocal();

    // final List<PokemonWrapper> wrappers = [];
    // getAllPokemons.forEach((pokemon) {
    //   final wrapper = PokemonWrapper(pokemon, [], []);
    //   wrappers.add(wrapper);
    // });
    final List<PokemonWrapper> wrappers = getAllPokemons
        .map((pokemon) => PokemonWrapper(
            pokemon: pokemon, previousPokemon: [] , nextEvolution:[] ))
        .toList();
    //probleme ici
    //  for (var wrapper in wrappers) {
    //    wrapper.pokemon.evolutions?.forEach((evol) {
    //      final pokemonWrapperEvolution = _searchById(wrappers, evol.sId!);
    //      wrapper.addEvolution(pokemonWrapperEvolution!);
    //      pokemonWrapperEvolution.addEvolutionParente(wrapper);
    //    });
    //  }
    return wrappers;
  }

  PokemonWrapper? _searchById(List<PokemonWrapper> wrappers, String pokemonId) {
    // for (var wrapper in wrappers) {
    //   if(wrapper.pokemon.sId == pokemonId){
    //     return wrapper;
    //   }
    //
    // }
    return wrappers
        .firstWhereOrNull((wrapper) => wrapper.pokemon.sId == pokemonId);
  }

  Future<List<PokemonWrapper>> getPokemonsEvolution() async{
    final getPokemonsWrapper = await getWrappers();
    for (var wrapper in getPokemonsWrapper) {
         wrapper.pokemon.evolutions?.forEach((evol) {
            final pokemonWrapperEvolution = _searchById(getPokemonsWrapper, evol.sId!);
            if (pokemonWrapperEvolution != null) {
              wrapper.addEvolution(pokemonWrapperEvolution);
            }
            pokemonWrapperEvolution?.addEvolutionParente(wrapper);
          });
        }
    return getPokemonsWrapper;

  }


  Future<List<PokemonWrapper>> getFavoritePokemonsWrapper() async {
    final retrievePokemonWrapper = await getWrappers();
    final retrieveFavoritePokemons = await repository.getFavoritePokemons();
    List<PokemonWrapper> recupFavoritePokemonList = [];
    for (var pokemonFavoriteId in retrieveFavoritePokemons) {
      //retrievePokemonWrapper.where((pokemonWrapper) => pokemonWrapper.pokemon.sId == pokemonFavoriteId.sId);
      for (var pokemonWrapper in retrievePokemonWrapper) {
        if (pokemonFavoriteId == pokemonWrapper.pokemon.sId) {
          recupFavoritePokemonList.add(pokemonWrapper);
        }
      }
    }
    //return retrievePokemonWrapper;
    return recupFavoritePokemonList;
  }

  Future<PokemonWrapper> generateRandomPokemon() async {
    final pokemonList = await getWrappers();
    final random = Random();
    final randomIndex = random.nextInt(pokemonList.length);
    final randomPokemonWrapper = pokemonList[randomIndex];
    await repository.getRandomPokemon(randomPokemonWrapper.pokemon.sId);
    return randomPokemonWrapper;
  }

  Future<List> createListOfRandomPokemons() async{
    final createRandomPokemonlist = [];
    for(int i = 0 ; i< 5 ; i ++){
      final randomPokemon = await generateRandomPokemon();
      createRandomPokemonlist.add(randomPokemon);
      await repository.saveRandomFromPokemonList(randomPokemon.pokemon.sId);
    }

    return createRandomPokemonlist;
  }

  Future<bool> toogleFavoritePokemons(PokemonWrapper pokemonWrapper) async{
    final List<String> favoritePokemon = await repository.getFavoritePokemons();
    bool contains = favoritePokemon.contains(pokemonWrapper.pokemon.sId);
    if(contains){
      favoritePokemon.remove(pokemonWrapper.pokemon.sId);
    }else{
      favoritePokemon.add(pokemonWrapper.pokemon.sId);
    }
    await repository.saveFavoritePokemons(favoritePokemon);
    return !contains;
  }

  Future<bool> isFavorite(PokemonWrapper pokemonWrapper) async {
    return repository.isFavoritePokemon(pokemonWrapper.pokemon);
  }







}
