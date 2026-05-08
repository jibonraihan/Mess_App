import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mess_app/features/mess/domain/mess.dart';

part 'mess_state.freezed.dart';

@freezed
class MessState with _$MessState {
  // State when data is still loading
  const factory MessState.loading() = _Loading;

  // State when the user is not part of any mess
  const factory MessState.notInMess() = _NotInMess;

  // State when the user is successfully loaded into a mess
  const factory MessState.loaded({required Mess mess}) = _Loaded;

  // State when an error occurs
  const factory MessState.error({required String message}) = _Error;
}
