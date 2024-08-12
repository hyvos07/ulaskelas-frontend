part of '_widgets.dart';

// TargetScoreDropdown(
//   nilaiHarapanList: _nilaiHarapanList,
//   voidWhenHasntReacedhMax: () {
//     if (!componentRM.state.hasReachedMax) {
//       ErrorMessenger(
//         'Total bobot harus mencapai 100%',
//       ).show(context);
//     }
//   },
//   voidWhenReachedMax: componentRM.state.hasReachedMax
//     ? (String? newValue) {
//         componentRM.state.setTarget(
//           int.parse(newValue!)
//         );
//         retrieveData();
//       }
//     : null,
//   hasReachedMax: componentRM.state.hasReachedMax, 
//   target: componentRM.state.target, 
//   maxPossibleScore: componentRM.state.maxPossibleScore
// )

// class TargetScoreDropdown extends StatelessWidget {
//   const TargetScoreDropdown({
//     required this.voidWhenHasntReacedhMax,
//     required this.nilaiHarapanList, 
//     required this.hasReachedMax,
//     required this.maxPossibleScore, 
//     this.target,
//     this.voidWhenReachedMax,
//     super.key
//   });
//   final void Function(String?)? voidWhenReachedMax;
//   final VoidCallback voidWhenHasntReacedhMax;
//   final List<String> nilaiHarapanList;
//   final bool hasReachedMax;
//   final int? target;
//   final double maxPossibleScore;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       // nanti pisahin jadi state terpisah
//       padding: const EdgeInsets.symmetric(
//         horizontal: 1.75,
//         vertical: 1.75,
//       ),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topCenter,
//           end: Alignment.bottomCenter,
//           colors: hasReachedMax
//               ? BaseColors.autoSystemColor
//               : [
//                   BaseColors.gray1.withOpacity(0.3),
//                   BaseColors.gray1.withOpacity(0.3)
//                 ],
//         ),
//         borderRadius: BorderRadius.circular(6.5),
//       ),
//       child: Container(
//         height: 27,
//         padding: const EdgeInsets.only(
//           left: 7.5,
//         ),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(4.5),
//         ),
//         child: GestureDetector(
//           onTap: voidWhenHasntReacedhMax,
//           child: DropdownButtonHideUnderline(
//             child: DropdownButton<String>(
//               borderRadius: BorderRadius.circular(10),
//               value: target
//                 .toString(),
//               onChanged: voidWhenReachedMax,
//               selectedItemBuilder:
//                   (BuildContext context) {
//                 return nilaiHarapanList
//                     .map<Widget>((String value) {
//                   return Center(
//                     child: GradientText(
//                       _getFinalScoreAndGrade(
//                         double.parse(value)),
//                       gradient: LinearGradient(
//                         begin: Alignment.topCenter,
//                         end: Alignment.bottomCenter,
//                         colors: hasReachedMax
//                             ? BaseColors.autoSystemColor
//                             : [
//                                 BaseColors.gray1
//                                     .withOpacity(0.3),
//                                 BaseColors.gray1
//                                     .withOpacity(0.3)
//                               ],
//                       ),
//                       style: FontTheme
//                           .poppins14w500black(),
//                     ),
//                   );
//                 }).toList();
//               },
//               items:
//                   nilaiHarapanList.map((String value) {
//                 return DropdownMenuItem<String>(
//                   enabled: 
//                     maxPossibleScore
//                       > double.parse(value),
//                   value: value,
//                   child: Center(
//                     child: Container(
//                       padding:
//                           const EdgeInsets.symmetric(
//                         horizontal: 7.5,
//                         vertical: 2.5,
//                       ),
//                       decoration: BoxDecoration(
//                         color: target
//                                     .toString() == value
//                             ? BaseColors.mineShaft
//                                 .withOpacity(0.125)
//                             : Colors.transparent,
//                         borderRadius:
//                             BorderRadius.circular(4),
//                       ),
//                       // ignore: lines_longer_than_80_chars
//                       child: Text(
//                         _getFinalScoreAndGrade(
//                           double.parse(value),),
//                         style: FontTheme
//                                 .poppins14w500black()
//                             .copyWith(
//                           fontSize: 13.5,
//                           color: BaseColors.mineShaft
//                               .withOpacity(
//                                 maxPossibleScore
//                                   > double.parse(value)
//                                 ? 0.85
//                                 : 0.25
//                               ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               }).toList(),
//               icon: ShaderMask(
//                 shaderCallback: (Rect bounds) {
//                   return LinearGradient(
//                     begin: Alignment.topCenter,
//                     end: Alignment.bottomCenter,
//                     colors:
//                         hasReachedMax
//                             ? BaseColors.autoSystemColor
//                             : [
//                                 BaseColors.gray1
//                                     .withOpacity(0.3),
//                                 BaseColors.gray1
//                                     .withOpacity(0.3)
//                               ],
//                   ).createShader(bounds);
//                 },
//                 child: const Icon(
//                   Icons.arrow_drop_down_rounded,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   String _getFinalScoreAndGrade(double score) {
//     var grade = 'E';
//     if (score >= 85) {
//       grade = 'A';
//     } else if (score >= 80) {
//       grade = 'A-';
//     } else if (score >= 75) {
//       grade = 'B+';
//     } else if (score >= 70) {
//       grade = 'B';
//     } else if (score >= 65) {
//       grade = 'B-';
//     } else if (score >= 60) {
//       grade = 'C+';
//     } else if (score >= 55) {
//       grade = 'C';
//     } else if (score >= 40) {
//       grade = 'D';
//     }

//     return '$grade (${score.toStringAsFixed(2)})';
//   }
// }