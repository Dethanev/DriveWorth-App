import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:lottie/lottie.dart';
import '../../config/app_colors.dart';
import '../auth/login_page.dart';
import 'widgets/onboarding_button.dart';
import '../../shared/models/mood_data.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int currentPage = 0;
  late LiquidController _liquidController;

  @override
  void initState() {
    _liquidController = LiquidController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. 液體滑動主體
          LiquidSwipe.builder(
            itemCount: moodData.length,
            itemBuilder: (context, index) {
              final data = moodData[index % moodData.length];
              return Container(
                width: double.infinity,
                // 根據 index 獲取背景顏色
                color: _getPageColor(index),
                child: Stack(
                  children: [
                    // 動畫/圖片區域
                    Positioned(
                      top:
                          index == 1
                              ? MediaQuery.of(context).size.height * 0.3
                              : MediaQuery.of(context).size.height * 0.4,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Lottie.asset(
                          data.asset,
                          width: index == 1 ? 300 : 250,
                          height: index == 1 ? 300 : 250,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    // 文字區域
                    Positioned(
                      top: MediaQuery.of(context).size.height * 0.33,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Text(
                          data.moodText,
                          style: TextStyle(color: data.moodColor, fontSize: 30),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            liquidController: _liquidController,
            onPageChangeCallback: pageChangeCallback,
            waveType: WaveType.liquidReveal,
            fullTransitionValue: 880, // 控制滑動彈性
            enableSideReveal: true,
            preferDragFromRevealedArea: true,
            enableLoop: true, // 是否循環播放
            ignoreUserGestureWhileAnimating: true,
            positionSlideIcon: 0.8,
            slideIconWidget: Icon(Icons.arrow_back_ios),
          ),

          // 2. 頂部固定標題 (可選，不需要可以移除)
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 140.0),
              child: Text(
                'Welcome to\nMy App', // 💡 改成您的 App 名稱或歡迎語
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: 40,
                  fontWeight: FontWeight.w900,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),

          // 3. 底部按鈕
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 80.0),
              child: OnboardingButton(
                // 如果您的 moodData 裡沒有 buttonText，可以直接寫字串，例如 'Get Started'
                buttonText: 'Get Started',
                onPressed: () {
                  // 👇 這裡改成跳轉到 LoginScreen
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getPageColor(int index) {
    // 確保這裡引用的顏色在您的 AppColors 裡都有定義
    switch (index) {
      case 0:
        return AppColors.pink;
      case 1:
        return AppColors.yellow;
      case 2:
        return AppColors.blue;
      case 3:
        return AppColors.indigo;
      case 4:
        return AppColors.orange;
      default:
        return AppColors.pink;
    }
  }

  pageChangeCallback(int lpage) {
    setState(() {
      currentPage = lpage;
    });
  }
}
