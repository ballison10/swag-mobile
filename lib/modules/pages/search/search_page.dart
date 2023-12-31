import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:swagapp/generated/l10n.dart';
import 'package:swagapp/modules/common/ui/pushed_header.dart';
import 'package:swagapp/modules/common/ui/search_input.dart';
import 'package:swagapp/modules/common/utils/palette.dart';
import 'package:swagapp/modules/common/utils/utils.dart';
import 'package:swagapp/modules/pages/search/filter/filters_bottom_sheet.dart';
import 'package:swagapp/modules/pages/search/tabs/accessories_page.dart';
import 'package:swagapp/modules/pages/search/tabs/headcovers_page.dart';
import 'package:swagapp/modules/pages/search/tabs/putters_page.dart';
import 'package:swagapp/modules/pages/search/search_on_tap_page.dart';
import 'package:swagapp/modules/pages/search/tabs/whats_hot_page.dart';
import 'package:badges/badges.dart' as badges;

import '../../blocs/search_bloc.dart/search_bloc.dart';
import '../../blocs/shared_preferences_bloc/shared_preferences_bloc.dart';
import '../../common/utils/custom_route_animations.dart';
import '../../data/shared_preferences/shared_preferences_service.dart';
import '../../di/injector.dart';

class SearchPage extends StatefulWidget {
  static const name = '/SearchCatalog';
  const SearchPage({Key? key}) : super(key: key);

  static Route route() => PageRoutes.material(
        settings: const RouteSettings(name: name),
        builder: (context) => const SearchPage(),
      );

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin<SearchPage> {
  @override
  bool get wantKeepAlive => true;
  late final TabController _tabController;
  int selectedIndex = 0;
  final TextEditingController _textEditingController = TextEditingController();
  int filterIndicatorCounter = 0;

  List<dynamic> categoriesData = [];
  var tabLen = 0;

  @override
  void initState() {
    super.initState();
    getLastCategories();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() {
      final index = _tabController.index;
      initFilterAndSortsWithBloc(context, selectedProductNumber: index);

      context.read<SearchBloc>().add(SearchEvent.selectTab(
          SearchTab.values[index],
          true)); //preference.filtersAndSortsSelected > 0 //TODO logic to update only if there was a change in filters and sorts between tabs

      if (index > 0) {
        filterIndicatorCounter = 1;
      } else {
        filterIndicatorCounter = 0;
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> getLastCategories() async {
    categoriesData =
        await getIt<PreferenceRepositoryService>().getLastCategories();
    Future.delayed(const Duration(milliseconds: 150), () {
      setState(() {
        setState(() {
          tabLen = categoriesData.length;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return DefaultTabController(
      length: 4,
      child: Scaffold(
          appBar: PushedHeader(
            customWidget: Column(
              children: [
                _searchField(context, S.of(context).search_hint),
                Container(
                  color: Palette.current.darkGray,
                  height: 0.2,
                ),
              ],
            ),
            height: 62,
          ),
          backgroundColor: Palette.current.primaryNero,
          body: getBody()),
    );
  }

  Widget getBody() {
    return Column(
      children: [
        tabLen == 0 ? Container() : _getTabBar(context),
        Expanded(
          child: TabBarView(controller: _tabController, children: const [
            WhatsHotPage(),
            HeadcoversPage(),
            PuttersPage(),
            AccessoriesPage(),
          ]),
        ),
      ],
    );
  }

  Widget _searchField(BuildContext context, String title) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 4),
          child: Image.asset(
            "assets/icons/Search.png",
            height: 20,
            width: 20,
          ),
        ),
        Expanded(
          child: InkWell(
            onTap: () async {
              PersistentNavBarNavigator.pushNewScreen(
                context,
                screen: SearchOnTapPage(),
                withNavBar: true,
                pageTransitionAnimation: PageTransitionAnimation.cupertino,
              ).then((completion) async {
                initFilterAndSortsWithBloc(context,
                    selectedProductNumber: _tabController.index);
                await initFiltersAndSorts(
                    selectedProductNumber: _tabController.index);
                if (!mounted) return;
                performSearch(context,
                    tab: SearchTab.values.elementAt(_tabController.index));
              });
            },
            child: SearchInput(
                prefixIcon: null,
                suffixIcon: null,
                enabled: false,
                controller: _textEditingController,
                hint: title,
                resultViewBuilder: (_, controller) => Container(),
                onCancel: () {
                  // _textEditingController.text = '';
                  // context
                  //     .read<CategoryBloc>()
                  //     .add(const CategoryEvent.refresh());
                  // context.read<SearchBloc>().add(const SearchEvent.reset());
                }),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Row(
            children: [
              BlocBuilder<SharedPreferencesBloc, SharedPreferencesState>(
                  builder: (context, stateSharedPreferences) {
                return stateSharedPreferences.map(
                  setPreference: (state) => IconButton(
                    onPressed: () async {
                      await setIsForSale(!state.model.isForSale);
                      if (!mounted) return;
                      performSearch(context,
                          // isForsale: !state.model.isForSale,
                          tab:
                              SearchTab.values.elementAt(_tabController.index));
                    },
                    icon: Image.asset(
                      "assets/icons/ForSale.png",
                      color: state.model.isForSale
                          ? Palette.current.primaryNeonGreen
                          : Palette.current.primaryWhiteSmoke,
                      height: 20,
                      width: 20,
                    ),
                  ),
                );
              }),
              BlocBuilder<SharedPreferencesBloc, SharedPreferencesState>(
                  builder: (context, stateSharedPreferences) {
                return stateSharedPreferences.map(
                  setPreference: (state) => IconButton(
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true)
                          .push(FiltersBottomSheet.route(
                        tab: SearchTab.values[_tabController.index],
                        context,
                      ));
                    },
                    icon: badges.Badge(
                      showBadge: (state.model.filtersAndSortsSelected +
                              filterIndicatorCounter) >
                          0,
                      badgeContent: Stack(
                        alignment: Alignment.center,
                        children: [
                          const Icon(Icons.check, color: Colors.white, size: 6),
                          Text(
                            '${(state.model.filtersAndSortsSelected + filterIndicatorCounter)}',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                    fontFamily: "Ringside",
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      position: badges.BadgePosition.topEnd(top: -16, end: -8),
                      badgeStyle: badges.BadgeStyle(
                          badgeColor: Palette.current.primaryNeonGreen),
                      child: Image.asset(
                        "assets/icons/Filter.png",
                        color: (state.model.filtersAndSortsSelected +
                                    filterIndicatorCounter) >
                                0
                            ? Palette.current.primaryNeonGreen
                            : Palette.current.primaryWhiteSmoke,
                        height: 20,
                        width: 20,
                      ),
                    ),
                  ),
                );
              })
            ],
          ),
        ),
      ],
    );
  }

  Future<void> setIsForSale(bool isForSale) async {
    final preference = context.read<SharedPreferencesBloc>().state.model;
    context.read<SharedPreferencesBloc>().add(
        SharedPreferencesEvent.setPreference(
            preference.copyWith(isForSale: isForSale)));
    await getIt<PreferenceRepositoryService>().saveIsForSale(isForSale);
  }

  Widget _getTabBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 0, right: 0),
      child: TabBar(
          controller: _tabController,
          labelColor: Palette.current.primaryNeonGreen,
          indicatorSize: TabBarIndicatorSize.label,
          unselectedLabelColor: Palette.current.primaryWhiteSmoke,
          unselectedLabelStyle: Theme.of(context)
              .textTheme
              .headlineMedium!
              .copyWith(
                  fontFamily: "KnockoutCustom",
                  fontSize: 20,
                  letterSpacing: 1.1,
                  fontWeight: FontWeight.w300),
          labelStyle: Theme.of(context).textTheme.headlineMedium!.copyWith(
              fontFamily: "KnockoutCustom",
              fontSize: 21,
              letterSpacing: 1.0,
              fontWeight: FontWeight.w300),
          onTap: (index) {
            setState(() {});
          },
          tabs: List<Widget>.generate(categoriesData.length, (index) {
            return Tab(
              child: _buildTab(
                text: categoriesData[index].categoryName.toUpperCase(),
              ),
            );
          })),
    );
  }
}

_buildTab({required String text}) {
  return Container(
    alignment: Alignment.center,
    width: double.infinity,
    child: Text(text),
  );
}
