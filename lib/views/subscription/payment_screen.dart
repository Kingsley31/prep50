
import 'package:flutter/material.dart';
import 'package:prep50/constants/string_data.dart';
import 'package:prep50/utils/color.dart';
import 'package:prep50/utils/text.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../view-models/payment_screen_viewmodel.dart';


class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key,required this.paymentType,required this.authorizationUrl,required this.paymentReference}) : super(key: key);
  final String paymentType;
  final String authorizationUrl;
  final String paymentReference;

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {

  //AppToast? appToast;



  @override
  void initState() {
    super.initState();
    // appToast = AppToast(context: context);
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
    //   PaymentScreenViewModel paymentScreenViewModel = Provider.of<PaymentScreenViewModel>(context,listen: false);
    //   paymentScreenViewModel.loadPaymentDetails(amount:widget.amount,paymentType:widget.paymentType);
    // });
  }

  @override
  Widget build(BuildContext context) {
    PaymentScreenViewModel paymentScreenViewModel = Provider.of<PaymentScreenViewModel>(context,listen: false);
    return Scaffold(
      body: SafeArea(
        child: Container(
          child:Stack(
                children: [
                  WebView(
                    initialUrl: widget.authorizationUrl,
                    javascriptMode: JavascriptMode.unrestricted,
                    userAgent: 'Flutter;Webview',
                    onWebResourceError: (WebResourceError error) async{
                      paymentScreenViewModel.isLoading=true;
                      // if(paymentScreenViewModel.pageLoaded){
                      //   await _showPaymentStatusDialog(title: "Error Loading Page", message: "We could not get the payment, please ensure your device is online and try again.");
                      //   Navigator.of(context).pop();
                      // }

                    },
                    onProgress: (progress){
                      paymentScreenViewModel.isLoading=progress<100;
                    },
                    navigationDelegate: (navigation)async{
                      print(navigation.url);
                      if(navigation.url == 'https://standard.paystack.co/close'){
                        try{
                          bool paymentSuccessful= await paymentScreenViewModel.verifyPayment(paymentType: widget.paymentType,paymentReference: widget.paymentReference);
                          if(paymentSuccessful){
                            await _showPaymentStatusDialog(title: "Payment Successful", message: "Subscription completed successfully, you can now access all premium features of Prep50 app.");
                            Navigator.of(context).pop();
                          }else{
                            await _showPaymentStatusDialog(title: "Payment Failed", message: "We could not verify your payment, please contact support if completed your payment successfully.");
                            Navigator.of(context).pop();
                          }
                        }catch(e){
                          print(e.toString());
                          await _showPaymentStatusDialog(title: "Payment Failed", message: "We could not verify your payment, please contact support if completed your payment successfully.");
                          Navigator.of(context).pop();
                        }

                      }
                      //Listen for callback URL
                      if(navigation.url.contains(PAYSTACK_CALLBACK_URL)){
                        try{
                          bool paymentSuccessful= await paymentScreenViewModel.verifyPayment(paymentType: widget.paymentType,paymentReference: widget.paymentReference);
                          if(paymentSuccessful){
                            await _showPaymentStatusDialog(title: "Payment Successful", message: "Subscription completed successfully, you can now access all premium features of Prep50 app.");
                            Navigator.of(context).pop();
                          }else{
                            await _showPaymentStatusDialog(title: "Payment Failed", message: "We could not verify your payment, please contact support if completed your payment successfully.");
                            Navigator.of(context).pop();
                          }
                        }catch(e){
                          print(e.toString());
                          await _showPaymentStatusDialog(title: "Payment Failed", message: "We could not verify your payment, please contact support if completed your payment successfully.");
                          Navigator.of(context).pop();
                        }
                      }
                      return NavigationDecision.navigate;
                    },
                  ),
                  Consumer<PaymentScreenViewModel>(
                        builder:(context,paymentScreenViewModel,child){
                          if (paymentScreenViewModel.isLoading){
                            return Container(
                              width: double.infinity,
                              height: double.infinity,
                              color: Colors.black87,
                              child: Center(
                                child: SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            );
                          }
                          return Container();
                      }
                    ),
                ],
          ),
        ),
      ),
    );
  }


  // Widget _buildErrorWidget(PaymentScreenViewModel paymentScreenViewModel) {
  //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
  //     appToast?.showToast(message: "${paymentScreenViewModel.errorMessage}");
  //   });
  //
  //   return Container(
  //     width: double.infinity,
  //     height: double.infinity,
  //     padding: const EdgeInsets.all(20),
  //     child: Center(
  //       child: AppButton(
  //         title: "Load Payment Details",
  //         width: 197,
  //         color: true,
  //         onTap: () => {
  //           paymentScreenViewModel.loadPaymentDetails(amount:widget.amount,paymentType:widget.paymentType)
  //         },
  //       ),
  //     ),
  //   );
  // }

  Future<dynamic> _showPaymentStatusDialog({required String title,required String message}) {
    return showDialog<void>(
      context: context,
      builder: (builder) {
        return AlertDialog(
          title: AppText.heading6(title),
          contentPadding: EdgeInsets.all(20),
          content: Container(
            child: AppText.textFieldS(message,multiText: true,),
          ),
          actions: <Widget>[
            TextButton(
              child: AppText.textField("OK",color: kPrimaryColor,),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
