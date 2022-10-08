import 'dart:async';

import '../constants/participants.dart';
import '../models/participant.dart';

class ParticipantsService {
  static final ParticipantsService instance = ParticipantsService._();

  final StreamController<Participant> _streamController = StreamController.broadcast();

  bool _broadcasting = false;

  ParticipantsService._();

  Stream<Participant>? get participantsStream => _streamController.stream;

  Future<void> broadcast() async {
    if (_broadcasting) throw Exception('Service is broadcasting');

    _broadcasting = true;

    for (Participant participant in participants) {
      await Future.delayed(const Duration(seconds: 1));
      _streamController.add(participant);
    }

    _broadcasting = false;
  }

  void dispose() {
    if (_broadcasting) throw Exception('Service is broadcasting');

    _streamController.close();
  }
}
