import 'dart:async';


import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/logic/pokemonhome_state.dart';
import 'package:pokedex/repository/pokemon_repository.dart';

import '../model/pokemon.dart';

class PokemonHomeCubit extends Cubit<PokemonHomeState>{
  PokemonHomeCubit(this.repository):super(const PokemonLoading());


  final PokemonRepository repository;
  late List<Pokemon> pokemonRandomList;
  late Timer timer;


  void spawnPokemonPerHour() async {
    await myPokemonListWallet();
    await emitRandomPokemon();
    timer = Timer.periodic(Duration(seconds: 60), (timer) async {
      try{
        await emitRandomPokemon();

      }catch(e){
        // if (kDebugMode) {
        //   print('Erreur erreur');
        // }
        emit(GeneratorPokemonError("Erreur lors de la géneration de pokemon"));
      }
    });
  }



  Future<void> emitRandomPokemon() async {
    final randomPokemon = await repository.generateRandomPokemon();
    // if (kDebugMode) {
    //   print('Pokemon généré : ${randomPokemon.name}');
    // }
    emit(GeneratorPokemonSucess(randomPokemon,pokemonRandomList));

  }






  Future<void> myPokemonListWallet() async{
    pokemonRandomList = [];

    for(int i = 0 ; i < 3 ; i++){
       final myRandomPokemon = await repository.generateRandomPokemon();

       if (kDebugMode) {
         print('Pokemon généré : ${myRandomPokemon.name}');
       }
       pokemonRandomList.add(myRandomPokemon);
    }
  }

}
