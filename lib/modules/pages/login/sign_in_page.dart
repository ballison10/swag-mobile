import 'package:flutter/material.dart';
import 'package:simple_rich_text/simple_rich_text.dart';
import 'package:swagapp/generated/l10n.dart';
import 'package:swagapp/modules/common/ui/clickable_text.dart';
import 'package:swagapp/modules/common/ui/custom_app_bar.dart';
import 'package:swagapp/modules/common/ui/primary_button.dart';
import 'package:swagapp/modules/common/utils/palette.dart';
import 'package:swagapp/modules/common/utils/utils.dart';
import 'package:swagapp/modules/pages/login/forgot_password_page.dart';

import '../../common/ui/custom_text_form_field.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final FocusNode _emailNode = FocusNode();
  final _emailController = TextEditingController();
  final FocusNode _passwordNode = FocusNode();
  final _passwordController = TextEditingController();
  Color _emailBorder = Palette.current.primaryWhiteSmoke;
  Color _passwordBorder = Palette.current.primaryWhiteSmoke;
  String? errorText;

  @override
  void dispose() {
    _emailNode.dispose();
    _passwordNode.dispose();
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
        _passwordBorder = _passwordNode.hasFocus
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
        body: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              _emailNode.unfocus();
              _passwordNode.unfocus();
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Image.asset(
                              'assets/images/logo.png',
                              width: 125,
                              height: 51,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Visibility(
                              visible: false,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    S.of(context).invalid_email,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                            color: Palette
                                                .current.primaryNeonPink),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  )
                                ],
                              ),
                            ),
                            CustomTextFormField(
                                borderColor: _emailBorder,
                                errorText: errorText,
                                autofocus: false,
                                labelText: S.of(context).email,
                                focusNode: _emailNode,
                                accountController: _emailController,
                                onChanged: (value) {
                                  setState(() {
                                    errorText = isValidEmail(value)
                                        ? null
                                        : S.of(context).invalid_email;
                                  });
                                },
                                inputType: TextInputType.emailAddress),
                            const SizedBox(
                              height: 16,
                            ),
                            CustomTextFormField(
                                borderColor: _passwordBorder,
                                autofocus: false,
                                labelText: S.of(context).password,
                                focusNode: _passwordNode,
                                accountController: _passwordController,
                                onChanged: (value) {
                                  setState(() {});
                                },
                                secure: true,
                                inputType: TextInputType.text),
                            const SizedBox(
                              height: 10,
                            ),
                            ClickableText(
                                title: Text(
                                  S.of(context).forgot_password,
                                  textAlign: TextAlign.right,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                          color:
                                              Palette.current.primaryNeonGreen,
                                          fontWeight: FontWeight.w300),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const ForgotPasswordPage(),
                                    ),
                                  );
                                }),
                            const SizedBox(
                              height: 20,
                            ),
                            PrimaryButton(
                              title: S.of(context).sign_in,
                              onPressed: errorText == null &&
                                      _passwordController.text.isNotEmpty
                                  ? () {}
                                  : null,
                              type: PrimaryButtonType.green,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ClickableText(
                                title: SimpleRichText(
                                  S.of(context).dont_have_account,
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                          color:
                                              Palette.current.primaryNeonGreen,
                                          fontWeight: FontWeight.w300),
                                ),
                                onPressed: () {}),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ])));
  }
}
