import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:swagapp/modules/models/buy_for_sale_listing/buy_for_sale_listing_model.dart';
import 'package:swagapp/modules/pages/add/buy/preview_buy_for_sale.dart';

import '../../../generated/l10n.dart';
import '../../blocs/listing_bloc/listing_bloc.dart';
import '../../common/ui/refresh_widget.dart';
import '../../common/ui/simple_loader.dart';
import '../../common/utils/custom_route_animations.dart';
import '../../common/utils/palette.dart';
import '../../common/utils/utils.dart';
import '../../cubits/listing_for_sale/get_listing_for_sale_cubit.dart';
import '../../di/injector.dart';
import '../../models/listing_for_sale/listing_for_sale_model.dart';
import '../../models/listing_for_sale/profile_listing_model.dart';

class ListingsPage extends StatefulWidget {
  static const name = '/Listings';
  const ListingsPage({Key? key}) : super(key: key);

  static Route route() => PageRoutes.material(
        settings: const RouteSettings(name: name),
        builder: (context) => const ListingsPage(),
      );

  @override
  State<ListingsPage> createState() => _ListingsPageState();
}

class _ListingsPageState extends State<ListingsPage> {
  List<File> tempFiles = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadList();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future loadList() async {
    getIt<ListingProfileCubit>().loadResults();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListingProfileCubit, ListingCubitState>(
        builder: (context, state) {
      return state.maybeWhen(
          orElse: () {
            return Container();
          },
          initial: () => ListView.builder(
                itemBuilder: (_, index) => SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: const Center(child: SimpleLoader()),
                ),
                itemCount: 1,
              ),
          loadedProfileListings:
              (List<ListingForSaleProfileResponseModel> listForSale) {
            return _getBody(listForSale.first.listForSale);
          });
    });
  }

  Widget _getBody(List<ListingForSaleModel> listingList) {
    return listingList.isNotEmpty
        ? RefreshWidget(
            onRefresh: loadList,
            child: Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: GridView.builder(
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12.0,
                  mainAxisSpacing: 12.0,
                  mainAxisExtent: 215,
                ),
                itemCount: listingList.length,
                itemBuilder: (_, index) {
                  ListingForSaleModel listItem = listingList[index];
                  var catalogItemId = listingList[index].catalogItemId;
                  var imageUrls = listingList[index].productItemImageUrls ?? [];
                  var productItemName =
                      listingList[index].productItemName ?? "";
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (catalogItemId != null) {
                                Navigator.of(context, rootNavigator: true).push(
                                    MaterialPageRoute(
                                        builder: (context) => BuyPreviewPage(
                                            productItemId:
                                                listItem.productItemId,
                                            catalogItmId:
                                                listItem.catalogItemId)));
                              }
                            },
                            child: SizedBox(
                              height: MediaQuery.of(context).size.width * 0.37,
                              child: ClipRRect(
                                child: CachedNetworkImage(
                                  fit: BoxFit.fitHeight,
                                  imageUrl: (imageUrls.isNotEmpty)
                                      ? listingList[index]
                                          .productItemImageUrls[0]
                                      : 'assets/images/Avatar.png',
                                  placeholder: (context, url) => SizedBox(
                                    height: 200,
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        color: Palette.current.primaryNeonGreen,
                                        backgroundColor: Colors.white,
                                      ),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Image.asset(
                                          "assets/images/ProfilePhoto.png"),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Text(productItemName.toUpperCase(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .copyWith(
                                  letterSpacing: 1,
                                  fontWeight: FontWeight.w300,
                                  fontFamily: "KnockoutCustom",
                                  fontSize: 21,
                                  color: Palette.current.white)),
                      Text(
                          '${S.of(context).for_sale}: ${decimalDigitsLastSalePrice(listingList[index].lastSale.toString())}',
                          overflow: TextOverflow.fade,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 13,
                                  color: Palette.current.primaryNeonGreen)),
                    ],
                  );
                },
              ),
            ),
          )
        : ListView.builder(
            itemBuilder: (_, index) => SizedBox(
              height: MediaQuery.of(context).size.height * 0.30,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 70.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/UnFavorite.png",
                      scale: 3,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Text(
                        textAlign: TextAlign.center,
                        S.of(context).empty_listing,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontFamily: "KnockoutCustom",
                            fontWeight: FontWeight.w300,
                            fontSize: 30,
                            letterSpacing: 1.2,
                            color: Palette.current.darkGray),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            itemCount: 1,
          );
  }

  void makeCall() {
    context.read<ListingBloc>().add(const ListingEvent.getListingItem());
  }
}
