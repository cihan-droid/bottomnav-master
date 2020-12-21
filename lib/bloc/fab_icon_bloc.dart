import 'dart:async';

class FabIkonBloc {
  StreamController<bool> fabIkonStreamController =
      StreamController<bool>.broadcast();
  Sink<bool> get fabIkonEkleSinki => fabIkonStreamController.sink;
  Stream<bool> get fabIkonStream => fabIkonStreamController.stream;

  void dispose() {
    fabIkonStreamController.close();
  }
}
