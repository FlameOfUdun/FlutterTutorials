import 'package:flutter/material.dart';

import '../models/participant.dart';
import '../services/participants_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stream Builder Tutorial'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            _ParticipantViewer(),
            SizedBox(height: 16),
            _ControlButtons(),
          ],
        ),
      ),
    );
  }
}

class _ControlButtons extends StatelessWidget {
  const _ControlButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () async {
            try {
              await ParticipantsService.instance.broadcast();
            } catch (error) {
              SnackBar snackBar = SnackBar(content: Text(error.toString()));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          },
          child: const Text('Broadcast'),
        ),
        const SizedBox(width: 16),
        ElevatedButton(
          onPressed: () {
            try {
              ParticipantsService.instance.dispose();
            } catch (error) {
              SnackBar snackBar = SnackBar(content: Text(error.toString()));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          },
          child: const Text('Dispose'),
        ),
      ],
    );
  }
}

class _ParticipantViewer extends StatelessWidget {
  const _ParticipantViewer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Participant>(
      stream: ParticipantsService.instance.participantsStream,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return const Text('No stream is attached');
          case ConnectionState.waiting:
            return const Text('Stream is active but no data is received yet');
          case ConnectionState.active:
            return _StreamSnapshotViewer(snapshot: snapshot);
          case ConnectionState.done:
            return const Text('Stream is finished and no data will be received');
        }
      },
    );
  }
}

class _StreamSnapshotViewer extends StatelessWidget {
  final AsyncSnapshot<Participant> snapshot;

  const _StreamSnapshotViewer({
    Key? key,
    required this.snapshot,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (snapshot.hasError) {
      Object error = snapshot.error!;
      return Text(error.toString());
    }

    Participant participant = snapshot.data!;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(participant.name),
        Text(participant.email),
      ],
    );
  }
}
