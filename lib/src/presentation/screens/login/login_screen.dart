import 'package:device_guru/src/data/repositories/impl/users_repository_impl.dart';
import 'package:device_guru/src/presentation/screens/login/bloc/bloc.dart';
import 'package:device_guru/src/presentation/screens/login/bloc/login_bloc.dart';
import 'package:device_guru/src/presentation/widgets/circular_loading_widget.dart';
import 'package:device_guru/src/presentation/widgets/image_carousel_widget.dart';
import 'package:device_guru/src/utils/config/size_config.dart';
import 'package:device_guru/src/utils/constants/route_path.dart';
import 'package:device_guru/src/utils/enums/image_carousel_type.dart';
import 'package:device_guru/src/utils/helper.dart';
import 'package:device_guru/src/utils/theme/color_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool showError = false;
  bool obscureText = true;
  bool showOtpScreen = false;
  bool _isButtonDisabled = true;
  bool _verificationInProgress = false;
  bool _isLoginSuccesful = false;
  TextEditingController _mobileNumber = new TextEditingController();
  TextEditingController _password = new TextEditingController();
  TextEditingController _otpController = new TextEditingController();
  String phoneNo = "";
  String smsCode = "";
  String verificationId = "";


  Widget _title() {
    return Center(
      child: Image(
        image: AssetImage('assets/servapp-logo.png'),
        height: SizeConfig.blockSizeVertical * 5,
      ),
    );
  }

  Widget _imageCarousel() {
    return ImageCarouselWidget(type: ImageCarouselType.CarouselWithDottedIndicator);
  }

  void _validateMobileNumber(String mobileNumber) {
    if (Helper.checkLengthOfStringLessThan(mobileNumber,10)){
      updateIsButtonDisbaled(false);
    } else {
      updateIsButtonDisbaled(true);
    }
  }

  void updateIsButtonDisbaled(bool value) {
    setState(() {
      this._isButtonDisabled = value;
    });
  }

  Widget _entryFieldBuilder(
      String title,
      IconData iconData,
      TextEditingController _text, {
        bool isPassword = false,
        bool isDigit = false,
        int maxLength = 10,
      }) {
    return Container(
      //TODO: Allow Multiple Countries Extension in Mobile Number Text Field.
//      margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
      height: SizeConfig.blockSizeVertical * 12,
      child: TextField(
        controller: _text,
        onChanged: (_text) {
          _validateMobileNumber(_text);
        },
//        onChanged == null
//            ? (_text) {
//                setState(() {
//                  showError = true;
//                });
//              }
//            :,
        maxLength: maxLength,
        obscureText: isPassword ? obscureText : isPassword,
        keyboardType: isDigit ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          helperText: "",
          labelStyle: TextStyle(fontSize: 14),
          hintStyle: TextStyle(fontSize: 14),
          contentPadding: EdgeInsets.all(0),
          labelText: title,
          hintText: "Enter Your $title",
          prefixIcon: Icon(
            iconData,
            size: SizeConfig.blockSizeHorizontal * 6,
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          fillColor: Color(0xfff3f3f4),
          //
          filled: true,
          suffixIcon: isPassword
              ? IconButton(
            icon: Icon(
                obscureText ? Icons.visibility : Icons.visibility_off),
            onPressed: () {
              setState(
                    () {
                  obscureText = !obscureText;
                },
              );
            },
          )
              : null,
        ),
      ),
    );
  }

  Future<void> verifyPhone() async{
    setState(() {
      _verificationInProgress = true;
    });
    print("Verification in Progress?? $_verificationInProgress");

    phoneNo = "+91${_mobileNumber.text}";
    print("The value of phoneNo is :-$phoneNo");
    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId) {
      print("Inside Auto Retrieve");
      this.verificationId = verId;
    };

    final void Function(String verId, int? forceCodeResend) smsCodeSent = (String verId, int? forceCodeResend) {
      this.verificationId = verId;
      print("Inside SMS Code Sent Function");
      smsCodeDialog(context).then((value) {
        print('Signed in');
      });
    };

    final PhoneVerificationCompleted verifiedSuccess =
        (PhoneAuthCredential credential) {
      print('verified');
    };

    final PhoneVerificationFailed veriFailed =
        (FirebaseAuthException exception) {
      print("Exception has Occured");
      print('${exception.message}');
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: this.phoneNo,
        codeAutoRetrievalTimeout: autoRetrieve,
        codeSent: smsCodeSent,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verifiedSuccess,
        verificationFailed: veriFailed);
  }

  Future<dynamic> smsCodeDialog(BuildContext context) {
    setState(() {
      _verificationInProgress = false;
    });
    print("Inside Otp Screen  " + _verificationInProgress.toString());
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new AlertDialog(
          title: Text('Enter OTP'),
          content: TextField(
            maxLength: 6,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              this.smsCode = value;
            },
          ),
          contentPadding: EdgeInsets.all(10.0),
          actions: <Widget>[
            new FlatButton(
              child: Text('Done'),
              onPressed: () {
                signIn();
              },
            ),
          ],
        );
      },
    );
  }

  signIn() async {
    setState(() {
      _verificationInProgress = true;
    });
    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsCode);

    await FirebaseAuth.instance
        .signInWithCredential(phoneAuthCredential)
        .then((user) {
      setState(() {
        _verificationInProgress = false;
//        _isLoginSuccesful = true;
      });
      // TODO: New User Logged In.
      String userResponse = UsersRepositoryImpl()
          .loginOrSignUp("something");
      print("APi CALL was made successfully");
      userResponse == "Something"
          ? Navigator.of(context).pushReplacementNamed(RoutePath.MAIN_SCREEN)
          : Navigator.of(context)
          .pushReplacementNamed(RoutePath.ERROR_SCREEN);
//      });
      print("User is :-" + user.toString());
    }).catchError((e) {
      setState(() {
        _verificationInProgress = false;
      });
      _otpController.clear();
      Fluttertoast.showToast(msg: "Otp Entered is Wrong. Please Try again!!!");
      print(e);
    });
  }


  Widget _loginSignUpBox() {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: SizeConfig.blockSizeVertical * 2,
          horizontal: SizeConfig.blockSizeHorizontal * 3),
      height: SizeConfig.blockSizeVertical * 50,
      width: SizeConfig.blockSizeHorizontal * 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.shade200,
              offset: Offset(2, 4),
              blurRadius: 5,
              spreadRadius: 2),
        ],
        color: ColorConstants.white,
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                "Login/Signup Using",
                style: TextStyle(
                    color: ColorConstants.grey, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 2,
              ),
              _entryFieldBuilder("Mobile Number", Icons.phone, _mobileNumber,
                  isDigit: true, maxLength: 10),
              Builder(
                builder: (context) => InkWell(
                  onTap: _isButtonDisabled
                      ? () {
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Enter a valid Mobile Number"),
                      ),
                    );
                  }
                      : verifyPhone,
                  child: Container(
                    width: SizeConfig.blockSizeHorizontal * 83,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Colors.grey.shade200,
                            offset: Offset(2, 4),
                            blurRadius: 5,
                            spreadRadius: 2),
                      ],
                      gradient: _isButtonDisabled
                          ? LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            ColorConstants.grey,
                            ColorConstants.grey
                          ])
                          : LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [Color(0xfffbb448), Color(0xfff7892b)],
                      ),
                    ),
                    child: Text(
                      "Submit",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
          // _verificationInProgress?AlertDialog(content: Center(child: CircularLoadingWidget(),),):Container(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context); // Initialize the entire size of the Application by dividing things into blocks.
    return BlocProvider(
      create: (context) =>
          LoginBloc(UsersRepositoryImpl()),
      child:Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding:
            EdgeInsets.fromLTRB(20, SizeConfig.blockSizeVertical * 5, 20, 20),
            height: SizeConfig.blockSizeVertical * 100,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(0)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.shade200,
                    offset: const Offset(2, 4),
                    blurRadius: 5,
                    spreadRadius: 2),
              ],
              gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    ColorConstants.backgroundBlue,
                    ColorConstants.fontBlue
                  ]),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                _title(),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 3,
                ),
                _imageCarousel(),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 3,
                ),
                _loginSignUpBox(),
                BlocBuilder<LoginBloc, LoginState>(
                  // ignore: missing_return
                  builder: (context, state) {
                    if(_isLoginSuccesful){
                      BlocProvider.of<LoginBloc>(context)
                          .add(LogInOrSignUp(_mobileNumber.text));
                      return Container();
                    }
                    if(state is InitialLoginState){
                      return Container();
                    }
                    else if(state is LoadingLoginState){
                      return const Center(child: CircularLoadingWidget());
                    }
                    else if(state is LoadedLoginState){
                      Navigator.pushNamed(context, RoutePath.MAIN_SCREEN);
                      return Container();
                    }
                    else if(state is ErrorLoginState){
                      Fluttertoast.showToast(msg: "Oops!!! Something Went Wrong. Please Try Again!!");
                      return Container();
                    }
                    else
                      return Container();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
