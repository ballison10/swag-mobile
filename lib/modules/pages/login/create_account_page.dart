import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:swagapp/generated/l10n.dart';
import 'package:swagapp/modules/blocs/auth_bloc/username_bloc.dart';
import 'package:swagapp/modules/common/ui/clickable_text.dart';
import 'package:swagapp/modules/common/ui/custom_app_bar.dart';
import 'package:swagapp/modules/common/ui/primary_button.dart';
import 'package:swagapp/modules/common/utils/palette.dart';
import 'package:swagapp/modules/common/utils/utils.dart';
import 'package:swagapp/modules/models/auth/create_account_payload_model.dart';
import 'package:swagapp/modules/pages/login/sign_in_page.dart';

import '../../blocs/auth_bloc/auth_bloc.dart';
import '../../common/ui/custom_text_form_field.dart';
import '../../common/ui/loading.dart';
import '../../common/ui/web_view.dart';
import '../../common/utils/custom_route_animations.dart';
import '../../constants/constants.dart';
import '../../data/secure_storage/storage_repository_service.dart';
import '../../data/shared_preferences/shared_preferences_service.dart';
import '../../di/injector.dart';

class CreateAccountPage extends StatefulWidget {
  static const name = '/CreateAccount';
  const CreateAccountPage({Key? key}) : super(key: key);

  static Route route() => PageRoutes.material(
        settings: const RouteSettings(name: name),
        builder: (context) => const CreateAccountPage(),
      );

  @override
  State<CreateAccountPage> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccountPage> {
  final FocusNode _emailNode = FocusNode();
  final _emailController = TextEditingController();
  Color _emailBorder = Palette.current.primaryWhiteSmoke;
  String? emailErrorText;

  final FocusNode _passwordNode = FocusNode();
  final _passwordController = TextEditingController();
  Color _passwordBorder = Palette.current.primaryWhiteSmoke;
  String? passwordErrorText;

  final FocusNode _confirmPasswordNode = FocusNode();
  final _confirmPasswordController = TextEditingController();
  Color _confirmPasswordBorder = Palette.current.primaryWhiteSmoke;
  String? confirmPasswordErrorText;
  bool isPhoneValid = false;
  PhoneNumber? currentPhoneNumber;

  final FocusNode _phoneNode = FocusNode();
  final _phoneController = TextEditingController();
  String? phoneErrorText;
  Color _phoneBorder = Palette.current.primaryWhiteSmoke;

  final FocusNode _usernameNode = FocusNode();
  final _usernameController = TextEditingController();
  Color _usernameBorder = Palette.current.primaryWhiteSmoke;
  String? usernameErrorText;
  bool isUsernameTaken = false;

  bool checkBoxValue = false;
  String usernameVal = defaultString;

  @override
  void dispose() {
    _phoneNode.dispose();
    _emailNode.dispose();
    _passwordNode.dispose();
    _confirmPasswordNode.dispose();
    _usernameNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _emailNode.addListener(() {
      setState(() {
        _emailBorder = _emailNode.hasFocus
            ? Palette.current.primaryNeonGreen
            : Palette.current.primaryWhiteSmoke;
      });
    });
    _passwordNode.addListener(() {
      setState(() {
        //If the password field was focused and now its not we will show the error it has to
        if (_passwordBorder == Palette.current.primaryNeonGreen) {
          passwordErrorText = isValidPassword(_passwordController.text)
              ? null
              : S.of(context).invalid_password;
        }
        _passwordBorder = _passwordNode.hasFocus
            ? Palette.current.primaryNeonGreen
            : Palette.current.primaryWhiteSmoke;
      });
    });

    _confirmPasswordNode.addListener(() {
      setState(() {
        _confirmPasswordBorder = _confirmPasswordNode.hasFocus
            ? Palette.current.primaryNeonGreen
            : Palette.current.primaryWhiteSmoke;
      });
    });
    _phoneNode.addListener(() {
      setState(() {
        _phoneBorder = _phoneNode.hasFocus
            ? Palette.current.primaryNeonGreen
            : Palette.current.primaryWhiteSmoke;
      });
    });
    _usernameNode.addListener(() {
      setState(() {
        _usernameBorder = _usernameNode.hasFocus
            ? Palette.current.primaryNeonGreen
            : Palette.current.primaryWhiteSmoke;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.transparent,
        appBar: CustomAppBar(),
        body: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) => state.maybeWhen(
                  orElse: () {
                    return null;
                  },
                  authenticated: () {
                    getIt<PreferenceRepositoryService>()
                        .saveHasJustSignedUp(true);
                    getIt<PreferenceRepositoryService>().saveIsLogged(true);
                    getIt<StorageRepositoryService>()
                        .saveEmail(_emailController.text);
                    getIt<StorageRepositoryService>()
                        .savePassword(_passwordController.text);
                    Loading.hide(context);
                    Navigator.popUntil(context, ModalRoute.withName('/'));
                    return null;
                  },
                  logging: () {
                    return Loading.show(context);
                  },
                  error: (message) => {
                    Loading.hide(context),
                    // Dialogs.showOSDialog(context, 'Error', message, 'OK', () {})
                  },
                ),
            child: _getBody()));
  }

  GestureDetector _getBody() {
    return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          _emailNode.unfocus();
          _passwordNode.unfocus();
          _confirmPasswordNode.unfocus();
          _phoneNode.unfocus();
          _usernameNode.unfocus();
        },
        child: Stack(children: [
          ColorFiltered(
            colorFilter:
                const ColorFilter.mode(Colors.black38, BlendMode.darken),
            child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/background.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: null),
          ),
          Column(
            children: [
              const SizedBox(
                height: 100,
              ),
              Image.asset(
                'assets/images/logo.png',
                width: 125,
                height: 51,
              ),
              Expanded(
                child: LayoutBuilder(builder: (context, viewportConstraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: viewportConstraints.maxHeight,
                      ),
                      child: IntrinsicHeight(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              BlocBuilder<AuthBloc, AuthState>(
                                  builder: (context, authState) {
                                return authState.maybeMap(orElse: () {
                                  return _getEmailField(context, true);
                                }, error: (state) {
                                  return _getEmailField(context, false);
                                });
                              }),
                              const SizedBox(
                                height: 20,
                              ),
                              _PhoneSection(_phoneController, _phoneNode,
                                  phoneErrorText, _phoneBorder,
                                  (isPhoneValidParam, phoneNumber) {
                                isPhoneValid = isPhoneValidParam;
                                currentPhoneNumber = phoneNumber;
                              }),
                              const SizedBox(
                                height: 20,
                              ),
                              CustomTextFormField(
                                  errorText: passwordErrorText,
                                  helperText: S.of(context).password_helper,
                                  borderColor: _passwordBorder,
                                  autofocus: false,
                                  labelText: S.of(context).password,
                                  focusNode: _passwordNode,
                                  controller: _passwordController,
                                  secure: true,
                                  inputType: TextInputType.text),
                              const SizedBox(
                                height: 20,
                              ),
                              CustomTextFormField(
                                  errorText: confirmPasswordErrorText,
                                  borderColor: _confirmPasswordBorder,
                                  autofocus: false,
                                  labelText: S.of(context).confirm_password,
                                  focusNode: _confirmPasswordNode,
                                  controller: _confirmPasswordController,
                                  secure: true,
                                  inputType: TextInputType.text),
                              const SizedBox(
                                height: 20,
                              ),
                              BlocBuilder<UsernameBloc, UsernameState>(
                                  builder: (context, usernameState) {
                                return usernameState.maybeMap(
                                    orElse: () => _getUsernameField(
                                          context,
                                        ),
                                    isUsernameAvailable: (state) =>
                                        _getUsernameField(context,
                                            isUsernameAvailable:
                                                state.isUsernameAvailable));
                              }),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 24.0,
                                    width: 24.0,
                                    child: Checkbox(
                                      checkColor: Palette.current.black,
                                      value: checkBoxValue,
                                      onChanged: (value) {
                                        setState(() =>
                                            checkBoxValue = value ?? false);
                                      },
                                      side: BorderSide(
                                          color:
                                              Palette.current.primaryNeonGreen),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 16.0),
                                      child: ClickableText(
                                          title: RichText(
                                            maxLines: 2,
                                            softWrap: false,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                            text: TextSpan(children: [
                                              TextSpan(
                                                text: S.of(context).agree_to,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(
                                                      color: Palette.current
                                                          .primaryNeonGreen,
                                                    ),
                                              ),
                                              TextSpan(
                                                text: S
                                                    .of(context)
                                                    .privacy_policy_text,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Palette.current
                                                          .primaryNeonGreen,
                                                    ),
                                              ),
                                              TextSpan(
                                                text: S.of(context).and,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(
                                                      color: Palette.current
                                                          .primaryNeonGreen,
                                                    ),
                                              ),
                                              TextSpan(
                                                text:
                                                    S.of(context).terms_of_use,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Palette.current
                                                          .primaryNeonGreen,
                                                    ),
                                              ),
                                            ]),
                                          ),
                                          onPressed: () {
                                            Navigator.of(context,
                                                    rootNavigator: true)
                                                .push(WebViewPage.route(
                                              context,
                                              termsAndConditionsBasePath,
                                              termsAndConditionsUrl,
                                            ));
                                          }),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              PrimaryButton(
                                title:
                                    S.of(context).create_account.toUpperCase(),
                                onPressed: () {
                                  showErrors();
                                  if (areFieldsValid()) {
                                    context.read<AuthBloc>().add(AuthEvent
                                        .createAccount(CreateAccountPayloadModel(
                                            email: _emailController.text,
                                            phoneNumber:
                                                "${currentPhoneNumber!.dialCode}${_phoneController.text}",
                                            password: _passwordController.text,
                                            userName: _usernameController.text,
                                            termsOfServiceAccepted:
                                                checkBoxValue,
                                            deviceId: defaultString)));
                                  }
                                },
                                type: PrimaryButtonType.green,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              ClickableText(
                                  title: RichText(
                                    maxLines: 1,
                                    softWrap: false,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    text: TextSpan(children: [
                                      TextSpan(
                                        text: S
                                            .of(context)
                                            .already_have_an_account,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                              color: Palette
                                                  .current.primaryNeonGreen,
                                            ),
                                      ),
                                      TextSpan(
                                        text: S.of(context).sign_in,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                              fontWeight: FontWeight.w400,
                                              color: Palette
                                                  .current.primaryNeonGreen,
                                            ),
                                      ),
                                    ]),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context, rootNavigator: true)
                                        .push(SignInPage.route());
                                  }),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ]));
  }

  CustomTextFormField _getEmailField(
      BuildContext context, bool isEmailAvailable) {
    setEmailErrorText(
      isValidEmail(_emailController.text),
      isEmailAvailable,
    );

    return CustomTextFormField(
        borderColor: _emailBorder,
        errorText: emailErrorText,
        autofocus: false,
        labelText: S.of(context).email,
        focusNode: _emailNode,
        controller: _emailController,
        inputType: TextInputType.emailAddress);
  }

  CustomTextFormField _getUsernameField(BuildContext context,
      {bool isUsernameAvailable = false}) {
    setUsernameErrorText(
      isValidUsername(usernameVal),
      isUsernameAvailable,
    );
    return CustomTextFormField(
        borderColor: _usernameBorder,
        errorText: usernameErrorText,
        autofocus: false,
        labelText: S.of(context).username,
        focusNode: _usernameNode,
        controller: _usernameController,
        onChanged: (value) {
          usernameVal = value;
          if (isValidUsername(value)) {
            context
                .read<UsernameBloc>()
                .add(UsernameEvent.checkUsernameAvailavility(value));
          }
          setState(() {});
        },
        suffix: _usernameController.text.isEmpty
            ? null
            : usernameErrorText == null
                ? const Icon(
                    Icons.check,
                    color: Colors.green,
                  )
                : Icon(
                    Icons.close,
                    color: Palette.current.primaryNeonPink,
                  ),
        inputType: TextInputType.emailAddress);
  }

  void setUsernameErrorText(
    bool isCorrectSize,
    bool isUsernameAvailable,
  ) {
    isUsernameTaken = !isUsernameAvailable;
    bool isUsernameOk = isCorrectSize && isUsernameAvailable;
    usernameErrorText = isUsernameOk || _usernameController.text.isEmpty
        ? null
        : isCorrectSize
            ? S.of(context).username_taken
            : S.of(context).invalid_username;
  }

  void setEmailErrorText(
    bool isValid,
    bool isEmailAvailable,
  ) {
    bool isEmailOk = isValid && isEmailAvailable;
    emailErrorText = isEmailOk || _emailController.text.isEmpty
        ? null
        : isValid
            ? S.of(context).email_taken
            : S.of(context).invalid_email;
  }

  void showErrors() {
    setState(() {
      emailErrorText = _emailController.text.isEmpty
          ? S.of(context).required_field
          : isValidEmail(_emailController.text)
              ? null
              : S.of(context).invalid_email;

      phoneErrorText = _phoneController.text.isEmpty
          ? S.of(context).required_field
          : isPhoneValid
              ? null
              : S.of(context).phone_taken;

      passwordErrorText = _passwordController.text.isEmpty
          ? S.of(context).required_field
          : isValidPassword(_passwordController.text)
              ? null
              : S.of(context).invalid_password;

      confirmPasswordErrorText = _confirmPasswordController.text.isEmpty
          ? S.of(context).required_field
          : passwordErrorText == null && _passwordController.text.isNotEmpty
              ? _passwordController.text == _confirmPasswordController.text &&
                      _confirmPasswordController.text.isNotEmpty
                  ? null
                  : S.of(context).no_match_password
              : null;
    });

    usernameErrorText = _usernameController.text.isEmpty
        ? S.of(context).required_field
        : (_usernameController.text.isNotEmpty &&
                _usernameController.text.length >= 4)
            ? isUsernameTaken
                ? S.of(context).username_taken
                : null
            : S.of(context).invalid_username;
  }

  bool areFieldsValid() {
    return emailErrorText == null &&
        _emailController.text.isNotEmpty &&
        phoneErrorText == null &&
        _phoneController.text.isNotEmpty &&
        passwordErrorText == null &&
        _passwordController.text.isNotEmpty &&
        confirmPasswordErrorText == null &&
        _confirmPasswordController.text.isNotEmpty &&
        usernameErrorText == null &&
        _usernameController.text.isNotEmpty &&
        checkBoxValue;
  }
}

class _PhoneSection extends StatefulWidget {
  final TextEditingController phoneController;
  final FocusNode? focusPhone;
  final Function(bool, PhoneNumber) notifyIsPhoneValid;
  final String? errorText;
  final Color? borderColor;
  const _PhoneSection(this.phoneController, this.focusPhone, this.errorText,
      this.borderColor, this.notifyIsPhoneValid);

  @override
  State<_PhoneSection> createState() => __PhoneSectionState();
}

class __PhoneSectionState extends State<_PhoneSection> {
  String initialCountry = 'US';
  PhoneNumber initialNumber = PhoneNumber(isoCode: 'US');
  PhoneNumber choseNumber = PhoneNumber(isoCode: 'US');
  bool isLoginEnabled = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(
              color: widget.errorText != null
                  ? Palette.current.primaryNeonPink
                  : widget.borderColor!,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Container(
              height: 55,
              decoration: BoxDecoration(
                color: Palette.current.primaryWhiteSmoke,
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: InternationalPhoneNumberInput(
                  autoFocus: false,
                  countries: countries,
                  focusNode: widget.focusPhone,
                  cursorColor: Palette.current.blackSmoke,
                  inputDecoration: InputDecoration(
                      hintText: S.of(context).phone,
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Palette.current.primaryWhiteSmoke),
                      ),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Palette.current.primaryWhiteSmoke))),
                  onInputChanged: (PhoneNumber nbr) {
                    choseNumber = nbr;
                  },
                  onInputValidated: (bool value) {
                    setState(() {
                      widget.notifyIsPhoneValid(value, choseNumber);
                    });
                  },
                  selectorConfig: const SelectorConfig(
                    selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                    setSelectorButtonAsPrefixIcon: false,
                    showFlags: true,
                    trailingSpace: false,
                  ),
                  searchBoxDecoration: const InputDecoration(
                    hintText: "Search",
                  ),
                  ignoreBlank: false,
                  autoValidateMode: AutovalidateMode.disabled,
                  selectorTextStyle: const TextStyle(color: Colors.black),
                  initialValue: initialNumber,
                  textFieldController: widget.phoneController,
                  formatInput: true,
                  keyboardType: TextInputType.phone,
                  onSaved: (PhoneNumber number) {
                    print("onSaved");
                  },
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        widget.errorText != null
            ? Text(
                widget.errorText!,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Palette.current.primaryNeonPink),
              )
            : Container(),
      ],
    );
  }
}

extension BoolParsing on String {
  bool parseBool() {
    return toLowerCase() == 'true';
  }
}
