import Flutter
import UIKit
import CoreBluetooth

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterStreamHandler, CBCentralManagerDelegate {
    private var centralManager: CBCentralManager?  = nil
    private var bluetoothEventSink: FlutterEventSink? = nil
    private var controller: FlutterViewController? = nil

    override func application(
        _ application:UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

        centralManager = CBCentralManager(delegate: self, queue: nil)

        guard let controller = window?.rootViewController as? FlutterViewController else {
            fatalError("rootViewController is not a FlutterViewController")
        }
        self.controller = controller

        let bluetoothChannel = FlutterMethodChannel(name: "by.radio.online.radio_online/bluetooth",
                                                  binaryMessenger: controller.binaryMessenger)

        bluetoothChannel.setMethodCallHandler { [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
                guard let self = self else { return }

                switch call.method {
                case "getBluetoothState":
                    result(self.isBluetoothEnabled())
                case "enableBluetooth":
                    self.enableBluetooth(result: result)
                case "disableBluetooth":
                     self.disableBluetooth(result: result)
                default:
                    result(FlutterMethodNotImplemented)
                }
            }

        let bluetoothStateChannel = FlutterEventChannel(name: "by.radio.online.radio_online.flutter.dev/bluetooth/state",
                                                       binaryMessenger: controller.binaryMessenger)
        bluetoothStateChannel.setStreamHandler(self)

        GeneratedPluginRegistrant.register(with: self)
                return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    private func isBluetoothEnabled() -> Bool {
            if let central = centralManager {
                return central.state == .poweredOn
            } else {
                return false
            }
        }

        private func enableBluetooth(result: @escaping FlutterResult) {
            guard let central = centralManager else {
                result(false)
                return
            }
            if central.state != .poweredOn {
                let alert = UIAlertController(title: "Bluetooth is Off", message: "Please enable Bluetooth in Settings.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                window?.rootViewController?.present(alert, animated: true, completion: nil)
            }
            result(nil)
        }

        private func disableBluetooth(result: @escaping FlutterResult) {
            guard let central = centralManager else {
                result(false)
                return
            }
            if central.state == .poweredOn {
                let alert = UIAlertController(title: "Bluetooth is On", message: "Please disable Bluetooth in Settings.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                window?.rootViewController?.present(alert, animated: true, completion: nil)
            }
            result(nil)
        }

    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        bluetoothEventSink = events
        bluetoothEventSink?(isBluetoothEnabled())
        return nil
    }

    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        bluetoothEventSink = nil
        return nil
    }

    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        bluetoothEventSink?(isBluetoothEnabled())
    }
}