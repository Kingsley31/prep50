
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:prep50/constants/string_data.dart';
import 'package:prep50/utils/color.dart';
import 'package:prep50/utils/preps_icons_icons.dart';
import 'package:prep50/utils/text.dart';
import 'package:prep50/view-models/home_screen_view_model.dart';
import 'package:prep50/views/home_view/components/logout_dialog.dart';
import 'package:prep50/views/profile/edit_profile.dart';
import 'package:prep50/views/referral_screen.dart';
import 'package:prep50/views/subject_reselection_screen.dart';
import 'package:prep50/views/subscription/subscription_screen.dart';
import 'package:prep50/views/terms_of_service_screen.dart';
import 'package:prep50/widgets/app_button.dart';
import 'package:provider/provider.dart';
import 'package:prep50/models/user.dart';

import '../../settings_view/security_and_privacy_screen.dart';
import '../../support_view.dart/support_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeScreenViewModel homeScreenViewModel = Provider.of<HomeScreenViewModel>(context,listen: false);
    return Container(
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.all(20),
      width: MediaQuery.of(context).size.width / 3 * 2,
      color: Colors.white,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 100,
                width: 100,
                child: FutureBuilder<User>(
                  future: homeScreenViewModel.getLoggedInUser(),
                  builder: (context,snapshot){
                    if(snapshot.hasData && snapshot.data!=null){
                      final User user = snapshot.data!;
                      return user.photo.isNotEmpty?
                      CircleAvatar(backgroundImage: NetworkImage("$BASE_URL/${user.photo}"),):
                      CircleAvatar(backgroundImage: AssetImage("assets/png/dummy_avatar.png"),);
                    }

                    return Center(
                      child: SizedBox(
                        height: 20.0,
                        width: 20.0,
                        child: CircularProgressIndicator(
                          color: kPrimaryColor,
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 10),
              FutureBuilder<User>(
                  future: homeScreenViewModel.getLoggedInUser(),
                  builder: (context,snapshot) {
                  if(snapshot.hasData && snapshot.data!=null){
                    return AppText.heading5M("@${snapshot.data?.username}",multiText: true,);
                  }
                  return Center(
                    child: SizedBox(
                      height: 20.0,
                      width: 20.0,
                      child: CircularProgressIndicator(
                        color: kPrimaryColor,
                      ),
                    ),
                  );
                }
              ),
              SizedBox(height: 5),
              FutureBuilder<User>(
                  future: homeScreenViewModel.getLoggedInUser(),
                  builder: (context,snapshot) {
                    if(snapshot.hasData && snapshot.data!=null){
                      return AppText.captionText(
                        "${snapshot.data?.email}",
                        color: kMidBlackColor,
                        multiText: true,
                      );
                    }
                    return Center(
                      child: SizedBox(
                        height: 20.0,
                        width: 20.0,
                        child: CircularProgressIndicator(
                          color: kPrimaryColor,
                        ),
                      ),
                    );
                }
              ),
              SizedBox(height: 10),
              AppButton(
                title: "Edit Profile",
                color: true,
                onTap: () {
                  Navigator.pop(context);
                  PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: EditProfile(),
                    withNavBar: false, // OPTIONAL VALUE. True by default.
                  );
                },
              ),
              drawerItems(context, PrepsIcons.subscription, "Subscription",page: SubscriptionScreen()),
              drawerItems(context, PrepsIcons.security, "Security & Privacy",
                  page: SecurityAndPrivacyScreen()),
              drawerItems(context, PrepsIcons.subject, "Subjects Re-selection",page: SubjectsReselectScreen()),
              drawerItems(context, PrepsIcons.refer, "Refer",
                  page: ReferralScreen()),
              drawerItems(context, PrepsIcons.support, "Support",
                  page: SupportScreen()),
              drawerItems(context, PrepsIcons.bookmark, "Terms of service",page: TermsOfServiceScreen()),
              drawerItems(context, PrepsIcons.logout, "Logout"),
            ],
          ),
        ),
      ),
    );
  }

  Widget drawerItems(BuildContext context, IconData icon, String title,
      {page}) {
    return InkWell(
      onTap: () async {
        if(page == null ){
          final bool logout = await LogoutDialog.show(context)??false;
          if(logout){
            HomeScreenViewModel homeScreenViewModel = Provider.of<HomeScreenViewModel>(context, listen: false);
            try{
              await homeScreenViewModel.logoutUser(disableSettings: true);
              Navigator.pop(context);
              //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen()));
            }catch(e){}
          }

        }
        if (page != null) {
          Navigator.pop(context);
          PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: page,
            withNavBar: false, // OPTIONAL VALUE. True by default.
          );
          return;
        }

      },
      child: Row(
        children: [
          Container(
            height: 40,
            width: 40,
            margin: EdgeInsets.symmetric(vertical: 10),
            padding: EdgeInsets.all(5),
            color: kPrimaryColor.shade300,
            child: Center(
              child: Icon(
                icon,
                color: kPrimaryColor,
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(child: AppText.heading6M("$title",multiText: true,))
        ],
      ),
    );
  }
}
