
import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/pokemon.dart';

//Reponsable de la gestion des données des pokemons
class PokemonRepository {
//stocker les données persistantes
  final SharedPreferences _prefs;



  //prend une instance de shared preference comme argument
  PokemonRepository(this._prefs);



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
    //chargement du contenu du fichier JSon stocké dans la variable jsonData
    final jsonData = await rootBundle.loadString('json/pokemon.json');
    //decode le fichier json en une liste dynamic stocké dans la variable jsonList
    final List<dynamic> jsonList = json.decode(jsonData);
    //transformation de la liste jsonList pour chaque élément jsonList creation d'un pokemon
    //a partir de la class model pokemon , transformation en list
    final List<Pokemon> pokemonList = jsonList.map((json) {
      return Pokemon.fromJson(json);
    }).toList();

    return pokemonList;
  }

  //mettre a jour la mise en favori d un pokemon dans la liste des pokemons
  Future<void> updateFavoritePokemon(Pokemon pokemon) async {
    //Liste de pokemons favoris vide
    final List<String> favoritePokemon = _prefs.getStringList(
        'favoritePokemon') ?? [];
    //verifie si la liste contient deja le pokemon favoris selon son nationalId si c'est le cas supprimer
      if (favoritePokemon.contains(pokemon.nationalId.toString())) {
        favoritePokemon.remove(pokemon.nationalId.toString());
      } else {
        favoritePokemon.add(pokemon.nationalId.toString());
      }
      //enregistrement de la mise a jour de favorite pokemon de maniere persistante
      await _prefs.setStringList('favoritePokemon', favoritePokemon);


  }

  //Recuperation des pokemons favoris
  Future<List<Pokemon>> getFavoritePokemons(List<Pokemon> allPokemons) async {
    final List<String>? favoritePokemon = _prefs.getStringList('favoritePokemon') ?? [];

    if ( favoritePokemon == null) {
      // Aucun Pokémon en favori, renvoie une liste vide
      return [];
    }
    //filtre tous les pokemons
    final favoritePokemons = allPokemons
    //inclure le pokemon dont le national ID est present dans liste de pokemons favoris
        .where((pokemon) => favoritePokemon.contains(pokemon.nationalId.toString()))
    //transformation en liste
        .toList();

    return favoritePokemons;


  }
  Future <Pokemon> generateRandomPokemon()async{
    List<Pokemon>? pokemonList;
    pokemonList ??= await getPokemonListFromLocal();

    final random = Random();
    final randomIndex = random.nextInt(pokemonList.length);
    return pokemonList[randomIndex];
  }



}
