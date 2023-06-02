import 'dart:convert';

import 'package:csc_picker/model/select_status_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../generated/l10n.dart';
import '../../../blocs/update_profile_bloc/update_profile_bloc.dart';
import '../../../common/ui/cupertino_custom_picker.dart';
import '../../../common/ui/custom_text_form_field.dart';
import '../../../common/ui/loading.dart';
import '../../../common/ui/primary_button.dart';
import '../../../common/ui/pushed_header.dart';
import '../../../common/utils/custom_route_animations.dart';
import '../../../common/utils/palette.dart';

import 'package:csc_picker/csc_picker.dart';

import '../../../common/utils/utils.dart';
import '../../../cubits/profile/get_profile_cubit.dart';
import '../../../data/shared_preferences/shared_preferences_service.dart';
import '../../../di/injector.dart';
import '../../../models/profile/profile_model.dart';
import '../../../models/update_profile/addresses_payload_model.dart';
import '../../../models/update_profile/update_profile_payload_model.dart';

class AddShippingAddressPage extends StatefulWidget {
  static const name = '/AddShippingAddressPage';

  const AddShippingAddressPage({super.key});

  static Route route() => PageRoutes.material(
        settings: const RouteSettings(name: name),
        builder: (context) => const AddShippingAddressPage(),
      );

  @override
  State<AddShippingAddressPage> createState() => _AddShippingAddressPageState();
}

class _AddShippingAddressPageState extends State<AddShippingAddressPage> {
  final FocusNode _countryNode = FocusNode();
  final _countryController = TextEditingController();
  Color _countryBorder = Palette.current.primaryWhiteSmoke;

  final FocusNode _firstAddressNode = FocusNode();
  final _firstAddressController = TextEditingController();
  Color _firstAddressBorder = Palette.current.primaryWhiteSmoke;

  final FocusNode _secondAddressNode = FocusNode();
  final _secondAddressController = TextEditingController();
  Color _secondAddressBorder = Palette.current.primaryWhiteSmoke;

  final FocusNode _cityNode = FocusNode();
  final _cityController = TextEditingController();
  Color _cityBorder = Palette.current.primaryWhiteSmoke;

  final FocusNode _stateNode = FocusNode();
  final _stateController = TextEditingController();
  Color _stateBorder = Palette.current.primaryWhiteSmoke;

  final FocusNode _zipNode = FocusNode();
  final _zipController = TextEditingController();
  Color _zipBorder = Palette.current.primaryWhiteSmoke;

  String? countryErrorText;
  String? addressErrorText;
  String? cityErrorText;
  String? stateErrorText;
  String? zipErrorText;

  String _defaultCountry = 'United States';
  String _defaultState = 'State';

  var countries = ['United States'];
  final _states = ['State'];

  int value = 0;

  @override
  void initState() {
    _countryNode.addListener(() {
      setState(() {
        _countryBorder = _countryNode.hasFocus
            ? Palette.current.primaryNeonGreen
            : Palette.current.primaryWhiteSmoke;
      });
    });

    _firstAddressNode.addListener(() {
      setState(() {
        _firstAddressBorder = _firstAddressNode.hasFocus
            ? Palette.current.primaryNeonGreen
            : Palette.current.primaryWhiteSmoke;
      });
    });

    _secondAddressNode.addListener(() {
      setState(() {
        _secondAddressBorder = _secondAddressNode.hasFocus
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
      setState(() {
        _stateBorder = _stateNode.hasFocus
            ? Palette.current.primaryNeonGreen
            : Palette.current.primaryWhiteSmoke;
      });
    });

    _zipNode.addListener(() {
      setState(() {
        _zipBorder = _zipNode.hasFocus
            ? Palette.current.primaryNeonGreen
            : Palette.current.primaryWhiteSmoke;
      });
    });
    _getStates();
    // TODO: implement initState
    super.initState();
  }

  void _getStates() async {
    var responseSatate = await getStates('United States');

    setState(() {
      _states.addAll(responseSatate as Iterable<String>);
    });
  }

  GestureDetector _getBody() {
    return GestureDetector(
      onTap: () {
        _countryNode.unfocus();
        _firstAddressNode.unfocus();
        _secondAddressNode.unfocus();
        _cityNode.unfocus();
        _stateNode.unfocus();
        _zipNode.unfocus();
      },
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Stack(
          children: [
            Container(
              color: Palette.current.primaryEerieBlack,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Column(
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        Text(S.of(context).add_address_title,
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge!
                                .copyWith(
                                    color: Palette.current.primaryWhiteSmoke,
                                    fontSize: 16)),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextFormField(
                            borderColor: _countryBorder,
                            autofocus: false,
                            labelText: S.of(context).country,
                            errorText: countryErrorText,
                            dropdownForm: true,
                            dropdownFormItems: countries,
                            dropdownvalue: _defaultCountry,
                            dropdownOnChanged: (String? newValue) {
                              setState(() {
                                setState(() {
                                  _defaultCountry = newValue!;
                                });
                              });
                            },
                            focusNode: _countryNode,
                            controller: _countryController,
                            inputType: TextInputType.text),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextFormField(
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp("^.{0,50}\$")),
                            ],
                            borderColor: _firstAddressBorder,
                            autofocus: false,
                            labelText: S.of(context).first_address,
                            errorText: addressErrorText,
                            focusNode: _firstAddressNode,
                            controller: _firstAddressController,
                            inputType: TextInputType.text),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextFormField(
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp("^.{0,50}\$")),
                            ],
                            borderColor: _secondAddressBorder,
                            autofocus: false,
                            labelText: S.of(context).second_address,
                            focusNode: _secondAddressNode,
                            controller: _secondAddressController,
                            inputType: TextInputType.text),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextFormField(
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp("^.{0,50}\$")),
                            ],
                            borderColor: _cityBorder,
                            autofocus: false,
                            errorText: cityErrorText,
                            labelText: S.of(context).city,
                            focusNode: _cityNode,
                            controller: _cityController,
                            inputType: TextInputType.text),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Column(
                                children: [
                                  CupertinoPickerView(
                                      errorText: stateErrorText,
                                      cupertinoPickerItems: _states,
                                      cupertinoPickervalue: _defaultState,
                                      onDone: (index) {
                                        setState(() => value = index);
                                        _defaultState = _states[index];
                                        Navigator.pop(context);
                                      }),
                                  Visibility(
                                      visible: stateErrorText != null,
                                      child: Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Text(
                                            S.of(context).required_field,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(
                                                    color: Palette.current
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
                                    inputType:
                                        const TextInputType.numberWithOptions(
                                      decimal: true,
                                      signed: false,
                                    ),
                                    borderColor: _zipBorder,
                                    autofocus: false,
                                    errorText: zipErrorText,
                                    labelText: S.of(context).zip,
                                    focusNode: _zipNode,
                                    controller: _zipController,
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
                        PrimaryButton(
                          title: S.of(context).finish_btn.toUpperCase(),
                          onPressed: () {
                            showErrors();
                            if (areFieldsValid()) {
                              context.read<UpdateProfileBloc>().add(
                                      UpdateProfileEvent.update(
                                          UpdateProfilePayloadModel(addresses: [
                                    AddressesPayloadModel(
                                        addressType: "SHIPPING",
                                        country: _defaultCountry,
                                        address1: _firstAddressController.text,
                                        address2: _secondAddressController.text,
                                        city: _cityController.text,
                                        state: _defaultState,
                                        postalCode: _zipController.text),
                                  ])));
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
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PushedHeader(
          showBackButton: true,
          title: Align(
            alignment: Alignment.centerRight,
            child: Text(S.of(context).shipping_address_title.toUpperCase(),
                style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    letterSpacing: 1,
                    fontWeight: FontWeight.w300,
                    fontFamily: "KnockoutCustom",
                    fontSize: 30,
                    color: Palette.current.primaryNeonGreen)),
          ),
          height: 70,
        ),
        backgroundColor: Palette.current.primaryEerieBlack,
        body: BlocListener<UpdateProfileBloc, UpdateProfileState>(
            listener: (context, state) => state.maybeWhen(
                  orElse: () {
                    return null;
                  },
                  updated: () {
                    getIt<ProfileCubit>().loadProfileResults();
                    Loading.hide(context);
                    Navigator.of(context).pop();
                    return null;
                  },
                  initial: () {
                    return Loading.show(context);
                  },
                  error: (message) => {
                    Loading.hide(context),
                    // Dialogs.showOSDialog(context, 'Error', message, 'OK', () {})
                  },
                ),
            child: _getBody()));
  }

  void showErrors() {
    setState(() {
      countryErrorText =
          _defaultCountry != 'Country' ? null : S.of(context).required_field;

      addressErrorText = _firstAddressController.text.isNotEmpty
          ? null
          : S.of(context).required_field;

      cityErrorText =
          _cityController.text.isNotEmpty ? null : S.of(context).required_field;

      stateErrorText =
          _defaultState != 'State' ? null : S.of(context).required_field;

      zipErrorText =
          _zipController.text.isNotEmpty ? null : S.of(context).required_field;
    });
  }

  bool areFieldsValid() {
    return _defaultCountry != 'Country' &&
        _firstAddressController.text.isNotEmpty &&
        _cityController.text.isNotEmpty &&
        _defaultState != 'State' &&
        _zipController.text.isNotEmpty;
  }
}