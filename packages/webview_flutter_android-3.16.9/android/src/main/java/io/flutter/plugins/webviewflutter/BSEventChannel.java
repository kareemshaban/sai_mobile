package io.flutter.plugins.webviewflutter;

import android.util.Log;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.PluginRegistry;

public class BSEventChannel implements EventChannel.StreamHandler {
    public static final String CHANNEL = "baishunChannel";
    public static EventChannel.EventSink bsSink;
    public static EventChannel channel;

    // Register using FlutterPluginBinding
    public static BSEventChannel registerWithPluginBinding(FlutterPlugin.FlutterPluginBinding binding) {
        channel = new EventChannel(binding.getBinaryMessenger(), CHANNEL);
        BSEventChannel instance = new BSEventChannel();
        channel.setStreamHandler(instance);
        return instance;
    }

    // Register using PluginRegistry.Registrar (for older embedding)


    @Override
    public void onListen(Object arguments, EventChannel.EventSink events) {
        // The Flutter app has opened the Event Channel
        bsSink = events;
    }

    @Override
    public void onCancel(Object arguments) {
        // The Flutter app has closed the Event Channel
        bsSink = null;
    }

    public void sendEvent(Object o) {
        if (bsSink != null) {
            bsSink.success(o);
        }
    }
}
