import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../generated/l10n.dart';
import '../../blocs/collection_bloc/collection_bloc.dart';
import '../../common/ui/loading.dart';
import '../../common/utils/custom_route_animations.dart';
import '../../common/utils/palette.dart';
import '../../common/utils/size_helper.dart';
import '../../models/profile/profile_collection_model.dart';

class CollectionPage extends StatefulWidget {
  static const name = '/Collection';
  const CollectionPage({Key? key}) : super(key: key);

  static Route route() => PageRoutes.material(
        settings: const RouteSettings(name: name),
        builder: (context) => const CollectionPage(),
      );

  @override
  State<CollectionPage> createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  late ResponsiveDesign _responsiveDesign;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _responsiveDesign = ResponsiveDesign(context);
    return Scaffold(
        backgroundColor: Palette.current.primaryNero,
        body: BlocConsumer<CollectionBloc, CollectionState>(
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
              loadedCollectionItems: (state) {
                return _getBody(state.dataCollectionlList);
              },
            );
          },
        ));
  }

  Widget _getBody(List<CollectionItemModel> collectionList) {
    return RefreshIndicator(
      onRefresh: () async {
        makeCall();
        return Future.delayed(const Duration(milliseconds: 1500));
      },
      child: collectionList.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: GridView.builder(
                physics: ScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 17.0,
                  mainAxisSpacing: 12.0,
                  mainAxisExtent: 215,
                ),
                itemCount: collectionList.length + 1,
                itemBuilder: (_, index) {
                  return index == 0
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.width * 0.38,
                              color: Colors.black,
                              child: Stack(
                                children: [
                                  Positioned.fill(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: IconButton(
                                        icon: Image.asset(
                                          'assets/images/plus.png',
                                        ),
                                        onPressed: () {},
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(S.of(context).add_new_item,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .displayLarge!
                                    .copyWith(
                                        letterSpacing: 1,
                                        fontWeight: FontWeight.w300,
                                        fontFamily: "Knockout",
                                        fontSize: 24,
                                        color: Palette.current.white)),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.width * 0.38,
                                  child: ClipRRect(
                                    child: CachedNetworkImage(
                                      fit: BoxFit.fitHeight,
                                      imageUrl: collectionList[index - 1].image,
                                      placeholder: (context, url) => SizedBox(
                                        height: 200,
                                        child: Center(
                                          child: CircularProgressIndicator(
                                            color: Palette
                                                .current.primaryNeonGreen,
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
                                Positioned(
                                  top: 7,
                                  right: 0,
                                  child: Visibility(
                                    visible:
                                        collectionList[index - 1].totalMade !=
                                            0,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                            "${collectionList[index - 1].totalMade} X",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(
                                                    fontFamily: "Knockout",
                                                    fontSize: 30,
                                                    fontWeight: FontWeight.w500,
                                                    color: Palette.current
                                                        .primaryNeonGreen)),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Visibility(
                                      visible: collectionList[index - 1].sale,
                                      child: Container(
                                        height: 30,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          color:
                                              Palette.current.primaryNeonPink,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                                "${collectionList[index - 1].numberAvailable} ${S.of(context).for_sale}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Palette
                                                            .current.white)),
                                          ),
                                        ),
                                      )),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(collectionList[index - 1].catalogItemName,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .displayLarge!
                                    .copyWith(
                                        letterSpacing: 1,
                                        fontWeight: FontWeight.w300,
                                        fontFamily: "Knockout",
                                        fontSize: 24,
                                        color: Palette.current.white)),
                            Text(collectionList[index - 1].lastSale,
                                overflow: TextOverflow.fade,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 13,
                                        color:
                                            Palette.current.primaryNeonGreen)),
                          ],
                        );
                },
              ),
            )
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

  void makeCall() {
    context
        .read<CollectionBloc>()
        .add(const CollectionEvent.getCollectionItem());
  }
}