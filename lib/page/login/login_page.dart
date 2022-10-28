import 'package:dim_sum_app/base/base.dart';
import 'package:dim_sum_app/generated/l10n.dart';
import 'package:dim_sum_app/page/page_export.dart';
import 'package:dim_sum_app/utils/screen_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginPage extends BasePage {
  LoginPage({Key? key}) : super(bloc: LoginBloc());
  static const routeName = '/LoginPage';

  @override
  BasePageState<BasePage<BaseBloc>> getState() => _LoginPageState();
}

class _LoginPageState extends BasePageState<LoginPage> {
  final _focusNodePhoneNumber = FocusNode();
  final _focusNodePassword = FocusNode();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _formKeyPhone = GlobalKey<FormState>();
  final _formKeyPass = GlobalKey<FormState>();
  bool _passwordVisible = false;
  String? errorMessage;
  bool isLogin = true;
  late LoginBloc _bloc;
  final regexEmail = RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

  void hiddenKeyBoard() {
    Future.delayed(const Duration(),
        () => SystemChannels.textInput.invokeMethod('TextInput.hide'));
  }

  void _handleAuth() {
    _bloc.outUID.listen((value) {
      showDialogRegister(value!.isNotEmpty ? S.current.account_has_create : S.current.account_create_fail);
    });
  }

  @override
  void onCreate() {
    _bloc = getBloc();
    _handleAuth();
  }

  @override
  void onDestroy() {
    // TODO: implement onDestroy
  }

  Future<void> showDialogRegister(String status) async {
    showDialog(
        context: context,
        builder: (buildContext) {
          return AlertDialog(
            title: Text(S.current.notification),
            content: Text(status),
            actions: [
              ElevatedButton(
                child: Text(S.current.close, style: TextStyle(fontSize: ScreenUtil.getInstance().getAdapterSize(15)),),
                onPressed: () {
                  Navigator.pop(buildContext);
                },
              ),
            ],
            actionsAlignment: MainAxisAlignment.center,
          );
        });
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      body: Container(
          height: ScreenUtil.getInstance().screenHeight,
          width: ScreenUtil.getInstance().screenWidth,
          color: Colors.white,
          padding: EdgeInsets.all(ScreenUtil.getInstance().getAdapterSize(60)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                S.current.dim_sum,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: ScreenUtil.getInstance().getAdapterSize(25),
                    color: Colors.amber[300]),
              ),
              SizedBox(height: ScreenUtil.getInstance().getAdapterSize(15)),
              _itemInput(
                  hintText: S.current.userName,
                  autoFocus: false,
                  focusNode: _focusNodePhoneNumber,
                  obscureText: false,
                  globalKey: _formKeyPhone,
                  onSubmit: (value) {
                    _focusNodePhoneNumber.unfocus();
                    _focusNodePassword.requestFocus();
                  },
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  onChange: (value) {},
                  validator: (value) {
                    return null;
                  }),
              SizedBox(height: ScreenUtil.getInstance().getAdapterSize(12)),
              _itemInput(
                  hintText: S.current.password,
                  autoFocus: false,
                  focusNode: _focusNodePassword,
                  obscureText: !_passwordVisible,
                  controller: _passController,
                  globalKey: _formKeyPass,
                  suffixIcon: IconButton(
                    icon: Icon(
                        _passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.grey),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                  onChange: (value) {},
                  validator: (value) {
                    return null;
                  },
                  onSubmit: (value) {
                    hiddenKeyBoard();
                    _bloc.signInWithEmailAndPassword(
                        email: _emailController.text,
                        password: _passController.text);
                  }),
              SizedBox(height: ScreenUtil.getInstance().getAdapterSize(15)),
              ElevatedButton(
                onPressed: () {
                  hiddenKeyBoard();
                  _bloc.signInWithEmailAndPassword(
                      email: _emailController.text,
                      password: _passController.text);
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.amberAccent,
                ),
                child: Text(S.current.login.toUpperCase()),
              ),
              TextButton(
                  onPressed: () {
                    if (_emailController.text.isNotEmpty &&
                        _passController.text.isNotEmpty) {
                      hiddenKeyBoard();
                      if(!regexEmail.hasMatch(_emailController.text)){
                        showToast(S.current.email_wrong_format, true);
                      }else{
                        _bloc.createUserWithEmailAndPassword(
                            email: _emailController.text,
                            password: _passController.text);
                      }

                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content:
                            Text(S.current.username_and_password_not_empty),
                        duration: const Duration(seconds: 1),
                      ));
                    }
                  },
                  child: Text(
                    S.current.register,
                    style: const TextStyle(color: Colors.amber),
                  ))
            ],
          )),
    );
  }


  Widget _itemInput(
      {required String hintText,
      required bool autoFocus,
      required FocusNode focusNode,
      required ValueChanged<String?> onSubmit,
      required ValueChanged<String?> onChange,
      required TextEditingController controller,
      required bool obscureText,
      required GlobalKey globalKey,
      required FormFieldValidator<String> validator,
      TextInputType? keyboardType,
      Widget? suffixIcon}) {
    return Form(
      key: globalKey,
      child: TextFormField(
        autofocus: autoFocus,
        focusNode: focusNode,
        keyboardType: keyboardType,
        onFieldSubmitted: onSubmit,
        controller: controller,
        obscureText: obscureText,
        style: const TextStyle(color: Colors.black),
        onChanged: onChange,
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.grey),
            filled: true,
            fillColor: Colors.white,
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: Color(0x33101010), width: 1),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: Colors.amber, width: 1),
            ),
            errorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: Colors.red, width: 1),
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(width: 1, color: Colors.red),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 15),
            suffixIcon: suffixIcon),
        validator: validator,
      ),
    );
  }
}
