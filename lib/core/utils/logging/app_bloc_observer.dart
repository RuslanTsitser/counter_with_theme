import 'package:counter_with_theme/core/utils/logging/app_logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    logBlOC({
      'OnChange': bloc.runtimeType,
      'New state': change.nextState,
      'Previous state': change.currentState,
    });
  }

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    logBlOC({
      'OnCreate': bloc.runtimeType,
      'Initial state': bloc.state,
    });
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    logErrorBlOC({
      'OnError': bloc.runtimeType,
    }, error, stackTrace);
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    logBlOC({'OnClose': bloc.runtimeType, 'Closed state': bloc.state});
  }
}
