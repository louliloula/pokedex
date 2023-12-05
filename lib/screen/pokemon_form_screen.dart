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
          return SafeArea(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 15),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Create your pokemon",
                        style: GoogleFonts.cabinSketch(
                            textStyle:
                                const TextStyle(fontSize: 20, color: Colors.blueGrey)),
                      ),
                    ),
                    const SizedBox(height: 25),
                    _HeadForm(
                      showAlert:() async {
                        showImageAlertDialog(context);}),
                    const SizedBox(
                      height: 25,
                    ),
                    const _MyPokemonDescription(),
                    const SizedBox(height: 15),
                    Text(
                      'TYPES :',
                      style: GoogleFonts.cabinSketch(
                          textStyle:
                              const TextStyle(fontSize: 15, color: Colors.blueGrey)),
                    ),
                    TypeChipPokemon(),
                    Center(child: ElevatedButton(onPressed: (){}, child: const Text("Create")))
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future <void> showImageAlertDialog(BuildContext alertContext) async {
    showDialog(
        context: alertContext,
        builder: (context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15))),
            title: Text(
              "Select your pokemon",
              style: GoogleFonts.cabinSketch(color: Colors.blueGrey),
            ),
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
      inactiveBorderColorList: const [Colors.blueGrey],
      activeBgColorList: colorsTypes,
    );
  }
}


class _HeadForm extends StatelessWidget{
  final VoidCallback showAlert;

  const _HeadForm({super.key, required this.showAlert});


  @override
  Widget build(BuildContext context) {
   return Row(
     children: [
       Container(
         height: 135,
         width: 125,
         color: Colors.black12,
         child: Center(
             child:
             IconButton(
               onPressed: showAlert,
               icon: const Icon(
                 Icons.add,
                 size: 35,
               ),
               color: Colors.white,
    )
    ),
       ),
       Padding(
         padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
         child: SizedBox(
           width: 218,
           child: TextField(
             //Methode onChange dans laquelle j'appelle le cubit
             style: GoogleFonts.specialElite(
                 textStyle: const TextStyle(color: Colors.blueGrey)),
             decoration: const InputDecoration(
                 border: UnderlineInputBorder(),
                 labelText: 'Name of your pokemon ...'),
           ),
         ),
       )

     ],
   );
  }

}

class _MyPokemonDescription extends StatelessWidget{
  const _MyPokemonDescription ({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'DESCRIPTION :',
          style: GoogleFonts.cabinSketch(
              textStyle:
              const TextStyle(fontSize: 15, color: Colors.blueGrey)),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 15),
          child: SizedBox(
            height: 150,
            child: TextField(
              decoration: InputDecoration(border: OutlineInputBorder()),
              minLines: null,
              maxLines: 5,
            ),
          ),
        ),
      ],
    );
  }
}
