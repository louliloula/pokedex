import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/logic/pokemondetail_state.dart';
import 'package:pokedex/model/pokemonWrapper.dart';
import 'package:pokedex/repository/pokemon_repository.dart';

import '../model/pokemon.dart';
import '../usecase/pokemon_usecase.dart';

class PokemonDetailCubit extends Cubit<PokemonDetailState> {
  final PokemonWrapper pokemonWrapper;
  final PokemonUseCase useCase;

  PokemonDetailCubit(this.useCase, this.pokemonWrapper)
      : super(const PokemonDetailScreenInitial());

  Future<void> onClickFavorite() async {
    bool newFavoriteStatus = await useCase.toogleFavoritePokemons(pokemonWrapper);
    emit(PokemonDetail(newFavoriteStatus, pokemonWrapper));
  }

  Future<void> init() async {
    bool readValue = await useCase.isFavorite(pokemonWrapper);
    pokemonWrapper.nextEvolution.contains(pokemonWrapper.pokemon.sId);
    pokemonWrapper.previousPokemon.contains(pokemonWrapper.pokemon.sId);
    emit(PokemonDetail(readValue, pokemonWrapper));
  }

  Future<void> brouillon() async{

    }




  }





