package by.radio.online.radio_online

import com.ryanheise.audioservice.AudioServiceActivity
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.embedding.engine.FlutterEngine


class MainActivity : AudioServiceActivity() {

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        BluetoothManager(this).setUp(flutterEngine)
    }
}