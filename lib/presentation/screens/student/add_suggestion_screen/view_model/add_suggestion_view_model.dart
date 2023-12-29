import 'package:rababa/app/end_points/constant.dart';
import 'package:rababa/data/model/suggestion_model.dart';
import 'package:rababa/domain/usecase/add_suggestion_usecase.dart';
import 'package:rababa/presentation/base/base_viewmodel.dart';
import 'package:rababa/presentation/common/freezed_data_classes.dart';
import 'package:rababa/presentation/common/state_renderer/state_renderer.dart';
import 'package:rababa/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rababa/presentation/resources/strings_manager.dart';

class AddSuggestionViewModel extends BaseViewModel with AddSuggestionViewModelInput {

  SuggestionObject suggestionObject = SuggestionObject('',AppConstant.userObject!.uid, '', DateTime.now()) ;

  AddSuggestionUseCase suggestionUseCase ;

  AddSuggestionViewModel(this.suggestionUseCase);

  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  addSuggestion() async{
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState));
    if(suggestionObject.suggestion!=null) {
      (await suggestionUseCase.execute(
      SuggestionModel(
          suggestionObject.id!,
          suggestionObject.uid!,
          suggestionObject.suggestion!,
          suggestionObject.dateTime!)))
        .fold((failure) {
    inputState
        .add(ErrorState(StateRendererType.popupErrorState, failure.message));
    }, (data) {
    inputState.add(SuccessState(StateRendererType.fullScreenSuccessState, AppStrings.successAdd));
    });
    }
    else
    {
    inputState
        .add(ErrorState(StateRendererType.popupErrorState, AppStrings.cantEmpty));
    }
  }

  @override
  setSuggestion(String suggestion) {
    suggestionObject = suggestionObject.copyWith(suggestion:suggestion,dateTime:DateTime.now());
  }

}

abstract class AddSuggestionViewModelInput {
  setSuggestion(String suggestion);
  addSuggestion();
}