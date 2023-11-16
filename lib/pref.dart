import 'dart:convert';
import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';

import 'model/pokemon.dart';

class Pref {
  SharedPreferences? prefs;

  Future<SharedPreferences> _getPrefs() async {
    prefs ??= await SharedPreferences.getInstance();
    return prefs!;
  }

//set

  Future<void> saveFavoritePokemonIds(List<String> favoritePokemon) async {
    (await _getPrefs()).setStringList('favoritePokemon', favoritePokemon);
  }

  Future<void> saveRandomPokemon(String pokemon) async {
    //final pokemonListJson = json.encode(pokemon.toJson());
    (await _getPrefs()).setString('randomPokemon', pokemon);
  }

//get
  Future<List<String>> getFavoritePokemonsIds() async {
    return (await _getPrefs()).getStringList('favoritePokemon') ?? [];
  }

  Future<String?> getRandomPokemon() async {
    return (await _getPrefs()).getString('randomPokemon');
  }



}
