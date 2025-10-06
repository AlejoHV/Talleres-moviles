import 'dart:async';
import 'package:flutter/material.dart';

import '../../widgets/base_view.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  Timer? _timer;
  Duration _elapsed = Duration.zero;
  bool _isRunning = false;

  void _start() {
    if (_isRunning) return;
    setState(() => _isRunning = true);
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        _elapsed += const Duration(milliseconds: 100);
      });
    });
  }

  void _pause() {
    if (!_isRunning) return;
    _timer?.cancel();
    setState(() => _isRunning = false);
  }

  void _resume() {
    if (_isRunning) return;
    setState(() => _isRunning = true);
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        _elapsed += const Duration(milliseconds: 100);
      });
    });
  }

  void _reset() {
    _timer?.cancel();
    setState(() {
      _elapsed = Duration.zero;
      _isRunning = false;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _format(Duration d) {
    final ms = (d.inMilliseconds % 1000) ~/ 100;
    final s = d.inSeconds % 60;
    final m = d.inMinutes % 60;
    final h = d.inHours;
    return [
      if (h > 0) h.toString().padLeft(2, '0'),
      m.toString().padLeft(2, '0'),
      s.toString().padLeft(2, '0'),
      ms.toString(),
    ].join(':');
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      title: 'Cronómetro',
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image(
              image: const NetworkImage(
                'https://media.suara.com/pictures/653x366/2023/10/10/10057-ilustrasi-bendera-pixabayandy-h.jpg',
              ),
              width: 300,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: Text(
              _format(_elapsed),
              style: const TextStyle(
                fontSize: 56,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: _isRunning ? null : _start,
                icon: const Icon(Icons.play_arrow),
                label: const Text('Iniciar'),
              ),
              const SizedBox(width: 16),
              ElevatedButton.icon(
                onPressed: _isRunning ? _pause : null,
                icon: const Icon(Icons.pause),
                label: const Text('Pausar'),
              ),
              const SizedBox(width: 16),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: (!_isRunning && _elapsed > Duration.zero)
                    ? _resume
                    : null,
                icon: const Icon(Icons.play_circle),
                label: const Text('Reanudar'),
              ),
              const SizedBox(width: 16),
              ElevatedButton.icon(
                onPressed: _elapsed > Duration.zero ? _reset : null,
                icon: const Icon(Icons.restart_alt),
                label: const Text('Reiniciar'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
