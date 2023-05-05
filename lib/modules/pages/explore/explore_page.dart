import 'package:flutter/material.dart';

import 'package:swagapp/modules/common/utils/palette.dart';
import 'package:swagapp/modules/data/filters/filters_service.dart';
import 'package:swagapp/modules/models/filters/dynamic_filters.dart';

import ' shop_by_category_page.dart';

import '../../common/utils/custom_route_animations.dart';
import '../../data/shared_preferences/shared_preferences_service.dart';
import '../../di/injector.dart';

import '../../models/profile/profile_model.dart';
import 'account_info.dart';
import 'staff_picks_page.dart';
import 'unicorn_covers_page.dart';
import 'whats_hot_page.dart';

class ExplorePage extends StatefulWidget {
  static const name = '/ExplorePage';
  const ExplorePage({Key? key, this.pageFromExplore}) : super(key: key);

  final Function(int)? pageFromExplore;

  static Route route(Function(int)? pageFromExplore) => PageRoutes.material(
        settings: const RouteSettings(name: name),
        builder: (context) => ExplorePage(pageFromExplore: pageFromExplore),
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
    getIt<PreferenceRepositoryService>().setPageFromExplore(-1);

    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      backgroundColor: Palette.current.blackSmoke,
      body: Column(
        children: [
          Expanded(
            child: LayoutBuilder(builder: (context, viewportConstraints) {
              return SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: viewportConstraints.maxHeight,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Column(
                        children: const [
                          ShopByCategory(),
                          UnicornCoversPage(),
                          WhatsHotExplorePage(),
                          StaffPicksPage()
                        ],
                      ),
                    )),
              );
            }),
          ),
        ],
      ),
    );
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
