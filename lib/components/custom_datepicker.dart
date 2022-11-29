// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDatePicker extends StatelessWidget {
  Function? validation;
  Function? onSave;
  TextEditingController? dateInput;

  CustomDatePicker({Key? key, this.validation, this.dateInput, this.onSave})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (dateInput == null) {
      return TextFormField(
        validator: (v) {
          return validation == null ? null : validation!(v);
        },
        onSaved: (v) {
          if (onSave == null) {
            return null;
          } else {
            return onSave!(v);
          }
        },
        decoration: const InputDecoration(
            icon: Icon(Icons.calendar_today), //icon of text field
            labelText: "Enter Date" //label text of field
            ),
        readOnly: true,
        //set it true, so that user will not able to edit text
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1950),
              //DateTime.now() - not to allow to choose before today.
              lastDate: DateTime(2200));

          if (pickedDate != null) {
            String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
            onSave!(formattedDate);
          } else {}
        },
      );
    }

    return TextFormField(
      validator: (v) {
        return validation == null ? null : validation!(v);
      },
      controller: dateInput,
      decoration: const InputDecoration(
          icon: Icon(Icons.calendar_today), //icon of text field
          labelText: "Enter Date" //label text of field
          ),
      readOnly: true,
      //set it true, so that user will not able to edit text
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1950),
            //DateTime.now() - not to allow to choose before today.
            lastDate: DateTime(2200));

        if (pickedDate != null) {
          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
          dateInput!.text = formattedDate;
        } else {}
      },
    );
  }
}
