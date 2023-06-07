import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:planar_fluteer_version/providers/vacation.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';

class NewVacation extends StatefulWidget {
  // final Function addVacation;

  // NewVacation(this.addVacation);

  @override
  State<NewVacation> createState() => _NewVacationState();
}

class _NewVacationState extends State<NewVacation> {
  final _reasonController = TextEditingController();
  final _form = GlobalKey<FormState>();
  var _isInit = true;
  var _isLoading = false;
  TextEditingController _selectedStartDate = TextEditingController();
  TextEditingController _selectedEndDate = TextEditingController();
  TextEditingController _selectedReason = TextEditingController();
  var _editedVacation = Vacation(
    vac_id: null,
    reason: '',
    startdate: '',
    enddate: '',
  );
  var _initValues = {
    'id': '',
    'reason': '',
    'startdate': '',
    'enddate': '',
  };

  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });
    _isLoading = true;
    final authData = Provider.of<Auth>(context, listen: false);
    Provider.of<Vacations>(context, listen: false)
        .fetchAndSetVacations(authData.user_id)
        .then((_) {
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final vacationId = ModalRoute.of(context).settings.arguments as String;
      if (vacationId != null) {
        _editedVacation =
            Provider.of<Vacations>(context, listen: false).findById(vacationId);
        // _initValues = {
        //   // 'reason': _editedVacation.reason,
        //   // 'startdate': _editedVacation.startdate,
        //   // 'enddate': _editedVacation.enddate,
        // };
        _selectedStartDate.text = _editedVacation.startdate;
        _selectedEndDate.text = _editedVacation.enddate;
        _selectedReason.text = _editedVacation.reason;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  void _saveform() {
    final isValid = _form.currentState.validate();

    if (!isValid) {
      return;
    }
    _form.currentState.save();
    setState(() {
      _isLoading = true;
    });
    if (_editedVacation.vac_id != null) {
      Provider.of<Vacations>(context, listen: false)
          .updateProduct(_editedVacation.vac_id, _editedVacation);
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pop();
    } else {
      final authData = Provider.of<Auth>(context, listen: false);
      Provider.of<Vacations>(context, listen: false)
          .addVacation(_editedVacation, authData.token);
      setState(() {
        _isLoading = false;
      });
      _selectedStartDate.clear();
      _selectedEndDate.clear();
      _selectedReason.clear();
      // Navigator.of(context).pop();
    }
  }

  void _showall() {
    final authData = Provider.of<Auth>(context, listen: false);
    Provider.of<Vacations>(context, listen: false)
        .fetchAndSetVacations(authData.token);
  }

  // void _submitData() {
  //   final enteredReason = _reasonController.text;
  //   final enteredstartdate = _selectedStartDate.text;
  //   final enteredenddate = _selectedEndDate.text;

  //   if (enteredReason.isEmpty ||
  //       _selectedStartDate == null ||
  //       _selectedEndDate == null) {
  //     return;
  //   }

  //   widget.addVacation(
  //     enteredReason,
  //     enteredstartdate,
  //     enteredenddate,
  //   );

  //   // Navigator.of(context).pop();
  // }

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
    return Form(
      key: _form,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Start date',
            style: TextStyle(color: Colors.cyan[800]),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            // initialValue: _initValues['startdate'],
            decoration: InputDecoration(
              labelText: 'DD/MM/YYYY',
              border: OutlineInputBorder(),
              suffixIcon: Icon(Icons.calendar_month, color: Colors.cyan[800]),
            ),
            onTap: _presentStartDatePicker,
            controller: _selectedStartDate,
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value.isEmpty) {
                return 'Please provide a date';
              }
              return null;
            },
            onSaved: (value) {
              _editedVacation = Vacation(
                reason: _editedVacation.reason,
                startdate: value,
                enddate: _editedVacation.enddate,
                vac_id: _editedVacation.vac_id,
              );
            },
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'End date',
            style: TextStyle(
              color: Colors.cyan[800],
            ),
          ),
          TextFormField(
            controller: _selectedEndDate,
            // initialValue: _initValues['enddate'],
            decoration: InputDecoration(
              labelText: 'DD/MM/YYYY',
              border: OutlineInputBorder(),
              suffixIcon: Icon(Icons.calendar_month, color: Colors.cyan[800]),
            ),
            textInputAction: TextInputAction.next,
            onEditingComplete: () {
              setState(() {});
            },
            validator: (value) {
              if (value.isEmpty) {
                return 'Please provide a date';
              }
              return null;
            },
            onTap: _presentEndDatePicker,
            onSaved: (value) {
              _editedVacation = Vacation(
                reason: _editedVacation.reason,
                startdate: _editedVacation.startdate,
                enddate: value,
                vac_id: _editedVacation.vac_id,
              );
            },
          ),

          // TextField(
          //   controller: _selectedEndDate,
          //   decoration: InputDecoration(
          //     labelText: 'DD/MM/YYYY',
          //     border: OutlineInputBorder(),
          //     suffixIcon: Icon(Icons.calendar_month, color: Colors.cyan[800]),
          //   ),
          //   onTap: _presentEndDatePicker,
          //   // onSubmitted: (_) => _submitData,
          // ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Reason',
            style: TextStyle(
              color: Colors.cyan[800],
            ),
          ),
          TextFormField(
            // initialValue: _initValues['description'],
            decoration: InputDecoration(
              labelText: 'Description',
              border: OutlineInputBorder(),
            ),
            controller: _selectedReason,
            maxLines: 3,
            keyboardType: TextInputType.multiline,
            // focusNode: _priceFocusNode,
            validator: (value) {
              if (value.isEmpty) {
                return "Please enter a description";
              }
              if (value.length < 10) {
                return "Should be at least 10 characters long";
              }
              return null;
            },
            // onFieldSubmitted: (_) {
            //   _saveform();
            // },
            onSaved: (value) {
              _editedVacation = Vacation(
                reason: value,
                startdate: _editedVacation.startdate,
                enddate: _editedVacation.enddate,
                vac_id: _editedVacation.vac_id,
              );
            },
          ),

          // Container(
          //   height: 150,
          //   child: TextField(
          //     maxLength: 250,
          //     expands: true,
          //     maxLines: null,
          //     controller: _reasonController,
          //     decoration: InputDecoration(
          //       border: OutlineInputBorder(),
          //       contentPadding: null,
          //     ),
          //     // onSubmitted: (_) => _submitData,
          //   ),
          // ),
          // ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: _saveform,
                child: Text('Submit'),
                style: TextButton.styleFrom(backgroundColor: Colors.cyan[800]),
              ),
              TextButton(
                onPressed: _showall,
                child: Text('See all...'),
                style: TextButton.styleFrom(foregroundColor: Colors.cyan[800]),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
