import 'package:chip_list/chip_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokedex/logic/pokemon_form_cubit.dart';
import 'package:pokedex/logic/pokemon_form_state.dart';
import 'package:pokedex/model/pokemon_type.dart';
import 'package:pokedex/repository/pokemon_repository.dart';

class PokemonForm extends StatelessWidget {
  final PokemonRepository repository;

  PokemonForm({super.key, required this.repository});

  //final myPokemonNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PokemonFormCubit(repository),
      child: BlocBuilder<PokemonFormCubit, PokemonFormState>(
        builder: (blocContext, state) {
          return Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 25),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Create your pokemon",
                    style: GoogleFonts.cabinSketch(
                        textStyle:
                            TextStyle(fontSize: 20, color: Colors.blueGrey)),
                  ),
                ),
                SizedBox(height: 25),
                Row(
                  children: [
                    Container(
                      //margin: EdgeInsets.only(left: 15),
                      height: 135,
                      width: 125,
                      color: Colors.black12,
                      child: Center(
                          child: IconButton(
                        onPressed: () {
                        },
                        icon: Icon(
                          Icons.add,
                          size: 35,
                        ),
                        color: Colors.white,
                      )),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      child: SizedBox(
                        width: 218,
                        child: TextField(
                          // controller: myPokemonNameController,
                          //Methode onChange dans laquelle j'appelle le cubit
                          style: GoogleFonts.specialElite(
                              textStyle: TextStyle(color: Colors.blueGrey)),
                          decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'Name of your pokemon ...'),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    'DESCRIPTION :',
                    style: GoogleFonts.cabinSketch(
                        textStyle:
                            TextStyle(fontSize: 15, color: Colors.blueGrey)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: SizedBox(
                    height: 150,
                    child: TextField(
                      decoration: InputDecoration(border: OutlineInputBorder()),
                      minLines: null,
                      maxLines: 5,
                    ),
                  ),
                ),
                SizedBox(height: 25),
                Text(
                  'TYPES :',
                  style: GoogleFonts.cabinSketch(
                      textStyle:
                          TextStyle(fontSize: 15, color: Colors.blueGrey)),
                ),
                TypeChipPokemon()
              ],
            ),
          );
        },
      ),
    );
  }
  showImageAlerteDialog(BuildContext alertcontext){
    showDialog(
        context: alertcontext,
        builder: (context){
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15))),
            title: Text("Select your pokemon",style: GoogleFonts.cabinSketch(color: Colors.blueGrey),),
          );
        });
  }
}


class TypeChipPokemon extends StatelessWidget {
  final List<String> namesTypes =
      TypeColors.colors.entries.map((name) => name.key).toList();
  final List<Color> colorsTypes =
      TypeColors.colors.entries.map((color) => color.value).toList();

  TypeChipPokemon({super.key});

  @override
  Widget build(BuildContext context) {
    return ChipList(
      listOfChipNames: namesTypes,
      listOfChipIndicesCurrentlySeclected: [0],
      shouldWrap: true,
      inactiveTextColorList: colorsTypes,
      inactiveBorderColorList: [Colors.blueGrey],
      activeBgColorList: colorsTypes,
    );
  }

}
