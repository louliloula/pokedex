import 'package:flutter/material.dart';
import 'package:pokedex/repository/pokemon_repository.dart';
import 'package:pokedex/screen/favoritepokemonlist_screen.dart';
import 'package:pokedex/screen/pokemon_form_screen.dart';
import 'package:pokedex/screen/pokemonhome_screen.dart';
import 'package:pokedex/screen/pokemonlist_screen.dart';
import 'package:pokedex/usecase/pokemon_usecase.dart';

import 'model/pokemon.dart';

void main() async {
  PokemonRepository repository = PokemonRepository();
  PokemonUseCase useCase = PokemonUseCase(repository);

  runApp(MyApp(
    useCase: useCase,
    repository: repository,
  ));
}

class MyApp extends StatelessWidget {
  final PokemonRepository repository;
  final PokemonUseCase useCase;

  const MyApp({super.key, required this.repository, required this.useCase});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 15,
            backgroundColor: Colors.white,
            bottom: const TabBar(
              tabs: [
                Tab(
                    child: Text(
                  'Home',
                  style: TextStyle(color: Colors.blueGrey),
                )),
                Tab(
                    child: Text(
                  'List',
                  style: TextStyle(color: Colors.blueGrey),
                )),
                Tab(
                    child: Text(
                  'Favorite',
                  style: TextStyle(color: Colors.blueGrey),
                )),
                Tab(
                  child:
                      Text('Create', style: TextStyle(color: Colors.blueGrey)),
                )
              ],
            ),
          ),
          body: TabBarView(children: [
            PokemonHomeScreen(
              useCase: useCase,
            ),
            PokemonListScreen(
              useCase: useCase,
            ),
            FavoritePokemonList(
              useCase: useCase,
            ),
            PokemonForm(
              repository: repository,
            ),
          ]),
        ),
      ),
    );
    // RepositoryProvider(
    //   create: (context) => repository,
    //   child: PokemonListScreen(repository: repository,),
    // ));
  }
}
