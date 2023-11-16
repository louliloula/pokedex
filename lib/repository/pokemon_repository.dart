import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:pokedex/model/pokemonWrapper.dart';
import 'package:pokedex/pref.dart';

import '../model/pokemon.dart';
import '../usecase/pokemon_usecase.dart';

class PokemonRepository {
  final Pref pref = Pref();

  PokemonRepository();



  // Future<void> savePokemonList(List<Pokemon>pokemonList) async {
  //   //stock les données de maniere persistante
  //   final prefs = await SharedPreferences.getInstance();
  //   //enregistre la liste de pokemon / map sur chaque pokemon de la liste / convertir le resultat en liste
  //   final pokemonListJson = pokemonList.map((pokemon) => pokemon.toJson()).toList();
  //   //je prend la liste pokemonListJson
  //   final pokemonListJsonToString = jsonEncode(pokemonListJson);
  //   await prefs.setString('pokemonList', pokemonListJsonToString);
  //
  // }

  Future<List<Pokemon>> getPokemonListFromLocal() async {
    final jsonData = await rootBundle.loadString('json/pokemon.json');
    final List<dynamic> jsonList = json.decode(jsonData);
    final List<Pokemon> pokemonList = jsonList.map((json) {
      return Pokemon.fromJson(json);
    }).toList();

    return pokemonList;
  }


  Future<void> saveRandomFromPokemonList(String pokemonId) async {
    await pref.saveRandomPokemon(pokemonId);
  }

  Future<void> getRandomPokemon(String pokemonSid)async{
    await pref.getRandomPokemon();
  }


  Future<void> saveFavoritePokemons(List<String> favoritePokemonsIds) async {
    await pref.saveFavoritePokemonIds(favoritePokemonsIds);
  }


  Future<bool> isFavoritePokemon(Pokemon pokemon) async {
    final List<String> favoritePokemons = await pref.getFavoritePokemonsIds();
    return (favoritePokemons.contains(pokemon.sId));
  }

  Future<List<String>> getFavoritePokemons() async {
    return await pref.getFavoritePokemonsIds();
    //final List<String> favoritePokemon =
    // final allPokemons = await getPokemonListFromLocal();
    // List<Pokemon> myFavoritePokemons = [];
    // for (var pokemon in allPokemons) {
    //   for (var favPokemon in favoritePokemon) {
    //     if (pokemon.sId == favPokemon) {
    //       myFavoritePokemons.add(pokemon);
    //     }
    //   }
    // }
    //return favoritePokemon;
  }

  Future<List<String>> deleteFavoritePokemon(Pokemon pokemon) async {
    await removeFavoritePokemonByIds(pokemon);
    return getFavoritePokemons();
  }

  Future<void> removeFavoritePokemonByIds(Pokemon pokemon) async {
    var favoritePokemons = await pref.getFavoritePokemonsIds();
    favoritePokemons.removeWhere((currentId) => currentId == pokemon.sId);
    await pref.saveFavoritePokemonIds(favoritePokemons);
  }

  Future<List<Pokemon>> getFutureEvolutions(Pokemon pokemon) async {
    final List<Pokemon> pokemonsEvolutions = [];
    final listOfAllPokemons = await getPokemonListFromLocal();
    for (var evolution in pokemon.evolutions!) {
      listOfAllPokemons.forEach((currentPokemon) {
        if (currentPokemon.sId == evolution.sId) {
          pokemonsEvolutions.add(currentPokemon);
        }
      });
    }
    return pokemonsEvolutions;
  }

  Future<List<Pokemon>> getPreviousEvolutions(Pokemon pokemon) async {
    final allPokemons = await getPokemonListFromLocal();
    final List<Pokemon> previousPokemonsEvolutions = [];
    allPokemons.forEach((currentPokemon) {
      currentPokemon.evolutions!.forEach((evolution) {
        if (currentPokemon.sId == evolution.sId) {
          previousPokemonsEvolutions.add(currentPokemon);
        }
      });
    });

    return previousPokemonsEvolutions;
  }


}
