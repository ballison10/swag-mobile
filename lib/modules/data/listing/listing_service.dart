import 'dart:typed_data';

import '../../api/api.dart';
import '../../api/api_service.dart';
import '../../models/listing_for_sale/listing_for_sale_model.dart';
import '../../models/update_profile/update_avatar_model.dart';
import 'i_listing_service.dart';

class ListingService extends IListingService {
  ListingService(this.apiService);

  final APIService apiService;

  @override
  Stream<String?> subscribeToAuthChanges() => Stream.value(null);

  @override
  Future<ListingForSaleModel> createListing(ListingForSaleModel model) async {
    ListingForSaleModel response = await apiService.getEndpointData(
      endpoint: Endpoint.createListingForSale,
      method: RequestMethod.post,
      body: model.toJson(),
      needBearer: true,
      fromJson: (json) => ListingForSaleModel.fromJson(json),
    );
    return response;
  }

  @override
  Future<UpdateAvatarModel> uploadListingImage(
      Uint8List bytes, String topicId) async {
    UpdateAvatarModel response = await apiService.getEndpointData(
      endpoint: Endpoint.uploadImageListingForSale,
      method: RequestMethod.multipart,
      dynamicParam: topicId,
      needBearer: true,
      bytes: bytes,
      fromJson: (json) => UpdateAvatarModel.fromJson(json),
    );
    return response;
  }
}
