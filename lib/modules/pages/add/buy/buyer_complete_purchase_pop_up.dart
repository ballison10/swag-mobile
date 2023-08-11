import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart';
import 'package:swagapp/modules/common/ui/primary_button.dart';
import 'package:swagapp/modules/common/utils/palette.dart';

import '../../../../generated/l10n.dart';

import '../../../blocs/detail_bloc/detail_bloc.dart';
import '../../../common/ui/cupertino_custom_picker.dart';
import '../../../common/ui/custom_text_form_field.dart';
import '../../../common/ui/loading.dart';
import '../../../common/utils/context_service.dart';
import '../../../common/utils/utils.dart';
import '../../../constants/constants.dart';
import '../../../cubits/buy/buy_cubit.dart';
import '../../../cubits/chat/chat_cubit.dart';
import '../../../data/shared_preferences/shared_preferences_service.dart';
import '../../../di/injector.dart';
import '../../../models/buy_for_sale_listing/buy_a_listing_model.dart';
import '../../../models/buy_for_sale_listing/buy_a_listing_response_model.dart';
import '../../../models/chat/chat_data.dart';
import '../../../models/profile/profile_model.dart';
import '../../../models/settings/peer_to_peer_payments_get_model.dart';
import '../../../models/settings/peer_to_peer_payments_model.dart';
import '../../../models/update_profile/addresses_payload_model.dart';

import '../../chat/chatPage.dart';
import '../../settings/account/add_shipping_address_page.dart';

class BuyerCompletePurchasePopUp extends StatefulWidget {
  const BuyerCompletePurchasePopUp(
      {super.key, this.productItemId, required this.payments, this.catalogId});
  final String? productItemId;
  final String? catalogId;

  final PeerToPeerPaymentsModel payments;

  @override
  State<BuyerCompletePurchasePopUp> createState() =>
      _BuyerCompletePurchasePopUpState();
}

class _BuyerCompletePurchasePopUpState
    extends State<BuyerCompletePurchasePopUp> {
  ProfileModel profileData = getIt<PreferenceRepositoryService>().profileData();
  PeerToPeerPaymentsGetModel paymentData =
      getIt<PreferenceRepositoryService>().paymanetData();
  final FocusNode _paymentTypeNode = FocusNode();
  final _paymentTypeController = TextEditingController();
  Color _paymentTypeBorder = Palette.current.primaryWhiteSmoke;

  final FocusNode _shippedAddressNode = FocusNode();

  final FocusNode _addressNode = FocusNode();
  final _addressController = TextEditingController();
  Color _addressBorder = Palette.current.primaryWhiteSmoke;

  final FocusNode _countryNode = FocusNode();
  final _countryController = TextEditingController();
  Color _countryBorder = Palette.current.primaryWhiteSmoke;

  final FocusNode _cityNode = FocusNode();
  final _cityController = TextEditingController();
  Color _cityBorder = Palette.current.primaryWhiteSmoke;

  final FocusNode _stateNode = FocusNode();
  final _stateController = TextEditingController();

  final FocusNode _zipNode = FocusNode();
  final _zipController = TextEditingController();
  Color _zipBorder = Palette.current.primaryWhiteSmoke;

  String _defaultPaymentType = 'Payment Type';

  String _defaultCountry = 'United States';
  List<String> _states = ['State'];
  String _defaultState = 'State';

  bool checkBoxValue = false;

  late AddressesPayloadModel newCollectionList;

  List<AddressesPayloadModel> addresses = [];

  var paymentTypes = ['Payment Type'];

  var shippedAddress = [];

  String? paymentTypeErrorText;
  String? firstShippedAddressErrorText;
  String? shippedAddressErrorText;
  String? addressErrorText;
  String? cityErrorText;
  String? stateErrorText;
  String? zipErrorText;

  final TextEditingController _firstAddressController = TextEditingController();
  String? _selectedItem;

  bool _showDropdown = false;

  int value = 0;

  Future<void> updateAddressList() async {
    await Future.delayed(const Duration(milliseconds: 2000), () {});

    setState(() {
      profileData = getIt<PreferenceRepositoryService>().profileData();

      addresses = profileData.addresses!;

      shippedAddress = [];

      for (final address in profileData.addresses!) {
        final index = profileData.addresses!.indexOf(address);
        shippedAddress.add('${profileData.addresses![index].address1}');
      }

      _selectedItem = shippedAddress[0];
      _firstAddressController.text = _selectedItem ?? '';

      _addressController.text = addresses[0].address2 ?? '';
      _cityController.text = '${profileData.addresses![0].city}';
      _zipController.text = '${profileData.addresses![0].postalCode}';
      _defaultState = '${profileData.addresses![0].state}';
      _defaultCountry = '${profileData.addresses![0].country}';
      _countryController.text = '${profileData.addresses![0].country}';
    });
  }

  Future<void> addShippingAddress() async {
    await Future.delayed(const Duration(milliseconds: 500), () {});

    Navigator.of(context, rootNavigator: true)
        .push(AddShippingAddressPage.route(null, () {
      setState(() {
        updateAddressList();
      });
    }));
  }

  @override
  void initState() {
    if (widget.payments.venmoUser != null) {
      paymentTypes.add('Venmo');
    }
    if (widget.payments.cashTag != null) {
      paymentTypes.add('Cashapp');
    }

    if (widget.payments.payPalEmail != null) {
      paymentTypes.add('PayPal');
    }

    if (profileData.addresses!.isNotEmpty) {
      for (final address in profileData.addresses!) {
        final index = profileData.addresses!.indexOf(address);
        shippedAddress.add('${profileData.addresses![index].address1}');
      }
    } else {
      addShippingAddress();
    }

    var peerToPeerPaymentsJson = widget.payments.toJson();

    if (peerToPeerPaymentsJson.length == 1) {
      paymentTypes.remove('Payment Type');
      if (peerToPeerPaymentsJson.keys.first.contains('payPalEmail')) {
        _defaultPaymentType = 'PayPal';
      }

      if (peerToPeerPaymentsJson.keys.first.contains('cashTag')) {
        _defaultPaymentType = 'Cashapp';
      }

      if (peerToPeerPaymentsJson.keys.first.contains('venmoUser')) {
        _defaultPaymentType = 'Venmo';
      }
    }

    setState(() {
      if (profileData.addresses!.isNotEmpty) {
        addresses = profileData.addresses!;
      }
    });

    if (profileData.addresses!.isNotEmpty) {
      _selectedItem = shippedAddress[0];
      _firstAddressController.text = _selectedItem ?? '';

      _addressController.text = addresses[0].address2 ?? '';
      _cityController.text = '${profileData.addresses![0].city}';
      _zipController.text = '${profileData.addresses![0].postalCode}';
      _defaultState = '${profileData.addresses![0].state}';
      _defaultCountry = '${profileData.addresses![0].country}';
      _countryController.text = '${profileData.addresses![0].country}';
    }

    _paymentTypeNode.addListener(() {
      setState(() {
        _paymentTypeBorder = _paymentTypeNode.hasFocus
            ? Palette.current.primaryNeonGreen
            : Palette.current.primaryWhiteSmoke;
      });
    });

    _shippedAddressNode.addListener(() {
      setState(() {});
    });

    _countryNode.addListener(() {
      setState(() {
        _countryBorder = _countryNode.hasFocus
            ? Palette.current.primaryNeonGreen
            : Palette.current.primaryWhiteSmoke;
      });
    });

    _addressNode.addListener(() {
      setState(() {
        _addressBorder = _addressNode.hasFocus
            ? Palette.current.primaryNeonGreen
            : Palette.current.primaryWhiteSmoke;
      });
    });

    _cityNode.addListener(() {
      setState(() {
        _cityBorder = _cityNode.hasFocus
            ? Palette.current.primaryNeonGreen
            : Palette.current.primaryWhiteSmoke;
      });
    });

    _stateNode.addListener(() {
      setState(() {});
    });

    _zipNode.addListener(() {
      setState(() {
        _zipBorder = _zipNode.hasFocus
            ? Palette.current.primaryNeonGreen
            : Palette.current.primaryWhiteSmoke;
      });
    });
    _getStates(_defaultCountry);

    super.initState();
  }

  void _getStates(String country) async {
    _states = ['State'];
    var responseSatate = await getStates(country);
    _states.addAll(responseSatate as Iterable<String>);
    setState(() {});
  }

  Future<void> onTapSubmit(String channelUrl) async {
    late GroupChannel chatData;
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      chatData = await getIt<ChatCubit>().startChat(channelUrl);
      Loading.hide(context);

      if (Platform.isIOS) {
        await FirebaseMessaging.instance
            .setForegroundNotificationPresentationOptions(
          alert: false,
          badge: false,
          sound: false,
        );
      }

      getIt<PreferenceRepositoryService>().saveShowNotification(false);
      await Navigator.of(context, rootNavigator: true).push(
        MaterialPageRoute(
            builder: (BuildContext context) => ChatPage(channel: chatData)),
      );
      BlocProvider.of<DetailBloc>(context)
          .add(DetailEvent.getDetailItem(widget.catalogId ?? ''));
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      Navigator.of(context).pop();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BuyCubit, BuyStateCubit>(
        listener: (context, state) => state.maybeWhen(
              orElse: () {
                return null;
              },
              loadedBuyLisItem: (BuyASaleListingResponseModel buyItemlList) {
                onTapSubmit(buyItemlList.channelUrl ?? '');
                return null;
              },
            ),
        child: Center(
          child: Dialog(
            insetPadding: const EdgeInsets.all(15),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
            child: GestureDetector(
              onTap: () {
                _paymentTypeNode.unfocus();
                _shippedAddressNode.unfocus();
                _countryNode.unfocus();
                _addressNode.unfocus();
                _cityNode.unfocus();
                _stateNode.unfocus();
                _zipNode.unfocus();
                setState(() {
                  _showDropdown = false;
                });
              },
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Stack(
                  children: [
                    Container(
                      color: Palette.current.blackSmoke,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Column(
                              children: [
                                const SizedBox(
                                  height: 50,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                      S
                                          .of(context)
                                          .complete_purchase_title
                                          .toUpperCase(),
                                      textAlign: TextAlign.left,
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium!
                                          .copyWith(
                                            fontFamily: "KnockoutCustom",
                                            fontSize: 44,
                                            fontWeight: FontWeight.w300,
                                            color: Palette
                                                .current.primaryNeonGreen,
                                          )),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(S.of(context).complete_purchase_sub_title,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge!
                                        .copyWith(
                                            color: Palette
                                                .current.primaryWhiteSmoke,
                                            fontSize: 16)),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomTextFormField(
                                    borderColor: _paymentTypeBorder,
                                    autofocus: false,
                                    labelText: S.of(context).payment_types,
                                    errorText: paymentTypeErrorText,
                                    dropdownForm: true,
                                    dropdownFormItems: paymentTypes,
                                    dropdownvalue: _defaultPaymentType,
                                    dropdownOnChanged: (String? newValue) {
                                      setState(() {
                                        setState(() {
                                          _defaultPaymentType = newValue!;
                                        });
                                      });
                                    },
                                    focusNode: _paymentTypeNode,
                                    controller: _paymentTypeController,
                                    inputType: TextInputType.text),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(S.of(context).shipped_input_title,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge!
                                        .copyWith(
                                            color: Palette
                                                .current.primaryWhiteSmoke,
                                            fontSize: 16)),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomTextFormField(
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp("^.{0,50}\$")),
                                    ],
                                    readOnly: true,
                                    textCapitalization:
                                        TextCapitalization.words,
                                    borderColor: _countryBorder,
                                    autofocus: false,
                                    labelText: 'Country',
                                    focusNode: _countryNode,
                                    controller: _countryController,
                                    inputType: TextInputType.text),
                                Stack(
                                  children: [
                                    SizedBox(
                                      height: _showDropdown ? 200 : 100,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Colors.transparent,
                                                border: Border.all(
                                                    width: 0.5,
                                                    color:
                                                        firstShippedAddressErrorText != null
                                                            ? Palette.current
                                                                .primaryNeonPink
                                                            : Palette
                                                                .current.grey)),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 6),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    height: 55,
                                                    decoration: BoxDecoration(
                                                        color: Palette.current
                                                            .primaryWhiteSmoke),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 16, top: 4),
                                                      child: InputDecorator(
                                                        decoration:
                                                            InputDecoration(
                                                          suffixIcon:
                                                              IconButton(
                                                            icon: Image.asset(
                                                              'assets/images/IconDropdow.png',
                                                              width: 20,
                                                              height: 20,
                                                            ),
                                                            onPressed: () {
                                                              setState(() {
                                                                _showDropdown =
                                                                    !_showDropdown;
                                                              });
                                                            },
                                                          ),
                                                        ),
                                                        child: TextFormField(
                                                          controller:
                                                              _firstAddressController,
                                                          readOnly: true,
                                                          decoration:
                                                              const InputDecoration(
                                                            border: InputBorder
                                                                .none,
                                                          ),
                                                          onTap: () {
                                                            setState(() {
                                                              _showDropdown =
                                                                  true;
                                                            });
                                                          },
                                                          onChanged:
                                                              (String value) {
                                                            setState(() {
                                                              value = value
                                                                  .toLowerCase();
                                                            });
                                                            if (value.length >
                                                                30) {
                                                              value = value
                                                                  .substring(0,
                                                                      30); // Truncar el texto a 30 caracteres
                                                              _firstAddressController
                                                                      .value =
                                                                  TextEditingValue(
                                                                text: value,
                                                                selection: TextSelection
                                                                    .collapsed(
                                                                        offset:
                                                                            value.length),
                                                              );
                                                            }
                                                            setState(() {
                                                              _selectedItem =
                                                                  value;
                                                              _firstAddressController
                                                                  .text = value;
                                                              _firstAddressController
                                                                      .selection =
                                                                  TextSelection
                                                                      .fromPosition(
                                                                TextPosition(
                                                                    offset: _firstAddressController
                                                                        .text
                                                                        .length),
                                                              );
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    height:
                                                        firstShippedAddressErrorText !=
                                                                null
                                                            ? 1.5
                                                            : 0,
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    color: Palette.current
                                                        .primaryNeonPink,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          firstShippedAddressErrorText != null
                                              ? Align(
                                                  alignment:
                                                      Alignment.bottomLeft,
                                                  child: Text(
                                                    S
                                                        .of(context)
                                                        .required_field,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall!
                                                        .copyWith(
                                                            color: Palette
                                                                .current
                                                                .primaryNeonPink),
                                                  ),
                                                )
                                              : Container(),
                                        ],
                                      ),
                                    ),
                                    if (_showDropdown)
                                      Positioned(
                                        top: 0,
                                        left: 0,
                                        right: 0,
                                        bottom: 0,
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _showDropdown = false;
                                            });
                                          },
                                          child: Container(
                                            color: Colors.transparent,
                                          ),
                                        ),
                                      ),
                                    if (_showDropdown)
                                      Positioned(
                                        top: 30,
                                        left: 0,
                                        right: 0,
                                        bottom: 0,
                                        child: Material(
                                          elevation: 4.0,
                                          child: SizedBox(
                                            height: 200.0,
                                            child: Stack(
                                              children: [
                                                ListView.builder(
                                                  itemCount:
                                                      shippedAddress.length + 1,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    bool addAddress = (index +
                                                            1 >
                                                        shippedAddress.length);
                                                    final String option =
                                                        addAddress
                                                            ? '+ Add New Address'
                                                            : shippedAddress
                                                                .elementAt(
                                                                    index);
                                                    return GestureDetector(
                                                      onTap: () {
                                                        if (addAddress) {
                                                          Navigator.of(context,
                                                                  rootNavigator:
                                                                      true)
                                                              .push(
                                                                  AddShippingAddressPage
                                                                      .route(
                                                                          null,
                                                                          () {
                                                            setState(() {
                                                              updateAddressList();
                                                            });
                                                          }));
                                                        } else {
                                                          setState(() {
                                                            _selectedItem =
                                                                option;
                                                            _firstAddressController
                                                                .text = option;
                                                            _showDropdown =
                                                                false;

                                                            setState(() {
                                                              AddressesPayloadModel?
                                                                  targetAddress =
                                                                  addresses.firstWhere(
                                                                      (address) =>
                                                                          address
                                                                              .address1 ==
                                                                          _selectedItem);

                                                              setState(() {
                                                                _addressController
                                                                        .text =
                                                                    '${targetAddress.address2}';
                                                                _cityController
                                                                        .text =
                                                                    '${targetAddress.city}';
                                                                _zipController
                                                                        .text =
                                                                    '${targetAddress.postalCode}';
                                                                _defaultState =
                                                                    '${targetAddress.state}';

                                                                _countryController
                                                                        .text =
                                                                    '${targetAddress.country}';
                                                              });
                                                            });

                                                            _firstAddressController
                                                                    .selection =
                                                                TextSelection.fromPosition(
                                                                    TextPosition(
                                                                        offset:
                                                                            option.length));
                                                          });
                                                        }
                                                      },
                                                      child: ListTile(
                                                        contentPadding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 0.0,
                                                                right: 0.0),
                                                        visualDensity:
                                                            const VisualDensity(
                                                                horizontal: -4,
                                                                vertical: -4),
                                                        title: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 15),
                                                          child: addAddress
                                                              ? Text(option)
                                                              : Text(option),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                                Positioned(
                                                  right: 0,
                                                  top: 0,
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      _showDropdown = false;
                                                    },
                                                    child: IconButton(
                                                      icon: Image.asset(
                                                        'assets/images/IconDropdowUp.png',
                                                        width: 20,
                                                        height: 20,
                                                      ),
                                                      onPressed: () {
                                                        setState(() {
                                                          _showDropdown = false;
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                                SizedBox(
                                  height: _showDropdown ? 10 : 0,
                                ),
                                CustomTextFormField(
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp("^.{0,50}\$")),
                                    ],
                                    readOnly: true,
                                    textCapitalization:
                                        TextCapitalization.words,
                                    borderColor: _addressBorder,
                                    autofocus: false,
                                    labelText: 'Address 2',
                                    errorText: addressErrorText,
                                    focusNode: _addressNode,
                                    controller: _addressController,
                                    inputType: TextInputType.text),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomTextFormField(
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp("^.{0,50}\$")),
                                    ],
                                    readOnly: true,
                                    borderColor: _cityBorder,
                                    autofocus: false,
                                    labelText: 'City',
                                    errorText: cityErrorText,
                                    focusNode: _cityNode,
                                    controller: _cityController,
                                    textCapitalization:
                                        TextCapitalization.words,
                                    inputType: TextInputType.text),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        children: [
                                          CupertinoPickerView(
                                            key: const Key('State-Picker'),
                                            errorText: stateErrorText,
                                            cupertinoPickerItems: stateCodes,
                                            cupertinoPickervalue: _defaultState,
                                            onDone: (index) {
                                              setState(() => value = index);
                                              _defaultState = stateCodes[index];
                                              _stateController.text =
                                                  _defaultState;

                                              Navigator.pop(context);
                                            },
                                            showPicker: false,
                                          ),
                                          Visibility(
                                              visible: stateErrorText != null,
                                              child: Align(
                                                alignment: Alignment.bottomLeft,
                                                child: Text(
                                                    S
                                                        .of(context)
                                                        .required_field,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall!
                                                        .copyWith(
                                                            color: Palette
                                                                .current
                                                                .primaryNeonPink)),
                                              )),
                                          Visibility(
                                              visible: stateErrorText == null &&
                                                  zipErrorText != null,
                                              child: const SizedBox(
                                                height: 20,
                                              ))
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        children: [
                                          CustomTextFormField(
                                            inputType: const TextInputType
                                                .numberWithOptions(
                                              decimal: true,
                                              signed: false,
                                            ),
                                            readOnly: true,
                                            borderColor: _zipBorder,
                                            autofocus: false,
                                            errorText: zipErrorText,
                                            labelText: S.of(context).zip,
                                            focusNode: _zipNode,
                                            controller: _zipController,
                                            textCapitalization:
                                                TextCapitalization.words,
                                          ),
                                          Visibility(
                                              visible: stateErrorText != null &&
                                                  zipErrorText == null,
                                              child: const SizedBox(
                                                height: 20,
                                              ))
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                PrimaryButton(
                                  title: S
                                      .of(context)
                                      .razon_remove_btn
                                      .toUpperCase(),
                                  onPressed: () {
                                    showErrors();
                                    if (areFieldsValid()) {
                                      Loading.show(context);
                                      getIt<BuyCubit>().buyListItem(
                                          BuyASaleListingModel(
                                              saveAddress: checkBoxValue,
                                              productItemId:
                                                  widget.productItemId,
                                              userNameBuyer:
                                                  profileData.username,
                                              address: AddressesPayloadModel(
                                                  addressType: 'SHIPPING',
                                                  address1:
                                                      _firstAddressController
                                                          .text,
                                                  address2:
                                                      _addressController.text,
                                                  country:
                                                      _countryController.text,
                                                  city: _cityController.text,
                                                  state: _defaultState,
                                                  postalCode:
                                                      _zipController.text),
                                              profilePeerToPeerPayment:
                                                  PeerToPeerPaymentsModel(
                                                venmoUser: _defaultPaymentType
                                                        .contains('Venmo')
                                                    ? widget.payments
                                                            .venmoUser ??
                                                        ''
                                                    : null,
                                                cashTag: _defaultPaymentType
                                                        .contains('Cashapp')
                                                    ? widget.payments.cashTag ??
                                                        ''
                                                    : null,
                                                payPalEmail: _defaultPaymentType
                                                        .contains('PayPal')
                                                    ? widget.payments
                                                            .payPalEmail ??
                                                        ''
                                                    : null,
                                              )));
                                    }
                                  },
                                  type: PrimaryButtonType.green,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: 3,
                      child: IconButton(
                        iconSize: 30,
                        color: Palette.current.primaryNeonGreen,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(
                          Icons.clear_outlined,
                          size: 20,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  void showErrors() {
    setState(() {
      paymentTypeErrorText = (_defaultPaymentType != 'Payment Type')
          ? null
          : S.of(context).required_field;

      firstShippedAddressErrorText = _firstAddressController.text.isNotEmpty
          ? null
          : S.of(context).required_field;

      cityErrorText =
          _cityController.text.isNotEmpty ? null : S.of(context).required_field;

      zipErrorText =
          _zipController.text.isNotEmpty ? null : S.of(context).required_field;
    });
  }

  bool areFieldsValid() {
    return _defaultPaymentType != 'Payment Type' &&
        _firstAddressController.text.isNotEmpty &&
        _cityController.text.isNotEmpty &&
        _zipController.text.isNotEmpty;
  }
}
