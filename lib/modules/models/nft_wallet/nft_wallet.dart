import 'package:freezed_annotation/freezed_annotation.dart';

part 'nft_wallet.freezed.dart';
part 'nft_wallet.g.dart';

@freezed
class NftWalletModel with _$NftWalletModel {
  const factory NftWalletModel({
    required final String walletAddress,
    required final bool? confirmed,
    required final String? verificationCode,
    required final String accountId,
  }) = _NftWalletModel;

  factory NftWalletModel.fromJson(Map<String, dynamic> json) =>
      _$NftWalletModelFromJson(json);

  static List<NftWalletModel> fromJsonList(List<dynamic> jsonList) => jsonList
      .cast<Map<String, dynamic>>()
      .map((json) => NftWalletModel.fromJson(json))
      .toList();
}
