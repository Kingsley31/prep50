


import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:prep50/services/system_info_services.dart';
import 'package:prep50/storage/app_data.dart';
import 'package:prep50/widgets/app_button.dart';
import 'package:prep50/widgets/app_toast.dart';
import 'package:provider/provider.dart';


import '../utils/text.dart';
import '../view-models/terms_of_service_screen_viewmodel.dart';
import '../widgets/app_back_icon.dart';

class TermsOfServiceScreen extends StatefulWidget {
  const TermsOfServiceScreen({Key? key}) : super(key: key);

  @override
  State<TermsOfServiceScreen> createState() => _TermsOfServiceScreenState();
}

class _TermsOfServiceScreenState extends State<TermsOfServiceScreen> {
  AppToast? appToast;

  @override
  void initState() {
    super.initState();
    appToast=AppToast(context: context);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      TermsOfServiceScreenViewModel termsOfServiceScreenViewModel=Provider.of<TermsOfServiceScreenViewModel>(context,listen: false);
      termsOfServiceScreenViewModel.loadTerOfService();
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Container(
              width: double.infinity,
              color: Color(0xffffffff),
              child: SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.all(13.5),
                  child: Row(
                    children: [
                      AppBackIcon(),
                      SizedBox(
                        width: 24,
                      ),
                      AppText.heading6S("Terms Of Service"),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
                child:Consumer<TermsOfServiceScreenViewModel>(
                    builder: (context,termsOfServiceScreenViewModel,child){
                      return termsOfServiceScreenViewModel.errorMessage.isNotEmpty?
                      _buildErrorWidget(termsOfServiceScreenViewModel):termsOfServiceScreenViewModel.isLoadingTermsOfService?
                      _buildLoadingWidget():
                      _buildTermsOfServiceContent(termsOfServiceScreenViewModel);
                    }
                ),
            ),
           ],
        )
    );
  }

  Widget  _buildErrorWidget(TermsOfServiceScreenViewModel termsOfServiceScreenViewModel) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      appToast?.showToast(message: termsOfServiceScreenViewModel.errorMessage);
    });

    print(termsOfServiceScreenViewModel.errorMessage);
    return Center(
      child: AppButton(
        title: "Load Terms Of Service",
        width: 197,
        color: true,
        onTap: () => {
          termsOfServiceScreenViewModel.loadTerOfService()
        },
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

Widget _buildTermsOfServiceContent(TermsOfServiceScreenViewModel termsOfServiceScreenViewModel) {
  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: MarkdownBody(data: termsOfServiceScreenViewModel.termsOfServiceMarkdown),
    ),
  );
}


}
