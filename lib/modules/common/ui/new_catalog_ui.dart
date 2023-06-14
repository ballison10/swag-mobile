import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swagapp/modules/cubits/favorites/get_favorites_cubit.dart';
import 'package:swagapp/modules/cubits/favorites/get_favorites_cubit.dart';
import 'package:swagapp/modules/models/detail/detail_item_model.dart';

import '../../../generated/l10n.dart';
import '../../blocs/favorite_bloc/favorite_item_bloc.dart';
import '../../cubits/favorites/get_favorites_cubit.dart';
import '../../data/shared_preferences/shared_preferences_service.dart';
import '../../di/injector.dart';
import '../../models/favorite/favorite_item_model.dart';
import '../../models/favorite/favorite_model.dart';
import '../../models/favorite/profile_favorite_list.dart';
import '../../models/search/catalog_item_model.dart';
import '../../pages/add/collection/add_collection_page.dart';
import '../../pages/detail/item_detail_page.dart';
import '../../pages/login/create_account_page.dart';
import '../utils/palette.dart';
import '../utils/utils.dart';
import 'popup_add_exisiting_item_collection.dart';

class NewCatalogPage extends StatefulWidget {
  const NewCatalogPage({
    super.key,
    required this.catalogItems,
    required this.scrollController,
  });

  final List<CatalogItemModel> catalogItems;
  final ScrollController scrollController;

  @override
  State<NewCatalogPage> createState() => _NewCatalogPageState();
}

class _NewCatalogPageState extends State<NewCatalogPage> {
  double animateFavorite = 0.0;
  bool isSkullVisible = true;
  int? indexFavorite;
  bool isLogged = false;
  int indexList = 0;

  List<CatalogItemModel> catalogList = [];
  ListFavoriteProfileResponseModel favoriteList = const ListFavoriteProfileResponseModel(favoriteList: []);

  @override
  void initState() {
    getFavoritesList();
    setState(() {
      catalogList = [...widget.catalogItems];
    });

    super.initState();

    isLogged = getIt<PreferenceRepositoryService>().isLogged();
  }

  onChangeFavoriteAnimation(int index) async {
    setState(() {
      isSkullVisible = true;
      animateFavorite = 130.0;
      indexFavorite = index;
    });
    Future.delayed(const Duration(milliseconds: 700), () {
      setState(() {
        isSkullVisible = false;
        animateFavorite = 0.0;
      });

      Future.delayed(const Duration(milliseconds: 200), () {
        setState(() {
          isSkullVisible = true;
        });
      });
    });
  }

  getFavoritesList()async{      
          await getIt<FavoriteProfileCubit>().loadResults();
         
  }

  @override
  void didUpdateWidget(covariant NewCatalogPage oldWidget) {
    setState(() => this.catalogList = this.widget.catalogItems);
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        controller: this.widget.scrollController,
        separatorBuilder: (context, index) => const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Divider(
                color: Colors.transparent,
              ),
            ),
        itemCount: widget.catalogItems.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context, rootNavigator: true).push(
                  ItemDetailPage.route(catalogList[index].catalogItemId, (val) {
                setState(() {
                  catalogList[index] =
                      catalogList[index].copyWith(inFavorites: val);

                  if (!val) {
                    catalogList[index] = catalogList[index]
                        .copyWith(profileFavoriteItemId: null);
                  }
                });
              }));
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // BlocListener<FavoriteProfileCubit, FavoriteCubitState>(
                //   listener: (context, state) {
                //     if(state is LoadedFavoritesState){
                //        favoriteLIst = state.profileFavoriteList; 
                //        setState(() {
                         
                //        });   
                //     }
                //   },
                //   child: Container(),
                // ),
                BlocBuilder<FavoriteItemBloc, FavoriteItemState>(
                    builder: (context, favoriteItemState) {
                  return favoriteItemState.maybeMap(
                      orElse: () => Container(),
                      removedFavoriteItem: (state) {
                        if (catalogList[indexList].profileFavoriteItemId !=
                            null) {
                          catalogList[indexList] = catalogList[indexList]
                              .copyWith(inFavorites: false);

                          catalogList[indexList] = catalogList[indexList]
                              .copyWith(profileFavoriteItemId: null);
                        }

                        return Container();
                      },
                      loadedFavoriteItem: (state) {
                        if (catalogList[indexList].profileFavoriteItemId ==
                            null) {
                          catalogList[indexList] = catalogList[indexList]
                              .copyWith(
                                  profileFavoriteItemId: state
                                      .dataFavoriteItem
                                      .profileFavoriteItems![0]
                                      .profileFavoriteItemId);
                        }

                        return Container();
                      });
                }),
                Stack(
                  children: [
                    CachedNetworkImage(
                      imageUrl: catalogList[index].catalogItemImage,
                      placeholder: (context, url) => SizedBox(
                        height: 340,
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
                    Positioned(
                        top: 0,
                        right: 0,
                        child: IconButton(
                          icon: Icon(
                            Icons.add,
                            color: Palette.current.grey,
                          ),
                          onPressed: () {
                            if (isLogged) {
                              if (catalogList[index]
                                  .collectionItems!
                                  .isNotEmpty) {
                                showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return PopUpAddExisitingItemCollection(
                                          onAdd: () => Navigator.of(context, 
                                                  rootNavigator: true)
                                              .push(AddCollection.route(
                                                  context,
                                                  catalogList[index]
                                                      .catalogItemId,
                                                  catalogList[index]
                                                      .catalogItemImage,
                                                  catalogList[index]
                                                      .catalogItemName)));
                                    });
                              } else {
                                Navigator.of(context, rootNavigator: true).push(
                                    AddCollection.route(
                                        context,
                                        widget
                                            .catalogItems[index].catalogItemId,
                                        catalogList[index].catalogItemImage,
                                        catalogList[index].catalogItemName));
                              }
                            } else {
                              Navigator.of(context, rootNavigator: true)
                                  .push(CreateAccountPage.route());
                            }
                          },
                        )),
                    Visibility(
                      visible: isSkullVisible,
                      child: Positioned.fill(
                        child: Align(
                          alignment: Alignment.center,
                          child: AnimatedContainer(
                              height: (index == indexFavorite)
                                  ? animateFavorite
                                  : 0,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                              child: Image.asset(
                                "assets/images/IconsBig.png",
                                scale: 3,
                              )),
                        ),
                      ),
                    ),
                    catalogList[index].forSale
                        ? Positioned(
                            bottom: 0,
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Container(
                                  color: Palette.current.primaryNeonPink,
                                  height: 40,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 20.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          "${catalogList[index].numberAvailable} ${S.of(context).for_sale}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Ringside',
                                                  fontSize: 14,
                                                  color: Palette.current
                                                      .primaryWhiteSmoke),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Container(),
                  ],
                ),
                const SizedBox(
                  height: 6,
                ),
                Row(
                  children: [
                    Expanded(
                        flex: 5,
                        child: Column(
                          children: [
                            Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Text(
                                      overflow: TextOverflow.ellipsis,
                                      catalogList[index]
                                          .catalogItemName
                                          .toUpperCase(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayLarge!
                                          .copyWith(
                                              letterSpacing: 0.54,
                                              fontWeight: FontWeight.w300,
                                              fontFamily: "KnockoutCustom",
                                              fontSize: 30,
                                              color: Palette.current.white)),
                                )),
                          ],
                        )),
                    BlocBuilder<FavoriteProfileCubit, FavoriteCubitState>(          
                      builder: (context,state){
                     if(state is LoadedFavoritesState){
                      favoriteList = state.profileFavoriteList;
                      return Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: IconButton(
                                    key: Key(catalogList[index].catalogItemId),
                                    icon: Image.asset(
                                      catalogList[index].inFavorites
                                          ? "assets/images/Favorite.png"
                                          : "assets/images/UnFavorite.png",
                                      scale: 3.5,
                                    ),
                                    onPressed: () async {
                                      setState(() {
                                        if (isLogged) {
                                          if (favoriteList.favoriteList.toString().contains(catalogList[index].catalogItemId)) {
                                            BlocProvider.of<FavoriteItemBloc>(
                                                    context)
                                                .add(FavoriteItemEvent
                                                    .removeFavoriteItem(
                                                        FavoriteModel(
                                                            favoritesItemAction:
                                                                "DELETE",
                                                            profileFavoriteItems: [
                                                  FavoriteItemModel(
                                                      profileFavoriteItemId:
                                                          widget.catalogItems[index]
                                                              .profileFavoriteItemId,
                                                      catalogItemId:
                                                          catalogList[index]
                                                              .catalogItemId)
                                                ])));
                                            catalogList[index] =
                                                catalogList[index].copyWith(
                                                    inFavorites: false);

                                            setState(() {
                                              indexList = index;
                                            });
                                          } else {
                                            BlocProvider.of<FavoriteItemBloc>(
                                                    context)
                                                .add(FavoriteItemEvent
                                                    .addFavoriteItem(FavoriteModel(
                                                        favoritesItemAction:
                                                            "ADD",
                                                        profileFavoriteItems: [
                                                  FavoriteItemModel(
                                                      catalogItemId:
                                                           widget.catalogItems[index]
                                                              .catalogItemId)
                                                ])));
                                            catalogList[index] =
                                                catalogList[index].copyWith(
                                                    inFavorites: true);

                                            setState(() {
                                              indexList = index;
                                            });
                                            onChangeFavoriteAnimation(index);
                                          }
                                        } else {
                                          Navigator.of(context,
                                                  rootNavigator: true)
                                              .push(CreateAccountPage.route());
                                        }
                                      });
                                    },
                                  ),
                                )),
                          ],
                        ));
                     }else{
                      return IconButton(onPressed: (){},  icon: Image.asset(
                                      catalogList[index].inFavorites
                                          ? "assets/images/Favorite.png"
                                          : "assets/images/UnFavorite.png",
                                      scale: 3.5,
                                    ));
                     }
                    })

                    // Expanded(
                    //     flex: 2,
                    //     child: Column(
                    //       children: [
                    //         Padding(
                    //             padding: const EdgeInsets.symmetric(
                    //                 horizontal: 12.0),
                    //             child: Align(
                    //               alignment: Alignment.centerRight,
                    //               child: IconButton(
                    //                 icon: Image.asset(
                    //                //   contains(DetailItemModel(catalogItemId: catalogList[index].catalogItemId, catalogItemName: catalogList[index].catalogItemName, )))
                    //                  (favoriteLIst.favoriteList.toString().contains(catalogList[index].catalogItemId))
                    //                       ? "assets/images/Favorite.png"
                    //                       : "assets/images/UnFavorite.png",
                    //                   scale: 3.5,
                    //                 ),
                    //                 onPressed: () async {
                    //                   setState(() {
                    //                     if (isLogged) {
                    //                       if ( (favoriteLIst.favoriteList.toString().contains(catalogList[index].catalogItemId))) {
                    //                         BlocProvider.of<FavoriteItemBloc>(
                    //                                 context)
                    //                             .add(FavoriteItemEvent
                    //                                 .removeFavoriteItem(
                    //                                     FavoriteModel(
                    //                                         favoritesItemAction:
                    //                                             "DELETE",
                    //                                         profileFavoriteItems: [
                    //                               FavoriteItemModel(
                    //                                   profileFavoriteItemId:
                    //                                       widget.catalogItems[index]
                    //                                           .profileFavoriteItemId,
                    //                                   catalogItemId:
                    //                                       widget.catalogItems[index]
                    //                                           .catalogItemId)
                    //                             ])));
                    //                         catalogList[index] =
                    //                             catalogList[index].copyWith(
                    //                                 inFavorites: false);

                    //                         setState(() {
                    //                           indexList = index;
                    //                         });
                    //                       } else {
                    //                         BlocProvider.of<FavoriteItemBloc>(
                    //                                 context)
                    //                             .add(FavoriteItemEvent
                    //                                 .addFavoriteItem(FavoriteModel(
                    //                                     favoritesItemAction:
                    //                                         "ADD",
                    //                                     profileFavoriteItems: [
                    //                               FavoriteItemModel(
                    //                                   catalogItemId:
                    //                                       catalogList[index]
                    //                                           .catalogItemId)
                    //                             ])));
                    //                         catalogList[index] =
                    //                             catalogList[index].copyWith(
                    //                                 inFavorites: true);

                    //                         setState(() {
                    //                           indexList = index;
                    //                         });
                    //                         onChangeFavoriteAnimation(index);
                    //                       }
                    //                     } else {
                    //                       Navigator.of(context,
                    //                               rootNavigator: true)
                    //                           .push(CreateAccountPage.route());
                    //                     }
                    //                   });
                    //                 },
                    //               ),
                    //             )),
                    //       ],
                    //     ))
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: [
                      Text(
                          catalogList[index].forSale
                              ? '${S.of(context).for_sale}: ${decimalDigitsLastSalePrice(catalogList[index].saleInfo.minPrice!)} - ${decimalDigitsLastSalePrice(catalogList[index].saleInfo.maxPrice!)}'
                              : '${S.of(context).last_sale}: ${decimalDigitsLastSalePrice(catalogList[index].saleInfo.lastSale!)}',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                letterSpacing: 0.0244,
                                  fontWeight: FontWeight.w300,
                                  color: Palette.current.primaryNeonGreen))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                )
              ],
            ),
          );
        });
  }
}
