import 'package:flutter/material.dart';
import 'package:swagapp/generated/l10n.dart';
import 'package:swagapp/modules/common/ui/primary_button.dart';
import 'package:swagapp/modules/common/utils/palette.dart';

import '../../common/ui/custom_text_form_field.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final FocusNode _emailNode = FocusNode();
  final FocusNode _codeNode = FocusNode();
  final _emailController = TextEditingController();
  final _codeController = TextEditingController();
  bool codeView = false;

  @override
  void dispose() {
    _emailNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _emailNode.addListener(() {
      setState(() {
        // _userNameBorder =
        //     _emailNode.hasFocus ? Palette.current.orange : Colors.grey;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.transparent,
      body: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            _emailNode.unfocus();
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
            Padding(
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
                    Text(
                        codeView
                            ? "Please check your email and enter your six digit code below."
                            : "Enter your email to reset your password.",
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge!
                            .copyWith(
                                color: Palette.current.primaryWhiteSmoke,
                                fontSize: 18)),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomTextFormField(
                        autofocus: false,
                        labelText: codeView ? "Code" : "Email",
                        focusNode: codeView ? _codeNode : _emailNode,
                        accountController:
                            codeView ? _codeController : _emailController,
                        onChanged: (value) {},
                        inputType: TextInputType.text),
                    const SizedBox(
                      height: 30,
                    ),
                    PrimaryButton(
                      title: "RESET PASSWORD",
                      onPressed: () {
                        setState(() {
                          codeView = true;
                        });
                      },
                      type: PrimaryButtonType.green,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Visibility(
                      visible: codeView,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              //Test variable to see dynamic behavior
                              setState(() {
                                codeView = false;
                              });
                            },
                            child: Text("Didn’t get an email?",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineLarge!
                                    .copyWith(
                                        color: Palette.current.primaryNeonGreen,
                                        fontSize: 18)),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                            onTap: () {
                              //Test variable to see dynamic behavior
                              setState(() {
                                codeView = false;
                              });
                            },
                            child: Text("Resend Email.",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineLarge!
                                    .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Palette.current.primaryNeonGreen,
                                        fontSize: 18)),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ])),
    );
  }
}
