import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swagapp/modules/common/ui/profile_username_rating.dart';
import 'package:swagapp/modules/common/ui/pushed_header.dart';
import 'package:swagapp/modules/common/ui/refresh_widget.dart';
import 'package:swagapp/modules/common/ui/user_avatar.dart';
import 'package:swagapp/modules/common/utils/stateful_wrapper.dart';
import 'package:swagapp/modules/cubits/public_profile_favorites/public_profile_favorites_cubit.dart';
import 'package:swagapp/modules/cubits/public_profile_listings/public_profile_listings_cubit.dart';
import 'package:swagapp/modules/models/profile/public_profile.dart';
import 'package:swagapp/modules/pages/add/collection/widgets/custom_overlay_button.dart';
import 'package:swagapp/modules/pages/profile/favorites_page.dart';
import 'package:swagapp/modules/pages/profile/listings_page.dart';
import '../../../generated/l10n.dart';
import '../../common/ui/loading.dart';
import '../../common/ui/simple_loader.dart';
import '../../common/utils/custom_route_animations.dart';
import '../../common/utils/palette.dart';
import '../../common/utils/send_mail_contact.dart';
import '../../cubits/public_profile/public_profile_cubit.dart';
import '../../data/shared_preferences/shared_preferences_service.dart';
import '../../di/injector.dart';
import '../../models/detail/detail_item_model.dart';
import '../../models/listing_for_sale/listing_for_sale_model.dart';
import 'package:swagapp/modules/common/utils/utils.dart';

import '../../models/overlay_buton/overlay_button_model.dart';

class PublicProfilePage extends StatelessWidget {
  static const name = "/publicProfile";

  final String profileId;
  const PublicProfilePage({super.key, required this.profileId});

  static Route route(String profileId) => PageRoutes.material(
        settings: const RouteSettings(name: name),
        builder: (context) => PublicProfilePage(profileId: profileId),
      );

  @override
  Widget build(BuildContext context) {
    return StatefulWrapper(
      onInit: (context) {
        context.read<PublicProfileCubit>().loadProfile(
              profileId,
            );
        context.read<PublicProfileListingsCubit>().loadProfileListings(
              profileId,
            );
        context.read<PublicProfileFavoritesCubit>().loadProfileFavorites(
              profileId,
            );
      },
      child: Scaffold(
        appBar: PushedHeader(
          showBackButton: true,
          height: 70,
          backgroundColor: Colors.transparent,
          suffixIconButton: IconButton(
            icon: CustomOverlayButton(
              icon: Image.asset(
                "assets/images/more-horizontal.png",
                color: Palette.current.primaryWhiteSmoke,
              ),
              items: [
                CustomOverlayItemModel(
                  imagePath: "assets/icons/BlockUserWhite.png",
                  label: S.of(context).profile_report_user,
                ),
              ],
              onItemSelected: (selectedLabel) {
                if (selectedLabel == S.of(context).profile_report_user) {
                  _reportUser(context, profileId);
                }
              },
            ),
            onPressed: () {},
          ),
        ),
        backgroundColor: Palette.current.primaryNero,
        body: BlocConsumer<PublicProfileCubit, PublicProfileState>(
          listener: (context, state) {
            if (state.isLoadingWithoutPreviousData && !Loading.isVisible()) {
              Loading.show(context);
            } else if (!state.isLoading && Loading.isVisible()) {
              Loading.hide(context);
            }
          },
          builder: (context, state) {
            return state.when(
              error: (e, previousData) => Center(
                child: Text(
                  "Error loading profile: $e",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Palette.current.primaryNeonPink,
                      ),
                ),
              ),
              loading: (previousData) => previousData == null
                  ? Container()
                  : buildBody(context, previousData),
              loaded: (data) => buildBody(context, data),
            );
          },
        ),
      ),
    );
  }

  Future<void> _handleRefresh(BuildContext context) async {
    await context.read<PublicProfileCubit>().loadProfile(profileId);
    await context
        .read<PublicProfileListingsCubit>()
        .loadProfileListings(profileId);
    await context
        .read<PublicProfileFavoritesCubit>()
        .loadProfileFavorites(profileId);
  }

  buildBody(BuildContext context, PublicProfile profile) {
    return RefreshIndicator(
      onRefresh: () => _handleRefresh(context),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(height: 18),
            UserAvatar(
              useAvatar: profile.useAvatar,
              avatarUrl: profile.avatarUrl,
              radius: 125 / 2,
            ),
            const SizedBox(height: 14),
            ProfileUsernameRating(
              username: profile.username ?? "NULL",
              kycVerified: profile.kycverified ?? false,
              rating: profile.listingsRating ?? 0,
            ),
            const SizedBox(height: 25),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2,
              child: _PublicProfileTabs(
                profileId: profileId,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _reportUser(
  BuildContext context,
  String sellerId,
) {
  final profileData = getIt<PreferenceRepositoryService>().profileData();

  final sellerProfile =
      context.read<PublicProfileCubit>().state.dataOrPreviousData;
  if (sellerProfile == null || sellerProfile.accountId != sellerId) {
    // profile data may still be loading
    return;
  }

  final subject =
      "${profileData.username} Reported user ${sellerProfile.username}";
  final body = """I want to report a user

Reporter username: ${profileData.username}
Reporter account ID: ${profileData.accountId}
Reporter email: ${profileData.email}
Seller username: ${sellerProfile.username}
Seller account ID: ${sellerProfile.accountId}
""";
  SendMailContact.send(
    context: context,
    subject: subject,
    body: body,
  );
}

class _PublicProfileTabs extends StatefulWidget {
  final String profileId;
  const _PublicProfileTabs({
    super.key,
    required this.profileId,
  });

  @override
  State<_PublicProfileTabs> createState() => _PublicProfileTabsState();
}

class _PublicProfileTabsState extends State<_PublicProfileTabs>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      int index = _tabController.index;
      if (index == 0) {
        context
            .read<PublicProfileListingsCubit>()
            .loadProfileListings(widget.profileId);
      } else if (index == 1) {
        context
            .read<PublicProfileFavoritesCubit>()
            .loadProfileFavorites(widget.profileId);
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TabBar(
            isScrollable: true,
            dividerColor: Colors.transparent,
            indicatorColor: Palette.current.primaryNeonGreen,
            controller: _tabController,
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(
                width: 3,
                color: Palette.current.primaryNeonGreen,
              ),
            ),
            indicatorSize: TabBarIndicatorSize.label,
            labelPadding: const EdgeInsets.symmetric(horizontal: 20),
            labelColor: Palette.current.primaryNeonGreen,
            unselectedLabelColor: Palette.current.primaryWhiteSmoke,
            unselectedLabelStyle: Theme.of(context)
                .textTheme
                .headlineMedium!
                .copyWith(
                    fontFamily: "KnockoutCustom",
                    fontSize: 21,
                    letterSpacing: 1.1,
                    fontWeight: FontWeight.w300),
            labelStyle: Theme.of(context).textTheme.headlineMedium!.copyWith(
                fontFamily: "KnockoutCustom",
                fontSize: 21,
                letterSpacing: 1.1,
                fontWeight: FontWeight.w300),
            tabs: [
              Tab(
                child: Text(
                  S.of(context).tab_listings,
                ),
              ),
              Tab(
                child: Text(
                  S.of(context).tab_favorites,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _tabController,
            children: [
              _PublicProfileListing(
                profileId: widget.profileId,
              ),
              _PublicProfileFavorites(
                profileId: widget.profileId,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PublicProfileListing extends StatelessWidget {
  final String profileId;
  const _PublicProfileListing({
    super.key,
    required this.profileId,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshWidget(
      onRefresh: () async {
        return context
            .read<PublicProfileListingsCubit>()
            .loadProfileListings(profileId);
      },
      child:
          BlocBuilder<PublicProfileListingsCubit, PublicProfileListingsState>(
        builder: (context, state) {
          return state.when(
            loaded: (data) => buildBody(context, data),
            loading: (previousData) {
              if (previousData == null) {
                return const Center(child: SimpleLoader());
              }
              return buildBody(context, previousData);
            },
            error: (e, previousData) => Center(
              child: Text(
                "Error loading listings: $e",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Palette.current.primaryNeonPink,
                    ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildBody(BuildContext context, List<ListingForSaleModel> items) {
    if (items.isEmpty) {
      return _EmptyWidget(
        message: S.of(context).public_profile_empty_listing,
      );
    }
    return ProfileGrid(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return ListingGridItemWidget(
          productItemName: item.productItemName ?? "NULL",
          catalogItemId: item.catalogItemId,
          productItemId: item.productItemId!,
          imageUrl: (item.productItemImageUrls as List<dynamic>).firstOrNull,
          lastSale: item.lastSale,
        );
      },
    );
  }
}

class _PublicProfileFavorites extends StatelessWidget {
  final String profileId;
  const _PublicProfileFavorites({
    super.key,
    required this.profileId,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshWidget(
      onRefresh: () async {
        return context
            .read<PublicProfileFavoritesCubit>()
            .loadProfileFavorites(profileId);
      },
      child:
          BlocBuilder<PublicProfileFavoritesCubit, PublicProfileFavoritesState>(
        builder: (context, state) {
          return state.when(
            loaded: (data) => buildBody(context, data),
            loading: (previousData) {
              if (previousData == null) {
                return const Center(child: SimpleLoader());
              }
              return buildBody(context, previousData);
            },
            error: (e, previousData) => Center(
              child: Text(
                "Error loading listings: $e",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Palette.current.primaryNeonPink,
                    ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildBody(BuildContext context, List<DetailItemModel> items) {
    if (items.isEmpty) {
      return _EmptyWidget(
        message: S.of(context).public_profile_empty_favorites,
      );
    }
    return ProfileGrid(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return ProfileFavoriteGridItem(
          item: item,
          showFavoriteIcon: false,
        );
      },
    );
  }
}

class _EmptyWidget extends StatelessWidget {
  final String message;
  const _EmptyWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 60,
        vertical: 70,
      ),
      child: Column(
        children: [
          Image.asset(
            "assets/images/UnFavorite.png",
            width: 30,
            height: 30,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            textAlign: TextAlign.center,
            message.toUpperCase(),
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontFamily: "KnockoutCustom",
                  fontWeight: FontWeight.w300,
                  fontSize: 30,
                  letterSpacing: 1.2,
                  color: Palette.current.darkGray,
                ),
          ),
        ],
      ),
    );
  }
}
