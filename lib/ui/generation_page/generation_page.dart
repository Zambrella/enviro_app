import 'package:enviro_app/business_logic/cubits/cubit/generation_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GenerationPage extends StatefulWidget {
  @override
  _GenerationPageState createState() => _GenerationPageState();
}

class _GenerationPageState extends State<GenerationPage> {
  @override
  void initState() {
    super.initState();
    context.read<GenerationCubit>().loadGenerationData(
        from: DateTime.now().subtract(Duration(days: 1)), to: DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GenerationCubit, GenerationState>(
      builder: (context, state) {
        if (state is GenerationFetchInProgress) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is GenerationFetchSuccess) {
          return Container(
            child: Text(state.generationInfo.toString()),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
