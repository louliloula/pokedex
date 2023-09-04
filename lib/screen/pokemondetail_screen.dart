import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/logic/pokemondetail_cubit.dart';
import 'package:pokedex/pokemon_repository.dart';

import '../model/pokemon.dart';

class PokemonDetailScreen extends StatelessWidget {
   const PokemonDetailScreen({super.key, required this.pokemonDetail, required this.repository});

  final PokemonRepository repository;
  final Pokemon pokemonDetail;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create:(context)=>PokemonDetailCubit(),
    ) ;
  }
}



