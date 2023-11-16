import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/logic/pokemonhome_state.dart';
import 'package:pokedex/repository/pokemon_repository.dart';
import 'package:pokedex/usecase/pokemon_usecase.dart';

import '../model/pokemon.dart';
import '../model/pokemonWrapper.dart';

class PokemonHomeCubit extends Cubit<PokemonHomeState> {
  PokemonHomeCubit(this.useCase) : super(const PokemonLoading());


  final PokemonUseCase useCase;
  late List<PokemonWrapper> randomPokemonsList = [];
  late Timer timer;


  Future<void> emitRandomPokemon() async {
    //final randomPokemon = await repository.generateRandomPokemon();
     final randomPokemon = await useCase.generateRandomPokemon();
    emit(GenerateHomeScreenSucessfully(randomPokemon, randomPokemonsList));
  }

  void spawmRandomPokemonPerMinute() {
    timer = Timer.periodic(Duration(seconds: 60), (timer) async {
      emitRandomPokemon();
    });
  }

  Future<void> retrieveListOfRandomPokemons() async {
    final recoverRandomPokemonsList =
        await useCase.createListOfRandomPokemons();
    //randomPokemonsList = [];
    for (var pokemon in recoverRandomPokemonsList) {
      //Add item pokemonwrapper
      randomPokemonsList.add(pokemon);
    }
  }

  void displayHomePage() async {
    await retrieveListOfRandomPokemons();
    await emitRandomPokemon();
    spawmRandomPokemonPerMinute();
  }

  void DisplayErrorMessageForScreenHome() {
    emit(HomeScreenMessageError("une erreur s'est produite"));
  }
}
