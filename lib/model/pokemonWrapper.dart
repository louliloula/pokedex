import 'dart:core';

import 'package:pokedex/model/pokemon.dart';

class PokemonWrapper {
  final Pokemon pokemon;
  List<PokemonWrapper> previousPokemon;
  List<PokemonWrapper> nextEvolution;

  PokemonWrapper(
      {required this.pokemon,
      required this.previousPokemon ,
      required this.nextEvolution });

  void addEvolution(PokemonWrapper pokemonWrapperEvolution) {
    nextEvolution.add(pokemonWrapperEvolution);
  }

  void addEvolutionParente(PokemonWrapper wrapper) {
    previousPokemon.add(wrapper);
  }
}

// pokemonList: List<Pokemon> > pokemonList: List<PokemonWrapper>
// [
//   PokemonWrapper(pokemon: Pokemon(bulbasaur), previousEvolution: [], nextEvolution: [Pokemon(Ivisaur)]),
//   PokemonWrapper(pokemon: Pokemon(Ivisaur), previousEvolutions: [ Pokemon(Bulbasaur) ], next: [Pokemon(Venusaur)])
//   PokemonWrapper(pokemon: Pokemon(Venusaur), previous: [Pokemon(Ivisaur)], next: [])
//
// ]
//
// final firstpokemon = pokemonList[0];
// firstPokemon.pokemon
// firstPokemon.nextEvolution
// firstPokemon.previous
