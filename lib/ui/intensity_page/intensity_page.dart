import '../../business_logic/cubit/intensity_cubit.dart';
import 'intensity_page_graph.dart';
import 'intensity_page_graph_header.dart';
import 'intensity_page_header.dart';
import 'intensity_page_stats.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IntensityPage extends StatefulWidget {
  @override
  _IntensityPageState createState() => _IntensityPageState();
}

class _IntensityPageState extends State<IntensityPage> {
  @override
  void initState() {
    super.initState();
    context.read<IntensityCubit>().loadNationalIntensityData();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IntensityPageHeader(),
        IntensityPageGraphHeader(),
        IntensityPageGraph(),
        IntensityPageStats(),
      ],
    );
  }
}
