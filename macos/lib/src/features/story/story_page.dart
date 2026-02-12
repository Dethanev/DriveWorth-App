import 'package:flutter/material.dart';
import '../story/data/story_data.dart';

class StoryPage extends StatelessWidget {
  const StoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(255, 239, 190, 1),
      child: GridView.builder( // 改用 builder
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1, // 一排一個
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          childAspectRatio: 0.9,
        ),
        itemCount: listData.length, // 告訴它有幾筆資料
        itemBuilder: (context, index) {
          // 這裡只負責「怎麼畫出一格」
          final data = listData[index];
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black, width: 5),
            ),
            child: Column(
              children: [
                Expanded( // 建議加上 Expanded 防止圖片溢出
                  child: Image.network(
                    data["imageUrl"], 
                    fit: BoxFit.cover, // 讓圖片填滿空間
                    width: double.infinity,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  data["title"],
                  style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10), // 底部留點白
              ],
            ),
          );
        },
      ),
    );
  }
}