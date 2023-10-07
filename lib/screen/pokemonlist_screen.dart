import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/logic/pokemonlist_cubit.dart';
import 'package:pokedex/logic/pokemonlist_state.dart';
import 'package:pokedex/screen/pokemondetail_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/pokemon.dart';
import '../model/pokemon_type.dart';
import '../repository/pokemon_repository.dart';

class PokemonListScreen extends StatelessWidget {
  final PokemonRepository repository;
  late final SharedPreferences prefs;





  PokemonListScreen({Key?key, required this.repository}):super(key:key){
    _init();
  }

  Future<void> _init() async {
    prefs = await SharedPreferences.getInstance();
    //repository = PokemonRepository(prefs);
  }




  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => PokemonListCubit(
            context.read<PokemonRepository>())..loadPokemonList(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal:20 ,vertical:25 ),
              child: BlocBuilder<PokemonListCubit,PokemonListState>(
                builder: (blocContext,state){
                  return Column(
                    children: [
                      Row(
                        children: [
                          Expanded(child:
                          TextField(
                            onChanged: (String value){
                              blocContext.read<PokemonListCubit>().filterPokemonList(value);
                            },
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              hintText: 'Recherchez un pokemon',
                              suffixIcon: Icon(Icons.search),
                            ),
                          ),
                          ),
                         //Changer le parametre par une simple value
                          //read differente methode du cubit
                         PopupMenuButton<int>( onSelected:(sortAz){
                           blocContext.read<PokemonListCubit>().filterPokemonListAlphabetically(sortAz);

                           },
                               itemBuilder: (context){
                             return [
                               PopupMenuItem(
                                 value : 0,child:
                             Text("Pokemon A-Z")),
                                 PopupMenuItem(
                                 value : 1,child:
                                 Text("Pokemon Z-A")),
                               PopupMenuItem(
                                   value : 2,child:
                               Text("Liste de pokemons")),
                                 ];
                               }
                               )
                          ],
                        ),
                        SizedBox(
                          height: 35,
                        ),
                        if (state is PokemonListLoaded)
                          PokemonList(pokemonList: state.pokemonList,repository: repository,),
                        if(state is PokemonListFilteredScreen)
                          PokemonList(pokemonList: state.filteredList,repository: repository,),
                         if(state is PokemonListScreenSortAlphabetically)
                          PokemonList(pokemonList: state.sortListAz,repository: repository,),
                        if (state is PokemonListError)
                          Text(state.errorMessage),
                        if (state is PokemonListLoading)
                          CircularProgressIndicator(),
                      ],

                    );
                  }
                ),
              ),
            );


  }
}

// class PokemonList extends StatelessWidget{
//   PokemonList({super.key,required this.pokemonList, required this.repository});
//
//   final PokemonRepository repository;
//  final List<Pokemon> pokemonList;
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: GridView.builder(
//         scrollDirection: Axis.vertical,
//           shrinkWrap: true,
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2, crossAxisSpacing: 5,mainAxisSpacing: 5),
//           itemCount: pokemonList.length,
//           itemBuilder: (context,index){
//               return GestureDetector(
//                 onTap:(){
//                   Navigator.push(
//                       context, MaterialPageRoute(
//                       builder: (context)=>PokemonDetailScreen(pokemon : pokemonList[index] , repository: repository,)));
//                 },
//                 child: Container(
//                   margin: EdgeInsets.all(7),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(15),
//                     color: Colors.white,
//                     border: Border.all(color: Colors.yellow),
//                     image: DecorationImage(
//                       image: NetworkImage(pokemonList[index].imageUrl!)
//                     )
//                   ),
//                   child: Padding(
//                     padding: EdgeInsets.only(left: 8.0,right: 8,top:3),
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.end,
//                       children: [
//                         Text(pokemonList[index].name!),
//                         Spacer(),
//                         Text('# : ${pokemonList[index].nationalId}')
//                       ],
//                     ),),
//
//                 ),
//
//
//               );
//
//           }),
//
//     );
//   }
//
// }
class PokemonList extends StatelessWidget{
  final PokemonRepository repository;
  final List<Pokemon> pokemonList;


   PokemonList({super.key, required this.repository, required this.pokemonList});


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Expanded(
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,mainAxisSpacing: 5
            ), itemCount: pokemonList.length,
            itemBuilder: (context,index){
              return GestureDetector(
                onTap:(){
                  Navigator.push(
                      context, MaterialPageRoute(
                      builder: (context)=>PokemonDetailScreen(pokemon : pokemonList[index] , repository: repository,)));
                },
                child: Hero(
                  tag: 'pokemon-${pokemonList[index].nationalId}',
                  child: Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Colors.black12
                      )
                    ),
                    margin: EdgeInsets.all(7),
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      margin: EdgeInsets.all(5),
                      padding: EdgeInsets.all(5),
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              Expanded(
                                child: Image.network(pokemonList[index].imageUrl!,fit: BoxFit.fill,),
                              ),
                              Row(
                                children: [
                                  Text(pokemonList[index].name!),
                                  Spacer(),
                                  Text('# ${pokemonList[index].nationalId}')
                                ],
                              )

                            ],

                          ),

                        ],
                      ),
                    ),

                  ),
                ),

              );

            })
    );
  }

}
