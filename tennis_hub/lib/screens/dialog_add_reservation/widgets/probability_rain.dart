import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../bloc_weather/weather_bloc_bloc.dart';
import '../blocs/bloc/bloc_court_bloc.dart';

class ProbabilityRain extends StatelessWidget {
  DateTime timeSelected;
  ProbabilityRain(this.timeSelected);
  @override
  Widget build(BuildContext context) {
    context.read<WeatherBlocBloc>().add(CalculateProbability(timeSelected));
    return BlocBuilder<WeatherBlocBloc, WeatherBlocState>(
        builder: (context, state) {
      if (state is ProbabilityCalculated) {
        print('asd');
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('${state.probability.toStringAsFixed(1)}%',
                style: TextStyle(color: Colors.grey[300])),
            FaIcon(
              FontAwesomeIcons.cloudRain,
              size: 16.0,
              color: Colors.grey[200],
            ),
          ],
        );
      }
      return Text('');
    });
  }
}
