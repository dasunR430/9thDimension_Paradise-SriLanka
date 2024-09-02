import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AccountAppbarBottom extends StatelessWidget {
  const AccountAppbarBottom({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding:
      const EdgeInsetsDirectional.only(top: 90.0, start: 20.0, end: 20.0, bottom: 20.0),
      child: Center(
        child: Column(
          children: [
            const SizedBox(height: 10,),
            SizedBox(
              width: 100,
              height: 100,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child:  Image.asset("assets/images/default_dp.jpg"),
                            ),
            ),
            const SizedBox(height: 50.0),
            Text("Vihanga Munasinghe", style: TextStyle(color: Colors.white, fontSize: 20,),)
          ],
        ),
      ),
    );
  }
}
