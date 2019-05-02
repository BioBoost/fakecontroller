import 'package:bug_mobile_controller/bug/simple_mqtt_client.dart';
import 'package:bug_mobile_controller/bug/user.dart';

class LoginArguments {
  LoginArguments(this.user, this.mqttClient);

  User user;
  SimpleMqttClient mqttClient;
}