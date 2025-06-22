import 'package:flutter/material.dart';

class InfoText extends StatelessWidget {
  final String name;
  final String birthday;
  final String info;
  final List<String> musicGroups;

  const InfoText({
    super.key,
    required this.name,
    required this.birthday,
    required this.info,
    required this.musicGroups,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(name, style: textTheme.headlineMedium),
        const SizedBox(height: 2),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Geboren: $birthday', style: textTheme.titleSmall),
            SizedBox(
              width: 140,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Info:',
                    style: textTheme.displayMedium,
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    info,
                    style: textTheme.titleSmall,
                    textAlign: TextAlign.right,
                    softWrap: true,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Musikgruppen:',
                    style: textTheme.displayMedium,
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    musicGroups.join(', '),
                    style: textTheme.titleSmall,
                    textAlign: TextAlign.right,
                    softWrap: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
