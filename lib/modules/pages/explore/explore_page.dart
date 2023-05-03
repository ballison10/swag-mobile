import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swagapp/generated/l10n.dart';

import 'package:swagapp/modules/common/ui/loading.dart';
import 'package:swagapp/modules/common/utils/palette.dart';
import 'package:swagapp/modules/data/filters/filters_service.dart';
import 'package:swagapp/modules/models/filters/dynamic_filters.dart';
import 'package:swagapp/modules/models/shared_preferences/shared_preference_model.dart';

import '../../blocs/explore_bloc/explore_bloc.dart';
import '../../common/ui/custom_app_bar.dart';
import '../../common/utils/custom_route_animations.dart';
import '../../data/shared_preferences/shared_preferences_service.dart';
import '../../di/injector.dart';
import '../../models/explore/explore_item_model.dart';

import '../../models/profile/profile_model.dart';
import 'account_info.dart';

class ExplorePage extends StatefulWidget {
  static const name = '/ExplorePage';
  const ExplorePage({Key? key}) : super(key: key);

  static Route route() => PageRoutes.material(
        settings: const RouteSettings(name: name),
        builder: (context) => const ExplorePage(),
      );

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  bool _isLogged = false;
  bool _hasJustSignedUp = false;

  late final ScrollController? _scrollController =
      PrimaryScrollController.of(context);

  @override
  void initState() {
    this.loadDynamicFilters();
    this._isLogged = getIt<PreferenceRepositoryService>().isLogged();
    this._hasJustSignedUp =
        getIt<PreferenceRepositoryService>().hasJustSignedUp();

    if (!_isLogged) {
      getIt<PreferenceRepositoryService>().saveloginAfterGuest(true);
    }
    if (_isLogged && _hasJustSignedUp) {
      getIt<PreferenceRepositoryService>().saveHasJustSignedUp(false);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.black,
        appBar: !_isLogged ? CustomAppBar() : null,
        body: BlocConsumer<ExploreBloc, ExploreState>(
          listener: (context, state) => state.maybeWhen(
            orElse: () => {Loading.hide(context)},
            error: (message) => {
              Loading.hide(context),
              // Dialogs.showOSDialog(context, 'Error', message, 'OK', () {})
            },
            initial: () {
              return Loading.show(context);
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
              loadedExploreItems: (state) {
                return _getBody(state.exploreList);
              },
            );
          },
        ));
  }

  Widget _getBody(List<ExploreItemModel> exploreList) {
    return RefreshIndicator(
      onRefresh: () async {
        makeCall();
        return Future.delayed(const Duration(milliseconds: 1500));
      },
      child: exploreList.isNotEmpty
          ? _exploreList(exploreList, this._scrollController!)
          : ListView.builder(
              itemBuilder: (_, index) => SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                child: Center(
                  child: Text(
                    S.of(context).empty_text,
                    style: TextStyle(
                        fontSize: 24, color: Colors.black.withOpacity(0.50)),
                  ),
                ),
              ),
              itemCount: 1,
            ),
    );
  }

  Widget _exploreList(
      List<ExploreItemModel> exploreList, ScrollController scrollController) {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Column(
        children: [
          Expanded(
              child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: exploreList.length,
                  itemBuilder: (BuildContext ctx, int index) {
                    return SizedBox(
                      height: 360,
                      child: Stack(children: [
                        CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: exploreList[index].image,
                          placeholder: (context, url) => SizedBox(
                            height: 360,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: Palette.current.primaryNeonGreen,
                                backgroundColor: Colors.white,
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              Image.asset("assets/images/ProfilePhoto.png"),
                        ),
                      ]),
                    );
                  }))
        ],
      ),
    );
  }

  void makeCall() {
    context.read<ExploreBloc>().add(const ExploreEvent.getExploreItems());
  }

  void navigateToAccountInfoPage() {
    bool loginAfterGuest =
        getIt<PreferenceRepositoryService>().loginAfterGuest();
    ProfileModel profileData =
        getIt<PreferenceRepositoryService>().profileData();

    Future.delayed(Duration(milliseconds: loginAfterGuest ? 5000 : 7000), () {
      Navigator.of(context, rootNavigator: true).push(AccountInfoPage.route());
    });
  }

  void loadDynamicFilters() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      DynamicFilters dynamicFilters =
          await getIt<FiltersService>().getDynamicFilters();
      await getIt<PreferenceRepositoryService>()
          .saveDynamicFilters(dynamicFilters);
    });
  }
}
