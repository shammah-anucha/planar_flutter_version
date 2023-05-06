import 'package:flutter/material.dart';
import 'package:planar_fluteer_version/providers/events.dart';
import 'package:provider/provider.dart';
import '/providers/event.dart';
import 'package:intl/intl.dart';

class CreateEventScreen extends StatefulWidget {
  static const routeName = '/create-event';

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  final _imageUrlFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  TextEditingController _selectedEventDate = TextEditingController();
  final _form = GlobalKey<FormState>();
  var _editedEvent = Event(
    event_id: null,
    title: '',
    eventdate: '',
    imageUrl: '',
    location: '',
    location_url: '',
    host: '',
    // tags: [],
  );
  var _initValues = {
    'title': '',
    'eventdate': '',
    'time': '',
    'imageUrl': '',
    'location': '',
    'location_url': '',
    'host': '',
    // 'tags': '',
  };
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final eventId = ModalRoute.of(context).settings.arguments as String;
      if (eventId != null) {
        _editedEvent =
            Provider.of<Events>(context, listen: false).findById(eventId);
        _initValues = {
          'title': _editedEvent.title,
          'eventdate': _editedEvent.eventdate,
          'time': _editedEvent.time,
          'location': _editedEvent.location,
          'location_url': _editedEvent.location_url,
          'host': _editedEvent.host,
          // 'tags': '',
          'imageUrl': _editedEvent.imageUrl,
        };
        _imageUrlController.text = _editedEvent.imageUrl;
        _selectedEventDate.text = _editedEvent.eventdate.toString();
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  // Use if using focus node to clear it when moving to another page to prevent memory leak
  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      if ((!_imageUrlController.text.startsWith('http') &&
          !_imageUrlController.text.startsWith('https'))) {
        return;
      }
      setState(() {});
    }
  }

  void _presentEventDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    ).then((pickedEventDate) {
      if (pickedEventDate == null) {
        return;
      } else {
        String _formattedEventDate =
            DateFormat('yyyy-MM-dd').format(pickedEventDate);
        print(_formattedEventDate);

        setState(() {
          _selectedEventDate.text = _formattedEventDate;
        });
      }
    });
  }

  void _saveForm() {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    setState(() {
      _isLoading = true;
    });
    if (_editedEvent.event_id != null) {
      Provider.of<Events>(context, listen: false)
          .updateEvent(_editedEvent.event_id, _editedEvent);
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pop();
    } else {
      Provider.of<Events>(context, listen: false).addEvent(_editedEvent);
      setState(() {
        _isLoading = false;
      });
      //     .catchError((error) {
      //   return showDialog<Null>(
      //     context: context,
      //     builder: (ctx) => AlertDialog(
      //       title: Text('An error occured!'),
      //       content: Text('Something went wrong.'),
      //       actions: [
      //         TextButton(
      //             onPressed: () {
      //               Navigator.of(ctx).pop();
      //             },
      //             child: Text('Okay'))
      //       ],
      //     ),
      //   );
      // }).then((_) {
      //   setState(() {
      //     _isLoading = false;
      //   });
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Create Event'),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: Scaffold(
          body: _isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Form(
                    key: _form,
                    child: SingleChildScrollView(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Event Title',
                          style: TextStyle(color: Colors.cyan[800]),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          initialValue: _initValues['title'],
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          // focusNode: _priceFocusNode,
                          textInputAction: TextInputAction.next,
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
                            _editedEvent = Event(
                              event_id: _editedEvent.event_id,
                              title: value,
                              eventdate: _editedEvent.eventdate,
                              time: _editedEvent.time,
                              imageUrl: _editedEvent.imageUrl,
                              location: _editedEvent.location,
                              location_url: _editedEvent.location_url,
                              host: _editedEvent.host,
                              // tags: _editedEvent.tags,
                            );
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    'Event Time',
                                    style: TextStyle(
                                      color: Colors.cyan[800],
                                    ),
                                  ),
                                  TextFormField(
                                    initialValue: _initValues['time'],
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                    ),
                                    // focusNode: _priceFocusNode,
                                    textInputAction: TextInputAction.next,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return "Please enter a description";
                                      }
                                      // if (value.length < 5) {
                                      //   return "Should be at least 5 characters long";
                                      // }
                                      // return null;
                                    },
                                    // onFieldSubmitted: (_) {
                                    //   _saveform();
                                    // },
                                    onSaved: (value) {
                                      _editedEvent = Event(
                                        event_id: _editedEvent.event_id,
                                        title: _editedEvent.title,
                                        eventdate: _editedEvent.eventdate,
                                        imageUrl: _editedEvent.imageUrl,
                                        time: value,
                                        location: _editedEvent.location,
                                        location_url: _editedEvent.location_url,
                                        host: _editedEvent.host,
                                        // tags: _editedEvent.tags,
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    'Event date',
                                    style: TextStyle(
                                      color: Colors.cyan[800],
                                    ),
                                  ),
                                  TextFormField(
                                    controller: _selectedEventDate,
                                    // initialValue: _initValues['enddate'],
                                    decoration: InputDecoration(
                                      labelText: 'DD/MM/YYYY',
                                      border: OutlineInputBorder(),
                                      suffixIcon: Icon(Icons.calendar_month,
                                          color: Colors.cyan[800]),
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
                                    onTap: _presentEventDatePicker,
                                    onSaved: (value) {
                                      _editedEvent = Event(
                                        event_id: _editedEvent.event_id,
                                        title: _editedEvent.title,
                                        eventdate: value,
                                        time: _editedEvent.time,
                                        imageUrl: _editedEvent.imageUrl,
                                        location: _editedEvent.location,
                                        location_url: _editedEvent.location_url,
                                        host: _editedEvent.host,
                                        // tags: _editedEvent.tags,
                                      );
                                    },
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Text(
                          'Event Location',
                          style: TextStyle(color: Colors.cyan[800]),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          initialValue: _initValues['location'],
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          // focusNode: _priceFocusNode,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Please enter a description";
                            }
                            if (value.length < 5) {
                              return "Should be at least 5 characters long";
                            }
                            return null;
                          },
                          // onFieldSubmitted: (_) {
                          //   _saveform();
                          // },
                          onSaved: (value) {
                            _editedEvent = Event(
                              event_id: _editedEvent.event_id,
                              title: _editedEvent.title,
                              eventdate: _editedEvent.eventdate,
                              time: _editedEvent.time,
                              imageUrl: _editedEvent.imageUrl,
                              location: value,
                              location_url: _editedEvent.location_url,
                              host: _editedEvent.host,
                              // tags: _editedEvent.tags,
                            );
                          },
                        ),
                        Text(
                          'Event Location Address',
                          style: TextStyle(color: Colors.cyan[800]),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          initialValue: _initValues['location_url'],
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          // focusNode: _priceFocusNode,
                          textInputAction: TextInputAction.next,
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
                          keyboardType: TextInputType.url,
                          onSaved: (value) {
                            _editedEvent = Event(
                              event_id: _editedEvent.event_id,
                              title: _editedEvent.title,
                              eventdate: _editedEvent.eventdate,
                              time: _editedEvent.time,
                              imageUrl: _editedEvent.imageUrl,
                              location: _editedEvent.location,
                              location_url: value,
                              host: _editedEvent.host,
                              // tags: _editedEvent.tags,
                            );
                          },
                        ),
                        Text(
                          'Organizer',
                          style: TextStyle(color: Colors.cyan[800]),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          initialValue: _initValues['host'],
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          // focusNode: _priceFocusNode,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Please enter a description";
                            }
                            if (value.length < 5) {
                              return "Should be at least 5 characters long";
                            }
                            return null;
                          },
                          // onFieldSubmitted: (_) {
                          //   _saveform();
                          // },
                          onSaved: (value) {
                            _editedEvent = Event(
                              event_id: _editedEvent.event_id,
                              title: _editedEvent.title,
                              eventdate: _editedEvent.eventdate,
                              time: _editedEvent.time,
                              imageUrl: _editedEvent.imageUrl,
                              location: _editedEvent.location,
                              location_url: _editedEvent.location_url,
                              host: value,
                              // tags: _editedEvent.tags,
                            );
                          },
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              margin: EdgeInsets.only(top: 8, right: 10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: Colors.grey,
                                ),
                              ),
                              child: _imageUrlController.text.isEmpty
                                  ? Text('Enter a URL')
                                  : FittedBox(
                                      child: Image.network(
                                        _imageUrlController.text,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                            ),
                            Expanded(
                              child: TextFormField(
                                // initialValue: _initValues['imageUrl'],
                                decoration:
                                    InputDecoration(labelText: 'Image URL'),
                                keyboardType: TextInputType.url,
                                textInputAction: TextInputAction.done,
                                controller: _imageUrlController,
                                focusNode: _imageUrlFocusNode,
                                onEditingComplete: () {
                                  setState(() {});
                                },
                                onSaved: (value) {
                                  _editedEvent = Event(
                                    event_id: _editedEvent.event_id,
                                    title: _editedEvent.title,
                                    eventdate: _editedEvent.eventdate,
                                    time: _editedEvent.time,
                                    imageUrl: value,
                                    location: _editedEvent.location,
                                    location_url: _editedEvent.location_url,
                                    host: _editedEvent.host,
                                    // tags: _editedEvent.tags,
                                  );
                                },
                                onFieldSubmitted: (_) {
                                  _saveForm();
                                },
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "Please enter an image URL.";
                                  }
                                  if (!value.startsWith('http') &&
                                      !value.startsWith('https')) {
                                    return "Please enter a valid URL.";
                                  }
                                  // pexel pictures don't end wth jpg
                                  // if (!value.endsWith('png') &&
                                  //     !value.endsWith('jpg') &&
                                  //     !value.endsWith('jpeg')) {
                                  //   return "Please enter a valid image URL";
                                  // }
                                  return null;
                                },
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              onPressed: _saveForm,
                              child: Text('Create Event'),
                              style: TextButton.styleFrom(
                                  backgroundColor: Colors.cyan[800]),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Text('See all...'),
                              style: TextButton.styleFrom(
                                  foregroundColor: Colors.cyan[800]),
                            ),
                          ],
                        ),
                      ],
                    )),
                  ),
                ),
        ));
  }
}


  // final String id;
  // final String title;
  // final DateTime eventdate;
  // final String imageUrl;
  // final String location;
  // final String host;
  // final List<String> tags;