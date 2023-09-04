import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/logic/pokemondetail_state.dart';

class PokemonDetailCubit extends Cubit<PokemonDetailState>{
  PokemonDetailCubit():super(const PokemonDetailScreenInitial());
}