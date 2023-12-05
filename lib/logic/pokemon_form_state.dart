import 'package:equatable/equatable.dart';

abstract class PokemonFormState extends Equatable{
  const PokemonFormState();

  @override
  List<Object?> get props => [];

}

class PokemonFormInitial extends PokemonFormState{
  const PokemonFormInitial();
}

class PokemonTypeChoice extends PokemonFormState{
  const PokemonTypeChoice();
}

class ErrorMessage extends PokemonFormState{
  final String errorMessage;

  const ErrorMessage(this.errorMessage);
}
