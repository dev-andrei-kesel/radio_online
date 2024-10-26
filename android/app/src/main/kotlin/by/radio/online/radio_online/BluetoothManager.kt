package by.radio.online.radio_online

import android.annotation.SuppressLint
import android.bluetooth.BluetoothAdapter
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.os.Build
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.EventChannel


class BluetoothManager(private val context: Context) {

    private val channel = "by.radio.online.radio_online/bluetooth"
    private val bluetoothStateChannel = "by.radio.online.radio_online.flutter.dev/bluetooth/state"
    private var bluetoothStateReceiver: BroadcastReceiver? = null
    private var bluetoothStateSink: EventChannel.EventSink? = null

    fun setUp(flutterEngine: FlutterEngine) {
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channel)
            .setMethodCallHandler { call, result ->
                if (call.method == "getBluetoothState") {
                    result.success(isBluetoothEnabled())
                } else {
                    result.notImplemented()
                }
            }

        EventChannel(flutterEngine.dartExecutor.binaryMessenger, bluetoothStateChannel)
            .setStreamHandler(
                object : EventChannel.StreamHandler {
                    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                        bluetoothStateSink = events
                        registerBluetoothStateListener()
                    }

                    override fun onCancel(arguments: Any?) {
                        bluetoothStateSink = null
                        unregisterBluetoothStateListener()
                    }
                })
    }

    private fun registerBluetoothStateListener() {
        bluetoothStateReceiver = object : BroadcastReceiver() {
            override fun onReceive(context: Context, intent: Intent) {
                val action = intent.action
                if (action == BluetoothAdapter.ACTION_STATE_CHANGED) {
                    val state = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.ECLAIR) {
                        intent.getIntExtra(BluetoothAdapter.EXTRA_STATE, BluetoothAdapter.ERROR)
                    } else {
                        null
                    }
                    val isEnabled = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.ECLAIR) {
                        state == BluetoothAdapter.STATE_ON
                    } else {
                        null
                    }
                    bluetoothStateSink?.success(isEnabled)
                }
            }
        }

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.ECLAIR) {
            context.registerReceiver(
                bluetoothStateReceiver,
                IntentFilter(BluetoothAdapter.ACTION_STATE_CHANGED)
            )
        }
    }

    private fun unregisterBluetoothStateListener() {
        bluetoothStateReceiver?.let { context.unregisterReceiver(it) }
        bluetoothStateReceiver = null
    }

    @SuppressLint("MissingPermission")
    private fun isBluetoothEnabled(): Boolean {
        val bluetoothAdapter = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.ECLAIR) {
            BluetoothAdapter.getDefaultAdapter()
        } else {
            null
        }
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.ECLAIR) {
            bluetoothAdapter?.isEnabled == true
        } else {
            false
        }
    }
}