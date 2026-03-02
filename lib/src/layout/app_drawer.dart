import 'package:flutter/material.dart';
import 'package:drive_worth/src/config/app_colors.dart';
import 'package:drive_worth/src/shared/utils/sound.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.white,
      // 使用 Column 來排列 Drawer 中的項目
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: UserAccountsDrawerHeader(
                  // 使用者帳戶頭像和資訊
                  accountName: Text(
                    "Ethan",
                    style: TextStyle(color: AppColors.white),
                  ), // 使用者名稱
                  accountEmail: Text(
                    "ethan@gmail.com",
                    style: TextStyle(color: AppColors.white),
                  ), // 使用者電子郵件
                  currentAccountPicture: CircleAvatar(
                    // 當前使用者頭像
                    backgroundImage: AssetImage(
                      "assets/images/Ethan.png",
                    ), // 頭像圖片
                  ),
                  decoration: BoxDecoration(
                    // 背景裝飾
                    image: DecorationImage(
                      fit: BoxFit.cover, // 圖片填充方式
                      image: AssetImage("assets/images/app_icon.png"),
                    ),
                  ),
                ),
              ),
            ],
          ),
          // 使用 ListTile 來顯示 Drawer 中的選項
          ListTile(
            leading: CircleAvatar(
              backgroundColor: AppColors.personalMenuIcon,
              child: IconButton(
                onPressed: () {
                  Sound.click1();
                },
                icon: Icon(Icons.person),
                color: AppColors.white,
              ),
            ),
            title: Text("個人中心", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Divider(),
          ListTile(
            leading: CircleAvatar(
              backgroundColor: AppColors.personalMenuIcon,
              child: IconButton(
                onPressed: () {
                  Sound.click1();
                },
                icon: Icon(Icons.message),
                color: AppColors.white,
              ),
            ),
            title: Text("訊息中心", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Divider(),
          ListTile(
            leading: CircleAvatar(
              backgroundColor: AppColors.personalMenuIcon,
              child: IconButton(
                onPressed: () {
                  Sound.click1();
                },
                icon: Icon(Icons.image),
                color: AppColors.white,
              ),
            ),
            title: Text("相簿中心", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Divider(),
          ListTile(
            leading: CircleAvatar(
              backgroundColor: AppColors.personalMenuIcon,
              child: IconButton(
                onPressed: () {
                  Sound.click1();
                },
                icon: Icon(Icons.wifi),
                color: AppColors.white,
              ),
            ),
            title: Text("網路設置", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Divider(),
          ListTile(
            leading: CircleAvatar(
              backgroundColor: AppColors.personalMenuIcon,
              child: IconButton(
                onPressed: () {
                  Sound.click1();
                },
                icon: Icon(Icons.map),
                color: AppColors.white,
              ),
            ),
            title: Text("地圖設置", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Divider(),
          ListTile(
            leading: CircleAvatar(
              backgroundColor: AppColors.personalMenuIcon,
              child: IconButton(
                onPressed: () {
                  Sound.click1();
                },
                icon: Icon(Icons.category),
                color: AppColors.white,
              ),
            ),
            title: Text("分類設置", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Divider(),
        ],
      ),
    );
  }
}
