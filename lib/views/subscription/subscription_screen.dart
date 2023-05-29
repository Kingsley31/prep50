
import 'package:flutter/material.dart';
import 'package:prep50/utils/color.dart';
import 'package:prep50/utils/text.dart';
import 'package:prep50/view-models/subscription_screen_viewmodel.dart';
import 'package:prep50/views/subscription/payment_screen.dart';
import 'package:provider/provider.dart';

import '../../widgets/app_button.dart';
import '../../widgets/app_toast.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({Key? key}) : super(key: key);

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  AppToast? appToast;



  @override
  void initState() {
    super.initState();
    appToast = AppToast(context: context);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      SubscriptionScreenViewModel subscriptionScreenViewModel = Provider.of<SubscriptionScreenViewModel>(context,listen: false);
      subscriptionScreenViewModel.loadSubscriptionData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/image/image8.png"),
                ),
              ),
            ),
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                // color: Color(0xff000000).withOpacity(0.3),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.transparent,
                    Colors.transparent,
                    Colors.transparent,
                    Colors.black,
                    Colors.black,
                    Colors.black,
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 15,
              right: 15,
              child: SafeArea(
                // height: 465,
                child: Consumer<SubscriptionScreenViewModel>(
                  builder: (context,subscriptionScreenViewModel,child) {
                    return subscriptionScreenViewModel.errorMessage.isNotEmpty?
                        _buildErrorWidget(subscriptionScreenViewModel):
                        subscriptionScreenViewModel.isLoadingUserExams?
                            _buildLoadingWidget():
                            _buildSubscriptionWidget(subscriptionScreenViewModel);
                  }
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildErrorWidget(SubscriptionScreenViewModel subscriptionScreenViewModel) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      appToast?.showToast(message: "${subscriptionScreenViewModel.errorMessage}");
    });

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Center(
        child: AppButton(
          title: "Load Exam Details",
          width: 197,
          color: true,
          onTap: () => {
            subscriptionScreenViewModel.loadSubscriptionData()
          },
        ),
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
      child: SizedBox(
        height: 30,
        width: 30,
        child: CircularProgressIndicator(),
      ),
    );
  }

 Widget _buildSubscriptionWidget(SubscriptionScreenViewModel subscriptionScreenViewModel) {
   return Column(
     crossAxisAlignment: CrossAxisAlignment.center,
     children: [
       // SizedBox(height: 188),
       AppText.heading5S(subscriptionScreenViewModel.subscriptionTitle,color:kPrimaryColor,centered: true,),
       SizedBox(height: 10),
       AppText.textField("Subscribe to our yearly plan and have access to all our amazing features like Cafe feature, tutorial podcasts and weekly quiz and lots more beyond your expectation",centered: true,color: Colors.white,multiText: true,),
       SizedBox(height: 15),
       Container(
         clipBehavior: Clip.hardEdge,
         width: double.infinity,
         decoration: BoxDecoration(
           border: Border.all(color: Colors.white,style: BorderStyle.solid),
           borderRadius: BorderRadius.circular(20),
         ),
         child: Stack(
           fit: StackFit.loose,
           children: [
             Padding(padding: EdgeInsets.all(60),child: Container(),),
             Positioned(
               top: 0,
               left: 0,
               child: Image.asset("assets/image/curve_top_left.png"),
             ),
             Positioned(
               bottom: 0,
               right: 0,
               child: Image.asset("assets/image/curve_bottom_right.png"),
             ),
             Positioned(
               bottom: 0,
               top: 0,
               right: 0,
               child: Image.asset("assets/image/refferal_bonus_stripe.png"),
             ),
             Positioned(
               bottom: 0,
               top: 0,
               right: 0,
               left: 0,
               child: Padding(
                 padding: EdgeInsets.only(left: 10,bottom: 20,top: 20,right: 50),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Stack(
                       clipBehavior: Clip.none,
                       children: [
                         AppText.heading1S("₦${subscriptionScreenViewModel.amount.toInt()}",color: Colors.white,),
                         Positioned(
                           right: -9,
                           bottom: 8,
                           child: Container(
                             color: Colors.black87,
                             child: AppText.tinyText("Monthly",color:Colors.white),
                           ),
                         ),
                       ],
                     ),
                     AppText.textFieldS("A subscription to get a push to scale in your next exam in a grand style.",color: Colors.white70,multiText: true,),
                   ],
                 ),
               ),
             ),
           ],
         ),
       ),
       SizedBox(height: 25),
       subscriptionScreenViewModel.showSubscribeNowButton?AppButton(
         color: true,
         title: "Subscribe Now",
         onTap: () {
           Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (builder)=> PaymentScreen(paymentType: subscriptionScreenViewModel.paymentType,authorizationUrl: subscriptionScreenViewModel.authorizationUrl,paymentReference: subscriptionScreenViewModel.paymentReference,)));
         },
         // width: 343,
       ):_buildAlreadySubscribedButton(),
       SizedBox(height: 18),
     ],
   );
 }

 Widget _buildAlreadySubscribedButton() {
   return Padding(
     padding: const EdgeInsets.all(5),
     child: Container(
       height: 53,
       decoration: BoxDecoration(
           color: kPrimaryColor[100],
           borderRadius: BorderRadius.circular(10)),
       child: Center(
         child: AppText.heading6S("Already Subscribed",
           color: Colors.white38,
         ),
       ),
     ),
   );
 }
}
