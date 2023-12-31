import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swagapp/modules/blocs/search_bloc.dart/search_bloc.dart';

import 'package:swagapp/modules/common/utils/palette.dart';
import '../../../common/ui/body_widget_with_view.dart';
import '../../../common/ui/loading.dart';
import '../../../common/utils/custom_route_animations.dart';
import '../../../data/shared_preferences/shared_preferences_service.dart';
import '../../../di/injector.dart';
import '../../../models/search/filter_model.dart';
import '../../../models/search/search_request_payload_model.dart';

class WhatsHotPage extends StatefulWidget {
  static const name = '/WhatsHot';
  const WhatsHotPage({Key? key}) : super(key: key);

  static Route route() => PageRoutes.material(
        settings: const RouteSettings(name: name),
        builder: (context) => const WhatsHotPage(),
      );

  @override
  State<WhatsHotPage> createState() => _WhatsHotPageState();
}

class _WhatsHotPageState extends State<WhatsHotPage> {
  @override
  void initState() {
    super.initState();
    bool isLogged = getIt<PreferenceRepositoryService>().isLogged();
    bool isLoggedAfterGuest =
        getIt<PreferenceRepositoryService>().loginAfterGuest();

    if (isLogged && isLoggedAfterGuest) {
      makeCall();
      getIt<PreferenceRepositoryService>().saveloginAfterGuest(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Palette.current.primaryNero,
        body: BlocConsumer<SearchBloc, SearchState>(
          listener: (context, state) => state.maybeWhen(
            orElse: () => {
              if (Loading.isVisible()) {Loading.hide(context)}
            },
            error: (message) => {
              Loading.hide(context),
              // Dialogs.showOSDialog(context, 'Error', message, 'OK', () {})
            },
            initial: () => {
              if (!Loading.isVisible()) {Loading.show(context)}
            },
          ),
          builder: (context, state) {
            return state.maybeMap(
              orElse: () => const Center(),
              error: (_) {
                return RefreshIndicator(
                    onRefresh: () async {
                      makeCall();
                      return Future.delayed(const Duration(milliseconds: 1500));
                    },
                    child: ListView.builder(
                      itemBuilder: (_, index) => Container(),
                      itemCount: 0,
                    ));
              },
              result: (state) {
                if (state.result[SearchTab.whatsHot] != null) {
                  return BodyWidgetWithView(
                      state.result[SearchTab.whatsHot] ?? [],
                      SearchTab.whatsHot);
                } else {
                  return const Center();
                }
              },
            );
          },
        ));
  }

  Future<void> makeCall() async {
    context.read<SearchBloc>().add(SearchEvent.performSearch(
        SearchRequestPayloadModel(
            categoryId:
                await SearchTabWrapper(SearchTab.whatsHot).toStringCustom(),
            filters: const FilterModel()),
        SearchTab.whatsHot));
  }
}
