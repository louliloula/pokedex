import 'package:equatable/equatable.dart';

import '../model/pokemon.dart';

abstract class PokemonHomeState extends Equatable{
  const PokemonHomeState();
  @override
  List<Object?> get props => [];
}


//Vue general
class GeneratorPokemonSucess extends PokemonHomeState{
  final Pokemon randomPokemon;
  final List<Pokemon> myPokemon;
  const GeneratorPokemonSucess(this.randomPokemon,this.myPokemon);
  @override
  List<Object?> get props => [randomPokemon,myPokemon];
}
class GeneratorPokemonError extends PokemonHomeState{
      String errorMessage;
    GeneratorPokemonError(this.errorMessage);
      @override
      List<Object?> get props => [errorMessage];
}
class PokemonLoading extends PokemonHomeState{
  const PokemonLoading();
}

class MyPokemonWallet extends PokemonHomeState{
  List<Pokemon> myPokemon;
  MyPokemonWallet(this.myPokemon);
}
