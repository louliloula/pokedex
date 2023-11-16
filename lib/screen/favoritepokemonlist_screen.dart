import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokedex/logic/favoritepokemon_cubit.dart';
import 'package:pokedex/logic/favoritepokemon_state.dart';
import 'package:pokedex/repository/pokemon_repository.dart';
import 'package:pokedex/screen/pokemondetail_screen.dart';
import 'package:pokedex/usecase/pokemon_usecase.dart';

import '../model/pokemon.dart';
import '../model/pokemonWrapper.dart';

class FavoritePokemonList extends StatelessWidget {
  final PokemonUseCase useCase;

  const FavoritePokemonList({super.key, required this.useCase});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          FavoritePokemonCubit(useCase)..displayFavoritePokemonList(),
      child: BlocBuilder<FavoritePokemonCubit, FavoritePokemonState>(
          builder: (blocContext, state) {
        if (state is ListOfFavoritePokemon) {
          return FavoriteList(
            allFavoritesWrapper: state.favoritePokemonList,
            useCase: useCase,
          );
        } else {
          return Center(child: Text("Vous n'avez pas de pokemons favoris"));
        }
      }),
    );
  }
}

class FavoriteList extends StatelessWidget {
  final List<PokemonWrapper> allFavoritesWrapper;
  final PokemonUseCase useCase;

  FavoriteList(
      {super.key, required this.allFavoritesWrapper, required this.useCase});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Expanded(
        Flexible(
          fit: FlexFit.loose,
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: allFavoritesWrapper.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PokemonDetailScreen(
                                  pokemonWrapper: allFavoritesWrapper[index],
                                  useCase: useCase,
                                )));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Card(
                      child: ListTile(
                        leading: Image.network(
                            allFavoritesWrapper[index].pokemon.imageUrl!),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.remove_circle_outline,
                            color: Colors.deepOrange,
                          ),
                          onPressed: () {
                            context
                                .read<FavoritePokemonCubit>()
                                .removePokemonFromFavoriteList(
                                    allFavoritesWrapper[index]);
                          },
                        ),
                        title: Text(
                          allFavoritesWrapper[index].pokemon.name!,
                          style: GoogleFonts.specialElite(),
                        ),
                        subtitle: Text(
                          allFavoritesWrapper[index].pokemon.types!.join("-"),
                          style: GoogleFonts.specialElite(),
                        ),
                      ),
                    ),
                  ),
                );
              }),
        )
        // )
      ],
    );
  }
}
