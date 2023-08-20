import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swagapp/generated/l10n.dart';
import 'package:swagapp/modules/common/ui/custom_app_bar.dart';
import 'package:swagapp/modules/common/ui/primary_button.dart';
import 'package:swagapp/modules/common/ui/pushed_header.dart';
import 'package:swagapp/modules/common/utils/palette.dart';

import '../../blocs/auth_bloc/auth_bloc.dart';
import '../../common/ui/custom_text_form_field.dart';
import '../../common/ui/dynamic_toast_messages.dart';
import '../../common/ui/loading.dart';
import '../../common/utils/custom_route_animations.dart';
import '../../common/utils/size_helper.dart';
import '../../common/utils/utils.dart';
import '../../data/secure_storage/storage_repository_service.dart';
import '../../data/shared_preferences/shared_preferences_service.dart';
import '../../di/injector.dart';

class ResetPasswordPage extends StatefulWidget {
  static const name = '/ResetPassword';
  ResetPasswordPage(
      {Key? key, required this.email, this.isFromProfileSetting = false})
      : super(key: key);

  String email;
  bool isFromProfileSetting;

  static Route route(email,isFromSetting) => PageRoutes.material(
        settings: const RouteSettings(name: name),
        builder: (context) => ResetPasswordPage(
          email: email,
          isFromProfileSetting: isFromSetting,
        ),
      );

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final FocusNode _passwordNode = FocusNode();
  final _passwordController = TextEditingController();
  String? errorFirstText;
  bool readOnly = false;

  final FocusNode _confirmPasswordNode = FocusNode();
  final _confirmPasswordController = TextEditingController();
  String? errorSecondText;

  Color _passwordBorder = Palette.current.primaryWhiteSmoke;
  Color _confirmPasswordBorder = Palette.current.primaryWhiteSmoke;

  late ResponsiveDesign _responsiveDesign;
  String? matchPassword;
  bool enableButtonFirstPassword = false;
  bool enableButtonSecondPassword = false;

  @override
  void dispose() {
    _confirmPasswordNode.dispose();
    _passwordNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _passwordNode.addListener(() {
      if (_passwordNode.hasFocus) {
        setState(() {
          errorFirstText = null;
          errorSecondText = null;
        });
      }
      setState(() {
        //If the password field was focused and now its not we will show the error it has to
        if (_passwordBorder == Palette.current.primaryNeonGreen) {
          errorFirstText = isValidPassword(_passwordController.text)
              ? null
              : S.of(context).invalid_password;
        }
        _passwordBorder = _passwordNode.hasFocus
            ? Palette.current.primaryNeonGreen
            : Palette.current.primaryWhiteSmoke;
      });
    });
    _confirmPasswordNode.addListener(() {
      if (_confirmPasswordNode.hasFocus) {
        setState(() {
          errorFirstText = null;
          errorSecondText = null;
        });
      }
       setState(() {
        if (_confirmPasswordBorder == Palette.current.primaryNeonGreen) {
          errorSecondText = isValidPassword(_confirmPasswordController.text)
              ? null
              : S.of(context).invalid_password;
        }
        _confirmPasswordBorder = _confirmPasswordNode.hasFocus
            ? Palette.current.primaryNeonGreen
            : Palette.current.primaryWhiteSmoke;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    _responsiveDesign = ResponsiveDesign(context);
    return Scaffold(
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: true,
        backgroundColor: widget.isFromProfileSetting! ? Palette.current.primaryNero : Colors.transparent,
        appBar: widget.isFromProfileSetting! ? AppBar(
          scrolledUnderElevation: 0.0,
          backgroundColor: Palette.current.primaryNero,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light, // For Android (dark icons)
            statusBarBrightness: Brightness.dark, // For iOS (dark icons)
          ),
          automaticallyImplyLeading: false,
          flexibleSpace: SafeArea(
            child: NavigationToolbar(
              middleSpacing: 0,
              centerMiddle: false,
              middle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        right: 12, top: 6),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                         IconButton(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            icon: Icon(
                              Icons.arrow_back,
                              color: Palette.current.primaryNeonGreen,
                              size: 24,
                            ),
                            onPressed: () {
                              Navigator.popUntil(
                                  context,
                                  ModalRoute.withName(widget.isFromProfileSetting
                                      ? '/ProfileDetailPage'
                                      : '/'));
                            }),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text("RESET PASSWORD",
                              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                                  letterSpacing: 1,
                                  fontWeight: FontWeight.w300,
                                  fontFamily: "KnockoutCustom",
                                  fontSize: 30,
                                  color: Palette.current.primaryNeonGreen)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ) : CustomAppBar(
          onRoute: () {
            getIt<PreferenceRepositoryService>().saveForgotPasswordFlow(false);
            Navigator.of(context, rootNavigator: true)
                .popUntil(ModalRoute.withName('/SignIn'));
          },
        ),
        body: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) => state.maybeWhen(
                  orElse: () {
                    return null;
                  },
                  authenticated: (_informationMissing) {
                    setState(() {
                      readOnly = true;
                    });
                    getIt<PreferenceRepositoryService>().saveIsLogged(true);
                    getIt<StorageRepositoryService>().saveEmail(widget.email);
                    getIt<StorageRepositoryService>()
                        .savePassword(_confirmPasswordController.text);
                    Loading.hide(context);
                    Future.delayed(const Duration(milliseconds: 5000), () {
                      _passwordController.text = '';
                      _confirmPasswordController.text = '';
                      Navigator.popUntil(
                          context,
                          ModalRoute.withName(widget.isFromProfileSetting
                              ? '/ProfileDetailPage'
                              : '/'));
                    });

                    return null;
                  },
                  passwordChanged: () {
                    Future.delayed(const Duration(milliseconds: 2000), () {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          duration: const Duration(seconds: 3),
                          behavior: SnackBarBehavior.floating,
                          margin: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height / 1.3,
                          ),
                          backgroundColor: Colors.transparent,
                          content: ToastMessage(
                            message: S.of(context).toast_message_reset_password,
                          ),
                          dismissDirection: DismissDirection.none));
                    });

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
          _passwordNode.unfocus();
          _confirmPasswordNode.unfocus();
        },
        child: Stack(children: [
          ColorFiltered(
            colorFilter:
                const ColorFilter.mode(Colors.black38, BlendMode.darken),
            child: widget.isFromProfileSetting! ? Container()
                : Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/background.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: null),
          ),
          LayoutBuilder(builder: (context, viewportConstraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          height: widget.isFromProfileSetting! ? 0 : _responsiveDesign.heightMultiplier(80),
                        ),
                        widget.isFromProfileSetting! ? SizedBox.shrink()
                            : Image.asset(
                          'assets/images/logo.png',
                          width: 125,
                          height: 51,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Text(S.of(context).reset_password_description,
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      letterSpacing: 0.3,
                                      color: Palette.current.primaryWhiteSmoke,
                                    )),
                        const SizedBox(
                          height: 30,
                        ),
                        CustomTextFormField(
                            readOnly: readOnly,
                            onChanged: (text){
                              setState(() {
                                errorFirstText = null;
                              });
                            },
                            errorText: errorFirstText,
                            helperText: S.of(context).password_helper,
                            borderColor: _passwordBorder,
                            autofocus: false,
                            labelText: S.of(context).new_password,
                            focusNode: _passwordNode,
                            controller: _passwordController,
                            secure: true,
                            inputType: TextInputType.text),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextFormField(
                            readOnly: readOnly,
                            onChanged: (text) {
                              setState(() {
                                errorSecondText = null;
                              });
                            },
                            errorText: errorSecondText,
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
                        PrimaryButton(
                          title: S.of(context).finish_btn,
                          onPressed: () {
                            showErrors();
                            if (enableButtonSecondPassword &&
                                enableButtonFirstPassword) {
                              context.read<AuthBloc>().add(
                                  AuthEvent.changePassword(
                                      '', _confirmPasswordController.text, ''));
                            }
                          },
                          type: PrimaryButtonType.green,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
        ]));
  }

  void showErrors() {
    setState(() {
      matchPassword = _passwordController.text;
      errorFirstText = _passwordController.text.isEmpty
          ? S.of(context).required_field
          : isValidPassword(_passwordController.text)
              ? null
              : S.of(context).invalid_password;

      errorSecondText = _confirmPasswordController.text.isEmpty
          ? S.of(context).required_field
          : errorFirstText == null && _passwordController.text.isNotEmpty
              ? _passwordController.text == _confirmPasswordController.text &&
                      _confirmPasswordController.text.isNotEmpty
                  ? null
                  : S.of(context).no_match_password
              : null;

      enableButtonFirstPassword =
          isValidPassword(_passwordController.text) ? true : false;

      enableButtonSecondPassword = (errorFirstText == null &&
              matchPassword == _confirmPasswordController.text &&
              _confirmPasswordController.text.isNotEmpty)
          ? true
          : false;
    });
  }
}
