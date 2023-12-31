import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';
import '../../models/detail/sale_history_model.dart';
import '../utils/palette.dart';

extension on Priority {
  int compareTo(Priority other) => index.compareTo(other.index);
}

class CustomDataTable extends StatefulWidget {
  CustomDataTable({super.key, required this.histories});

  final List<SalesHistoryModel>? histories;

  @override
  State<CustomDataTable> createState() => _CustomDataTableState();
}

class _CustomDataTableState extends State<CustomDataTable> {
  late bool _ascendingDate;
  late bool _ascendingCondition;
  late bool _ascendingPrice;

  var histories = <SalesHistoryModel>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      _ascendingDate = true;
      _ascendingCondition = false;
      _ascendingPrice = false;

      widget.histories?.map((obj) {
        if (obj.condition == "Sealed") {
          obj = obj.copyWith(priority: Priority.first);
        }
        if (obj.condition == "Displayed") {
          obj = obj.copyWith(priority: Priority.second);
        }
        if (obj.condition == "Gamed") {
          obj = obj.copyWith(priority: Priority.third);
        }
        histories.add(obj);
      }).toList();

      histories.sort((a, b) => b.updatedDate.compareTo(a.updatedDate));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: IntrinsicWidth(
            child: Stack(
              children: [
                Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Palette.current.grey, width: 0.5))),
                ),
                DataTable(
                    dividerThickness: 0,
                    columnSpacing: 35,
                    columns: [
                      DataColumn(
                        label: SizedBox(
                          width: 100,
                          child: Row(
                            children: [
                              Text(
                                S.of(context).sale_data,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300,
                                        color: Palette.current.white),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _ascendingCondition = false;
                                    _ascendingPrice = false;
                                    if (_ascendingDate) {
                                      histories.sort((a, b) => a.updatedDate
                                          .compareTo(b.updatedDate));
                                    } else {
                                      histories.sort((a, b) => b.updatedDate
                                          .compareTo(a.updatedDate));
                                    }
                                    if (!_ascendingDate) {
                                      _ascendingDate = true;
                                    } else {
                                      _ascendingDate = false;
                                    }
                                  });
                                },
                                child: Icon(
                                    _ascendingDate
                                        ? Icons.expand_more
                                        : Icons.expand_less,
                                    size: 20),
                              )
                            ],
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Row(
                            children: [
                              Text(
                                S.of(context).condition.toUpperCase(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300,
                                        color: Palette.current.white),
                              ),
                              GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _ascendingDate = false;
                                      _ascendingPrice = false;
                                      if (_ascendingCondition) {
                                        histories.sort((a, b) =>
                                            b.priority.compareTo(a.priority));
                                      } else {
                                        histories.sort((a, b) =>
                                            a.priority.compareTo(b.priority));
                                      }
                                      if (!_ascendingCondition) {
                                        _ascendingCondition = true;
                                      } else {
                                        _ascendingCondition = false;
                                      }
                                    });
                                  },
                                  child: Icon(
                                      _ascendingCondition
                                          ? Icons.expand_more
                                          : Icons.expand_less,
                                      size: 20))
                            ],
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Row(
                            children: [
                              Text(
                                S.of(context).price,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300,
                                        color: Palette.current.white),
                              ),
                              GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _ascendingDate = false;
                                      _ascendingCondition = false;
                                      if (_ascendingPrice) {
                                        histories.sort((a, b) => a
                                            .productItemPrice
                                            .compareTo(b.productItemPrice));
                                      } else {
                                        histories.sort((a, b) => b
                                            .productItemPrice
                                            .compareTo(a.productItemPrice));
                                      }
                                      if (!_ascendingPrice) {
                                        _ascendingPrice = true;
                                      } else {
                                        _ascendingPrice = false;
                                      }
                                    });
                                  },
                                  child: Icon(
                                      _ascendingPrice
                                          ? Icons.expand_more
                                          : Icons.expand_less,
                                      size: 20)),
                            ],
                          ),
                        ),
                      ),
                    ],
                    rows: histories
                        .map((history) => DataRow(cells: [
                              DataCell(Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(history.updatedDate,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                              fontWeight: FontWeight.w300,
                                              color: Palette.current.grey)))),
                              DataCell(Center(
                                child: Text(history.condition,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                            fontWeight: FontWeight.w300,
                                            color: Palette
                                                .current.primaryNeonPink)),
                              )),
                              DataCell(Center(
                                  child: Text("\$${history.productItemPrice}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                              fontWeight: FontWeight.w300,
                                              color: Palette
                                                  .current.primaryNeonGreen)))),
                            ]))
                        .toList()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
