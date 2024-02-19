
import 'dart:convert';

import 'package:pokedex/model/pokemon_type.dart';

class MyPokemon {
  //random Id
  String id;
  String name;
  String pokemonDescription;
  List<String> pokemonsTypes;

  MyPokemon({required this.id,
    required this.name,
    required this.pokemonDescription,
    required this.pokemonsTypes});

}

