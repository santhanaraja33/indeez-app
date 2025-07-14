import 'package:flutter/material.dart';
import 'package:music_app/ui/common/app_colors.dart';
import 'package:music_app/ui/data/bean/model/calender_model.dart';
import 'package:music_app/ui/views/event/model/event_list_model.dart';
import 'package:music_app/ui/views/event/model/event_model.dart';
import 'package:stacked/stacked.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarViewModel extends BaseViewModel {
  int current = 0;
  final eventModel = [
    EventModel(
      today: 'Astrologer',
      time: '8:30PM',
      title: 'Hi-Dive',
      location: '2431 Cass Ave Detroit, MI',
      image:
          'https://indeez.1cczywc7sm4y.us-south.codeengine.appdomain.cloud/homeImgs/Astrologer/Astrologer2.jpg',
    ),
    EventModel(
      today: 'Duz Mancini',
      time: '7PM',
      title: 'Hi-Dive',
      location: '7 S Broadway Denver, CO',
      image:
          'https://indeez.1cczywc7sm4y.us-south.codeengine.appdomain.cloud/homeImgs/Astrologer/Astrologer2.jpg',
    ),
    EventModel(
      today: 'Astrologer',
      time: '8:30PM',
      title: 'Hi-Dive',
      location: '2431 Cass Ave Detroit, MI',
      image:
          'https://indeez.1cczywc7sm4y.us-south.codeengine.appdomain.cloud/homeImgs/Astrologer/Astrologer2.jpg',
    ),
  ];

  final eventListModel = [
    EventListModel(
      thisEvent: 'RSVP for this event',
      time: '8:30 PM',
      eventColor: kcBlue,
      eventName: 'Event name',
      eventTitle: 'Venue',
      address: 'Address',
    ),
    EventListModel(
      thisEvent: 'RSVP for this event',
      time: '8:30 PM',
      eventColor: kcRed,
      eventName: 'Event name',
      eventTitle: 'Venue',
      address: 'Address',
    ),
    EventListModel(
      thisEvent: 'RSVP for this event',
      time: '8:30 PM',
      eventColor: Colors.yellow,
      eventName: 'Event name',
      eventTitle: 'Venue',
      address: 'Address',
    ),
  ];
  late final ValueNotifier<List<Event>> _selectedEvents =
      ValueNotifier<List<Event>>([]);

  CalendarFormat calendarFormat = CalendarFormat.month;
  RangeSelectionMode rangeSelectionMode = RangeSelectionMode
      .toggledOff; // Can be toggled on/off by longpressing a date
  DateTime focusedDays = DateTime.now();
  DateTime? selectedDays;
  DateTime? rangeStarts;
  DateTime? rangeEnds;
  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Event> getEventsForDay(DateTime day) {
    // Implementation example
    return kEvents[day] ?? [];
  }

  List<Event> getEventsForRange(DateTime start, DateTime end) {
    // Implementation example
    final days = daysInRange(start, end);

    return [
      for (final d in days) ...getEventsForDay(d),
    ];
  }

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(selectedDays, selectedDay)) {
      selectedDays = selectedDay;
      focusedDays = focusedDay;
      rangeStarts = null; // Important to clean those
      rangeEnds = null;
      rangeSelectionMode = RangeSelectionMode.toggledOff;

      _selectedEvents.value = getEventsForDay(selectedDay);
      rebuildUi();
    }
  }

  void onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    selectedDays = null;
    focusedDays = focusedDay;
    rangeStarts = start;
    rangeEnds = end;
    rangeSelectionMode = RangeSelectionMode.toggledOn;

    // `start` or `end` could be null
    if (start != null && end != null) {
      _selectedEvents.value = getEventsForRange(start, end);
    } else if (start != null) {
      _selectedEvents.value = getEventsForDay(start);
    } else if (end != null) {
      _selectedEvents.value = getEventsForDay(end);
    }
    rebuildUi();
  }
}
