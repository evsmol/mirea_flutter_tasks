import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// Определение событий
abstract class TextEvent extends Equatable {
  const TextEvent();

  @override
  List<Object> get props => [];
}

class TextChanged extends TextEvent {
  final String text;

  const TextChanged(this.text);

  @override
  List<Object> get props => [text];
}

// Определение состояний
abstract class TextState extends Equatable {
  final String text;

  const TextState(this.text);

  @override
  List<Object> get props => [text];
}

class TextInitial extends TextState {
  const TextInitial() : super('');
}

class TextUpdated extends TextState {
  final int charCount;
  final int spaceCount;
  final int vowelCount;
  final int consonantCount;

  const TextUpdated({
    required String text,
    required this.charCount,
    required this.spaceCount,
    required this.vowelCount,
    required this.consonantCount,
  }) : super(text);

  @override
  List<Object> get props =>
      [text, charCount, spaceCount, vowelCount, consonantCount];
}

// Bloc для управления состоянием текста
class TextBloc extends Bloc<TextEvent, TextState> {
  TextBloc() : super(const TextInitial());

  @override
  Stream<TextState> mapEventToState(TextEvent event) async* {
    if (event is TextChanged) {
      final text = event.text;
      final charCount = text.length;
      final spaceCount = text.split(' ').length - 1;
      final vowelCount = text.replaceAll(RegExp(r'[^ауоыиэяюёеАУОЫИЭЯЮЁЕ]'), '').length;
      final consonantCount = text.replaceAll(RegExp(r'[ауоыиэяюёеАУОЫИЭЯЮЁЕ\s]'), '').length;
      yield TextUpdated(
          text: text,
          charCount: charCount,
          spaceCount: spaceCount,
          vowelCount: vowelCount,
          consonantCount: consonantCount);
    }
  }
}
