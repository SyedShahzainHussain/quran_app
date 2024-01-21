import 'package:flutter/material.dart';

class ShareButton extends StatelessWidget {
  final String? title;
  final void Function()? onPressed;
  final IconData? iconData;
  const ShareButton({
    super.key,
    this.title,
    this.iconData,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.55,
        height: MediaQuery.of(context).size.height * 0.055,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xffee8f8b)),
            onPressed: onPressed,
            child: Row(
              children: [
                Icon(
                  iconData,
                  size: MediaQuery.of(context).size.height * 0.03,
                  // color: appProvider.isDark
                  //     ? Colors.black
                  //     : Colors.white,
                ),
                Text(
                  "  $title",
                  style: const TextStyle(
                      // color: appProvider.isDark
                      //     ? Colors.black
                      //     : Colors.white,
                      ),
                )
              ],
            )),
      ),
    );
  }
}
