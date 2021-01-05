import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePick extends StatelessWidget {
  final idDate;
  final text;

  DatePick(
      this.idDate,
      this.text
      );

  final format = DateFormat("yyyy-MM-dd HH:mm.sss");
  final newformat = DateFormat("yyyy-MM-dd HH:mm.sss");

  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();

    return Column(
      children: [
        DateTimeField(
          format: format,
          initialValue:now,
          onShowPicker: (context,currentValue) async{
            final date = await showDatePicker(
                context: context,
                firstDate: DateTime(1900),
                initialDate: currentValue ?? DateTime.now(),
                lastDate: DateTime(2100));

            if (date != null) {
              final time = await showTimePicker(
                context: context,
                initialTime:
                TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
              );
              return DateTimeField.combine(date, time);
            } else {
              return currentValue;
            }
          },
          controller: this.idDate,
          decoration: InputDecoration(
            hintText: text,
            icon: Icon(
              Icons.date_range,
              color: Colors.grey,
              size: 22.0,
            ),
            errorStyle: TextStyle(
              color: Colors.red,
            ),
            labelStyle:
            TextStyle(color: Color.fromRGBO(0, 109, 197, 1)),
            hintStyle: TextStyle(color: Colors.grey),
            contentPadding: EdgeInsets.all(15.0), // Inside box padding
          ),
          onSaved: (value){
          },
          onChanged: (v){
            print(v.toString());
          },
          validator: (value){
            if(value == null || value.isBefore(DateTime.now())){
              return "Insira uma data válida.";
            }
            else{
              return null;
            }
          },
        )
      ],
    );
  }
}