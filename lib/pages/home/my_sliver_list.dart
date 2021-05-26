// import 'package:flutter/material.dart';
// import 'package:upg_calculator/models/school.dart';

// import '../list_item.dart';

// class MySliverListWrapper extends StatefulWidget {
//   const MySliverListWrapper({
//     Key key,
//   }) : super(key: key);

//   @override
//   MySliverListWrapperState createState() => MySliverListWrapperState();
// }

// class MySliverListWrapperState extends State<MySliverListWrapper> {
//   @override
//   Widget build(BuildContext context) {
// for (School school in Schools.list) school.shownAlready = false;

//     return MySliverList1(
//       key: UniqueKey(),
//     );
//   }
// }

// class MySliverList1 extends StatelessWidget {
//   const MySliverList1({
//     Key key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SliverAnimatedList(
//       initialItemCount: Schools.list.length,
//       itemBuilder: (context, index, animation) {
//         School school = Schools.list[index];
//         return ListItem(school: school, wait: 400 * index);
//       },
//     );
//   }
// }
