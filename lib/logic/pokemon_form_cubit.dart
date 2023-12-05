import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/logic/pokemon_form_state.dart';

import '../repository/pokemon_repository.dart';

class PokemonFormCubit extends Cubit<PokemonFormState>{
   PokemonRepository repository;
  PokemonFormCubit(this.repository): super(const PokemonFormInitial());


  Future<void> nameOfMyOwnPokemon(String inputUser) async {
   if(inputUser.isEmpty || inputUser is int){
     emit(const ErrorMessage("Try again"));
   }
  }


  void onClickCheckBox(){
     emit(const PokemonTypeChoice());
   }

}

