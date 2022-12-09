import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NoWorkoutsFound extends StatelessWidget {
  const NoWorkoutsFound({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/images/undraw_no_data_re_kwbl.svg',
            height: height * 0.4,
          ),
          const SizedBox(height: 24.0),
          Text(
            'No workouts found',
            style: Theme.of(context).textTheme.headline6,
          ),
          const SizedBox(height: 12.0),
          Text(
            'Once you add a workout, it will show up here.',
            style: Theme.of(context).textTheme.caption,
          )
        ],
      ),
    );
  }
}
