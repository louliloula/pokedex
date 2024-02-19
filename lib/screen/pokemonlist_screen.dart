import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokedex/logic/pokemonlist_cubit.dart';
import 'package:pokedex/logic/pokemonlist_state.dart';
import 'package:pokedex/model/pokemonWrapper.dart';
import 'package:pokedex/screen/pokemondetail_screen.dart';

import '../model/pokemon.dart';

import '../repository/pokemon_repository.dart';
import '../usecase/pokemon_usecase.dart';

class PokemonListScreen extends StatelessWidget {
  final PokemonUseCase useCase;

  const PokemonListScreen({super.key, required this.useCase});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PokemonListCubit(useCase)..displayPokemonsList(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        child: BlocBuilder<PokemonListCubit, PokemonListState>(
            builder: (blocContext, state) {
          return Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (String userInput) {
                        blocContext
                            .read<PokemonListCubit>()
                            .pokemonsListFilter(userInput);
                      },
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        hintText: 'Search pokemon ...',
                        suffixIcon: Icon(Icons.search),
                      ),
                      style: GoogleFonts.specialElite(),
                    ),
                  ),
                  PopupMenuButton<int>(onSelected: (sortAlphabetical) {
                    blocContext
                        .read<PokemonListCubit>()
                        .listOfPokemonFilterAlphabetically(sortAlphabetical);
                  }, itemBuilder: (context) {
                    return [
                      const PopupMenuItem(value: 0, child: Text("Pokemon A-Z")),
                      const PopupMenuItem(value: 1, child: Text("Pokemon Z-A")),
                      const PopupMenuItem(
                          value: 2, child: Text("Pokemon list")),
                      const PopupMenuItem(
                          value: 3, child: Text("Favorite Pokemon"))
                    ];
                  })
                ],
              ),
              const SizedBox(
                height: 35,
              ),
              if (state is PokemonListLoaded)
                PokemonsList(
                  pokemonWrapperList: state.pokemonsList,
                  useCase: useCase,
                ),
              if (state is PokemonListMessageError) Text(state.errorMessage),
              if (state is PokemonListLoading) const CircularProgressIndicator(),
            ],
          );
        }),
      ),
    );
  }
}

class PokemonsList extends StatelessWidget {
  final List<PokemonWrapper> pokemonWrapperList;
  final PokemonUseCase useCase;

  //final List <PokemonWrapper> pokeEvolution = PokemonWrapper(pokemon:,previousPokemon: ,nextEvolution: )

  const PokemonsList(
      {super.key, required this.pokemonWrapperList, required this.useCase});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Expanded(
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, mainAxisSpacing: 5),
            itemCount: pokemonWrapperList.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PokemonDetailScreen(
                                pokemonWrapper: pokemonWrapperList[index],
                                useCase: useCase,

                              )));
                },
                child: Card(
                  elevation: 5,
                  shadowColor: Colors.blueGrey,
                  shape: const RoundedRectangleBorder(
                      side: BorderSide(color: Colors.black12)),
                  margin: const EdgeInsets.all(7),
                  child: Container(
                    width: screenWidth,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(5),
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            Expanded(
                              child: Image.network(
                                pokemonWrapperList[index].pokemon.imageUrl!,
                                fit: BoxFit.fill,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  pokemonWrapperList[index].pokemon.name!,
                                  style: GoogleFonts.specialElite(),
                                ),
                                const Spacer(),
                                Text(
                                  '# ${pokemonWrapperList[index].pokemon.nationalId}',
                                  style: GoogleFonts.specialElite(),
                                )
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }));
  }
}
