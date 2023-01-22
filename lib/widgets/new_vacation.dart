import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewVacation extends StatefulWidget {
  final Function addVacation;

  NewVacation(this.addVacation);

  @override
  State<NewVacation> createState() => _NewVacationState();
}

class _NewVacationState extends State<NewVacation> {
  final _reasonController = TextEditingController();
  TextEditingController _selectedStartDate = TextEditingController();
  TextEditingController _selectedEndDate = TextEditingController();

  void _submitData() {
    final enteredReason = _reasonController.text;
    final enteredstartdate = _selectedStartDate.text;
    final enteredenddate = _selectedEndDate.text;

    if (enteredReason.isEmpty ||
        _selectedStartDate == null ||
        _selectedEndDate == null) {
      return;
    }

    widget.addVacation(
      enteredReason,
      enteredstartdate,
      enteredenddate,
    );

    // Navigator.of(context).pop();
  }

  void _presentStartDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    ).then((pickedstartDate) {
      if (pickedstartDate == null) {
        return;
      } else {
        String _formattedStartDate =
            DateFormat('dd-MM-yyyy').format(pickedstartDate);
        print(_formattedStartDate);

        setState(() {
          _selectedStartDate.text = _formattedStartDate;
        });
      }
    });
  }

  void _presentEndDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    ).then((pickedendDate) {
      if (pickedendDate == null) {
        return;
      } else {
        String _formattedEndDate =
            DateFormat('dd-MM-yyyy').format(pickedendDate);
        print(_formattedEndDate);

        setState(() {
          _selectedEndDate.text = _formattedEndDate;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Start date',
          style: TextStyle(color: Color.fromRGBO(54, 115, 111, 1)),
        ),
        SizedBox(
          height: 10,
        ),
        TextField(
          controller: _selectedStartDate,
          decoration: InputDecoration(
            labelText: 'DD/MM/YYYY',
            border: OutlineInputBorder(),
            suffixIcon: Icon(
              Icons.calendar_month,
              color: Color.fromRGBO(81, 157, 153, 1),
            ),
          ),
          onTap: _presentStartDatePicker,
          // onSubmitted: (_) => _submitData,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          'End date',
          style: TextStyle(
            color: Color.fromRGBO(54, 115, 111, 1),
          ),
        ),
        TextField(
          controller: _selectedEndDate,
          decoration: InputDecoration(
            labelText: 'DD/MM/YYYY',
            border: OutlineInputBorder(),
            suffixIcon: Icon(
              Icons.calendar_month,
              color: Color.fromRGBO(81, 157, 153, 1),
            ),
          ),
          onTap: _presentEndDatePicker,
          // onSubmitted: (_) => _submitData,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          'Reason',
          style: TextStyle(
            color: Color.fromRGBO(54, 115, 111, 1),
          ),
        ),
        Container(
          height: 150,
          child: TextField(
            maxLength: 250,
            expands: true,
            maxLines: null,
            controller: _reasonController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: null,
            ),
            // onSubmitted: (_) => _submitData,
          ),
        ),
        // ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: _submitData,
              child: Text('Submit'),
              style: TextButton.styleFrom(
                  backgroundColor: Color.fromRGBO(81, 157, 153, 1)),
            ),
            TextButton(
              onPressed: () {},
              child: Text('See all...'),
              style: TextButton.styleFrom(
                  foregroundColor: Color.fromRGBO(81, 157, 153, 1)),
            ),
          ],
        ),
      ],
    );
  }
}
