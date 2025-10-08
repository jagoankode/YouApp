import 'dart:async';

class RabbitMQService {
  static bool _isConnected = false;
  static final StreamController<String> _streamController = StreamController<String>.broadcast();
  
  static Future<void> connect() async {
    // Simulate RabbitMQ connection
    _isConnected = true;
    print('Connected to RabbitMQ (Mock)');
  }
  
  static Future<void> disconnect() async {
    _isConnected = false;
    _streamController.close();
    print('Disconnected from RabbitMQ (Mock)');
  }
  
  static Future<void> sendMessage(String message) async {
    if (!_isConnected) {
      print('RabbitMQ not connected');
      return;
    }
    
    try {
      // In a real implementation, this would publish to RabbitMQ
      // For now, we're just simulating the publish
      print('Message sent to RabbitMQ: $message');
      
      // Simulate broadcasting to other users
      _streamController.sink.add(message);
    } catch (e) {
      print('Failed to send message: $e');
    }
  }
  
  static Stream<String> listenToMessages() {
    if (!_isConnected) {
      print('RabbitMQ not connected');
      return const Stream.empty();
    }
    
    print('Listening for RabbitMQ messages (Mock)');
    return _streamController.stream;
  }
}