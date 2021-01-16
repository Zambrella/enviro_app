import 'package:enviro_app/ui/intensity_page/intensity_page_graph.dart';
import 'package:enviro_app/ui/intensity_page/intensity_page_graph_header.dart';
import 'package:enviro_app/ui/intensity_page/intensity_page_header.dart';
import 'package:enviro_app/ui/intensity_page/intensity_page_stats.dart';
import 'package:flutter/material.dart';

class IntensityPage extends StatelessWidget {
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
