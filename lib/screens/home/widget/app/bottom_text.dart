import 'package:flutter/material.dart';

class BottomText extends StatelessWidget {
  const BottomText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            height: 30,
            child: Text(
                "\"Indeed, It is We who sent down the Qur'an\nand indeed, We will be its Guardian\"",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelMedium!.copyWith()),
          ),
          const SizedBox(
            height: 20,
          ),
          Text("Surah Al-Hijr\n",
              style: Theme.of(context).textTheme.labelMedium!.copyWith()),
        ],
      ),
    );
  }
}
