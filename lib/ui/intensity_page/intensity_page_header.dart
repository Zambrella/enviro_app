import 'package:enviro_app/business_logic/cubits/cubit/intensity_cubit.dart';
import 'package:enviro_app/constants/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IntensityPageHeader extends StatefulWidget {
  @override
  _IntensityPageHeaderState createState() => _IntensityPageHeaderState();
}

class _IntensityPageHeaderState extends State<IntensityPageHeader>
    with SingleTickerProviderStateMixin {
  Animation<int> _textAnimation;
  IntTween _intTween;
  AnimationController _textAnimationController;

  @override
  void initState() {
    super.initState();
    context.read<IntensityCubit>().loadNationalIntensityData();
    _textAnimationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    _intTween = IntTween(begin: 0, end: 1);
    _textAnimation = _intTween.animate(_textAnimationController);
  }

  @override
  void dispose() {
    super.dispose();
    _textAnimationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<IntensityCubit, IntensityState>(
      listener: (context, state) {
        if (state is IntensityFetchSuccess) {
          // Update the end value of the Tween to the intensity value
          _intTween.end = state.intensity.forecast;
          // Run the animation when the value exists after it has been fetched
          _textAnimationController.forward();
        }
      },
      child: Container(
        padding: EdgeInsets.all(16),
        child: Center(
          child: Column(
            children: [
              Text(
                'Carbon Intensity',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              // Use animated builder to handle the rebuild of the tree efficiently
              AnimatedBuilder(
                  animation: _textAnimation,
                  builder: (context, child) {
                    return _CustomTextWidget(
                      value: _textAnimation.value,
                    );
                  }),
              Text(
                'gCO₂/KWh',
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                      fontSize: 10,
                      // Changing height so that the text is closer to the text above
                      height: 0.6,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomTextWidget extends StatelessWidget {
  final int value;
  _CustomTextWidget({this.value});
  @override
  Widget build(BuildContext context) {
    return Text(
      value.toString(),
      style: Theme.of(context).textTheme.headline4.copyWith(
            color: UIFunctions.getColor(value),
            height: 1.0,
          ),
    );
  }
}
