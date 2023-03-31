import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swagapp/generated/l10n.dart';
import 'package:swagapp/modules/blocs/search_bloc.dart/search_bloc.dart';
import 'package:swagapp/modules/blocs/shared_preferences_bloc/shared_preferences_bloc.dart';
import 'package:swagapp/modules/common/ui/search_input.dart';
import 'package:swagapp/modules/common/utils/palette.dart';
import 'package:swagapp/modules/common/utils/utils.dart';
import 'package:swagapp/modules/data/shared_preferences/shared_preferences_service.dart';
import 'package:swagapp/modules/di/injector.dart';
import 'package:swagapp/modules/pages/search/filter/filters_bottom_sheet.dart';
import 'package:swagapp/modules/pages/search/search_on_tap_page.dart';
import 'package:badges/badges.dart' as badges;

class SearchResultField extends StatefulWidget {

  final String searchParam;
  final TextEditingController textEditingController;

  const SearchResultField({
    super.key, 
    required this.textEditingController, 
    required this.searchParam
  });

  @override
  State<SearchResultField> createState() => _SearchResultFieldState();
}

class _SearchResultFieldState extends State<SearchResultField> {
  @override
  Widget build(BuildContext context) {

    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 4),
          child: InkWell(
            onTap: () async {
              this.widget.textEditingController.text = '';
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Palette.current.primaryWhiteSmoke,
              size: 24,
            ),
          ),
        ),
        Expanded(
          child: InkWell(
            onTap: () {
              Navigator.of(context, rootNavigator: true)
                  .push(SearchOnTapPage.route());
            },
            child: SearchInput(
                prefixIcon: null,
                suffixIcon: null,
                enabled: false,
                controller: this.widget.textEditingController,
                hint: S.current.search_hint,
                resultViewBuilder: (_, controller) => Container(),
                onCancel: () {}),
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

                      await this.setIsForSale(context, !state.model.isForSale);
                      if (!mounted) return;
                      performSearch(context: context, tab: SearchTab.all);
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
                      Navigator.of(context, rootNavigator: true).push(
                          FiltersBottomSheet.route(context, searchParam: this.widget.searchParam,
                        ),
                      );
                    },
                    icon: badges.Badge(
                      showBadge: state.model.filtersAndSortsSelected > 0,
                      badgeContent: Stack(
                        alignment: Alignment.center,
                        children: [
                          const Icon(Icons.check, color: Colors.white, size: 6),
                          Text(
                            '${state.model.filtersAndSortsSelected}',
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
                        color: state.model.filtersAndSortsSelected > 0
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

  Future<void> setIsForSale(BuildContext context, bool isForSale) async {
    final preference = context.read<SharedPreferencesBloc>().state.model;
    context.read<SharedPreferencesBloc>().add(
        SharedPreferencesEvent.setPreference(
            preference.copyWith(isForSale: isForSale)));
    await getIt<PreferenceRepositoryService>().saveIsForSale(isForSale);
  }
}

