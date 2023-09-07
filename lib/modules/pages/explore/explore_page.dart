import 'package:flutter/material.dart';

import 'package:swagapp/modules/common/utils/palette.dart';
import 'package:swagapp/modules/data/filters/filters_service.dart';
import 'package:swagapp/modules/models/filters/dynamic_filters.dart';
import 'package:swagapp/modules/pages/explore/atomic_drop_banner.dart';
import ' shop_by_category_page.dart';
import '../../common/ui/custom_app_bar.dart';
import '../../common/utils/custom_route_animations.dart';
import '../../cubits/alert/alert_cubit.dart';
import '../../cubits/chat/chat_cubit.dart';
import '../../cubits/explore/get_explore_cubit.dart';
import '../../cubits/peer_to_peer_payments/peer_to_peer_payments_cubit.dart';
import '../../data/shared_preferences/shared_preferences_service.dart';
import '../../di/injector.dart';
import '../../models/explore/explore_payload_model.dart';
import 'account_info.dart';
import 'staff_picks_page.dart';
import 'unicorn_covers_page.dart';
import 'whats_hot_page.dart';

class ExplorePage extends StatefulWidget {
  static const name = '/ExplorePage';
  const ExplorePage(
      {Key? key, required this.pageFromExplore, this.refreshNotifier})
      : super(key: key);

  final Function() pageFromExplore;
  final ChangeNotifier? refreshNotifier;

  static Route route(Function() pageFromExplore) => PageRoutes.material(
        settings: const RouteSettings(name: name),
        builder: (context) => ExplorePage(
          pageFromExplore: pageFromExplore,
        ),
      );

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage>  {
  bool _isLogged = false;
  bool _hasJustSignedUp = false;

  late final ScrollController _scrollController =
      PrimaryScrollController.of(context);

  String chatUrl = '';

  void refresh() async {
    getIt<ExploreCubit>()
        .getUnicorn(const ExploreRequestPayloadModel(unicornFlag: true));
    getIt<ExploreCubit>()
        .getWhatsHot(const ExploreRequestPayloadModel(whatsHotFlag: true));

    getIt<ExploreCubit>()
        .getStaff(const ExploreRequestPayloadModel(staffPicksFlag: true));

    this._isLogged = getIt<PreferenceRepositoryService>().isLogged();
    this._hasJustSignedUp =
        getIt<PreferenceRepositoryService>().hasJustSignedUp();

    if (!_isLogged) {
      getIt<PreferenceRepositoryService>().saveloginAfterGuest(true);
    }
    if (_isLogged && _hasJustSignedUp) {
      getIt<PreferenceRepositoryService>().saveHasJustSignedUp(false);
    }
  }

  @override
  void initState() {
   getIt<ChatCubit>().connectSendBirdApp();
    this.loadDynamicFilters();
    getIt<AlertCubit>().updateAlertBadget();
    getIt<PeerToPeerPaymentsCubit>().getPyments();
    widget.refreshNotifier?.addListener(refresh);
    refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getIt<PreferenceRepositoryService>().setPageFromExplore(0);

    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      backgroundColor: Palette.current.blackSmoke,
      // appBar: !_isLogged
      //     ? CustomAppBar(onRoute: () {
      //         Navigator.of(context, rootNavigator: true).pop();
      //       })
      //     : null,
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
                      padding: EdgeInsets.only(top: _isLogged ? 0 : 0),
                      child: Column(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.42,
                            child: const AtomicDropBanner(),
                          ),
                          ShopByCategory(
                            pageFromExplore: () {
                              widget.pageFromExplore();
                            },
                          ),
                          const UnicornCoversPage(),
                          WhatsHotExplorePage(
                            pageFromExplore: () {
                              widget.pageFromExplore();
                            },
                          ),
                          const StaffPicksPage()
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
