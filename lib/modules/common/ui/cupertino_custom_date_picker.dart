import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';
import '../utils/palette.dart';
import '../utils/utils.dart';

class CupertinoDatePickerView extends StatefulWidget {
  CupertinoDatePickerView(
      {Key? key, required this.cupertinoDatePickervalue, required this.onDone})
      : super(key: key);

  final DateTime? cupertinoDatePickervalue;
  Function(DateTime) onDone;

  @override
  State<CupertinoDatePickerView> createState() =>
      _CupertinoDatePickerViewState();
}

class _CupertinoDatePickerViewState extends State<CupertinoDatePickerView> {
  DateTime selectDate = DateTime.now();

  DateTime minimumDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              _showDatePicker(context);
            },
            child: Column(
              children: [
                Container(
                  height: 63,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                      ),
                      color: Colors.transparent),
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Container(
                    height: 55,
                    decoration: BoxDecoration(
                      color: Palette.current.primaryWhiteSmoke,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Text(
                                widget.cupertinoDatePickervalue == null
                                    ? S.of(context).date_purchased
                                    : formatDate(widget.cupertinoDatePickervalue
                                        .toString()),
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                              )),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Image.asset(
                                  'assets/images/Calendar.png',
                                  scale: 3.0,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _showDatePicker(ctx) {
    showCupertinoModalPopup(
        context: ctx,
        builder: (_) => Container(
              height: 500,
              color: const Color.fromARGB(255, 255, 255, 255),
              child: Column(
                children: [
                  Container(
                    color: Colors.grey.shade200,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CupertinoButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 5.0,
                          ),
                          child: const Text('Cancel'),
                        ),
                        CupertinoButton(
                          onPressed: () {
                            widget.onDone(selectDate);
                          },
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 5.0,
                          ),
                          child: const Text('Confirm'),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 400,
                    child: CupertinoDatePicker(
                        minimumDate: minimumDate,
                        mode: CupertinoDatePickerMode.date,
                        initialDateTime: widget.cupertinoDatePickervalue,
                        onDateTimeChanged: (val) {
                          setState(() {
                            selectDate = val;
                          });
                        }),
                  ),
                ],
              ),
            ));
  }
}
