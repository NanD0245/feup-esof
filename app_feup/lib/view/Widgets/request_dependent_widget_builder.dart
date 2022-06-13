import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:uni/controller/local_storage/app_last_user_info_update_database.dart';
import 'package:uni/model/app_state.dart';

class RequestDependentWidgetBuilder extends StatelessWidget {
  const RequestDependentWidgetBuilder(
      {Key key,
      @required this.context,
      @required this.status,
      @required this.contentGenerator,
      @required this.content,
      @required this.contentChecker,
      @required this.onNullContent,
      this.alwaysShowCircularProgressWhileBusy = false,
      this.index})
      : super(key: key);

  final BuildContext context;
  final RequestStatus status;
  final Widget Function(dynamic, BuildContext) contentGenerator;
  final content;
  final bool contentChecker;
  final bool alwaysShowCircularProgressWhileBusy;
  final Widget onNullContent;
  final int index;
  static final AppLastUserInfoUpdateDatabase lastUpdateDatabase =
      AppLastUserInfoUpdateDatabase();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, DateTime>(
      converter: (store) => store.state.content['lastUserInfoUpdateTime'],
      builder: (context, lastUpdateTime) {
        switch (status) {
          case RequestStatus.successful:
          case RequestStatus.none:
            return contentChecker
                ? contentGenerator(content, context)
                : onNullContent;
          case RequestStatus.busy:
            if (!alwaysShowCircularProgressWhileBusy &&
                lastUpdateTime != null) {
              return contentChecker
                  ? contentGenerator(content, context)
                  : onNullContent;
            }
            return Center(child: CircularProgressIndicator());
          case RequestStatus.failed:
            return contentChecker
                ? contentGenerator(content, context)
                : Container(
                    padding: EdgeInsets.all(8),
                    child: Center(
                        child: Text(
                            '''Erro de ligação. Por favor, tente de novo''',
                            style: Theme.of(context).textTheme.headline4)));
          default:
            return contentChecker
                ? contentGenerator(content, context)
                : Container(
                    padding: EdgeInsets.all(8),
                    child: Center(
                        child: Text('''Sem dados. Atualize a página''',
                            style: Theme.of(context).textTheme.headline4)));
        }
      },
    );
  }
}
