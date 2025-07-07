import 'package:flutter/material.dart';
import 'package:calendar_view/calendar_view.dart';
import '../services/api_service.dart';
import '../services/secure_auth_service.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  final ApiService _api = ApiService();
  final SecureAuthService _auth = SecureAuthService();
  List<CalendarEventData> _events = [];

  @override
  void initState() {
    super.initState();
    _loadEvents();
  }

  Future<void> _loadEvents() async {
    final token = await _auth.getToken();
    if (token == null) return;
    final data = await _api.getEvents(token);
    setState(() {
      _events = data.map((e) {
        final start = DateTime.parse(e['start_at']);
        final end = DateTime.parse(e['end_at'] ?? e['start_at']);
        return CalendarEventData(
          title: e['title'],
          description: e['description'],
          date: start,
          endDate: end,
        );
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Events')),
      body: MonthView(events: _events),
    );
  }
}
