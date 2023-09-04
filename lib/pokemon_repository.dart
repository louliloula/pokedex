
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'model/pokemon.dart';

class PokemonRepository {

  final SharedPreferences _prefs;

  PokemonRepository(this._prefs);

  Future<void> savePokemonList(List<Pokemon>pokemonList) async {
    //stock les données de maniere persistante
    final prefs = await SharedPreferences.getInstance();
    //enregistre la liste de pokemon / map sur chaque pokemon de la liste / convertir le resultat en liste
    final pokemonListJson = pokemonList.map((pokemon) => pokemon.toJson()).toList();
    //je prend la liste pokemonListJson
    final pokemonListJsonToString = jsonEncode(pokemonListJson);
    await prefs.setString('pokemonList', pokemonListJsonToString);

  }


  Future<List<Pokemon>> getPokemonListFromLocal() async {
    //chargement du contenu du fichier JSon
    final jsonData = await rootBundle.loadString('json/pokemon.json');
    //chargement sous chaine de caractere / decode des données JSON
    final List<dynamic> jsonList = json.decode(jsonData);
    final List<Pokemon> pokemonList = jsonList.map((json) {
      return Pokemon.fromJson(json);
    }).toList();

    return pokemonList;
  }

  Future<void> updateFavoritePokemon(Pokemon pokemon) async {

    //mettre a jour la mise en favori d un pokemon dans la liste des pokemons
    final List<String>? favoritePokemon = _prefs.getStringList(
        'favoritePokemon')??[];
    if(favoritePokemon !=null){
      if (favoritePokemon.contains(pokemon.nationalId.toString()!)) {
        favoritePokemon?.remove(pokemon.nationalId.toString()!);
      } else {
        favoritePokemon?.add(pokemon.nationalId.toString());
      }
      await _prefs.setStringList('favoritePokemon', favoritePokemon);
    }

  }

  // Obtenir la liste des Pokémons favoris
  Future<List<Pokemon>> getFavoritePokemons(List<Pokemon> allPokemons) async {
    final List<String>? favoritePokemon = _prefs.getStringList('favoritePokemon') ?? [];

    if ( favoritePokemon == null) {
      // Aucun Pokémon en favori, renvoie une liste vide
      return [];
    }
    final favoritePokemons = allPokemons
        .where((pokemon) => favoritePokemon.contains(pokemon.nationalId.toString()))
        .toList();

    return favoritePokemons;


  }

}