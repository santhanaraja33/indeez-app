import 'package:flutter/material.dart';

class EventListModel {
  String? eventTitle;
  String? time;
  String? eventName;
  String? address;
  String? thisEvent;
  Color? eventColor;

  EventListModel({
    this.address,
    this.eventColor,
    this.eventName,
    this.eventTitle,
    this.thisEvent,
    this.time,
  });
}
