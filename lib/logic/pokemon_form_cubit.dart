import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/logic/pokemon_form_state.dart';

import '../repository/pokemon_repository.dart';

class PokemonFormCubit extends Cubit<PokemonFormState>{
   PokemonRepository repository;
  PokemonFormCubit(this.repository): super(PokemonFormInitial());


  Future<void> nameOfMyOwnPokemon(String inputUser) async {

  }


  void onClickCheckBox(){
     emit(PokemonTypeChoice());
   }

}

