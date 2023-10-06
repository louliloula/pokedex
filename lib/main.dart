import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/repository/pokemon_repository.dart';
import 'package:pokedex/screen/favoritepokemonlist.dart';
import 'package:pokedex/screen/pokemonhome_screen.dart';
import 'package:pokedex/screen/pokemonlist_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final PokemonRepository repository = PokemonRepository(prefs: prefs);

  runApp(MyApp(repository: repository,));
}

class MyApp extends StatelessWidget {
  final PokemonRepository repository;

  const MyApp({super.key, required this.repository});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(

          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              toolbarHeight: 15,
              backgroundColor: Colors.white,
              bottom: TabBar(tabs: [
                Tab(icon: Icon(Icons.other_houses_outlined,color: Colors.blueGrey,),),
                Tab(icon: Icon(Icons.list_alt_outlined,color: Colors.blueGrey,),),
                Tab(icon: Icon(Icons.favorite_border,color: Colors.blueGrey,),),

              ],
              ),

            ),
            body: TabBarView(
              children: [
                RepositoryProvider(
                create: (context) => repository,
            child :PokemonHomeScreen(repository: repository,),
          ),
                RepositoryProvider(create: (context)=> repository,
                child: PokemonListScreen(repository: repository,),
                ),RepositoryProvider(create: (context)=> repository,
            child: FavoritePokemonList(repository: repository),

                )]),

            ),
        ),


        );
        // RepositoryProvider(
        //   create: (context) => repository,
        //   child: PokemonListScreen(repository: repository,),
        // ));
  }
}
