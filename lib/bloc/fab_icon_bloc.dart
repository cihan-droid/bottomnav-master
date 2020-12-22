import 'dart:async';

class FabIkonBloc {
  StreamController<bool> _fabIkonStreamController =
      StreamController<bool>.broadcast();
  Sink<bool> get fabIkonEkleSinki => _fabIkonStreamController.sink;
  Stream<bool> get fabIkonStream => _fabIkonStreamController.stream;

  FabIkonBloc();

  void dispose() {
    _fabIkonStreamController.close();
  }
}
