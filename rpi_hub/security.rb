#!/usr/bin/env ruby

require "mqtt"

MQTT_BROKER_HOST = ENV.fetch("MQTT_BROKER_HOST", "localhost")
MQTT_TOPIC = "security"

SENSORS_BY_ID = {
  "frontdoor_001" => "Front Door"
}

def get_sensor_state(voltage)
  case voltage
  when 1000..1024
    "closed"
  when 0..100
    "open"
  else
    "unknown"
  end
end

MQTT::Client.connect(MQTT_BROKER_HOST) do |conn|
  last_state = "unknown"

  conn.get(MQTT_TOPIC) do |topic, message|
    puts "#{topic}: #{message}"

    sensor_id, sensor_voltage = message.split
    sensor_name = SENSORS_BY_ID[sensor_id]

    sensor_state = get_sensor_state(sensor_voltage.to_i)

    if last_state != sensor_state
      last_state = sensor_state
      puts "sensor_state: #{sensor_state}"
    end
  end
end
