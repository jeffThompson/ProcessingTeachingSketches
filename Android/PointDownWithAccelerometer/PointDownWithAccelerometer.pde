import android.content.Context;                  // required imports for sensor data
import android.hardware.Sensor;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;
import android.hardware.SensorManager;

/*
POINT DOWN WITH ACCELEROMETER
 Jeff Thompson | 2013 | www.jeffreythompson.org
 
 This sketch uses the accelerometer to point an arrow down as the
 device is rotated.
 
 Based on a great example from the forum by Chrisir:
 https://forum.processing.org/topic/box2d-point-box-towards-mouse#25080000002008663
 */

int circleSize = 50;               // size for circle in center
int lineLen = 500;                 // length of arrow

SensorManager sensorManager;       // keep track of sensor
SensorListener sensorListener;     // special class for noting sensor changes
Sensor accelerometer;              // Sensor object for accelerometer
float[] accelData;                 // x,y,z sensor data
float angle = 0;                   // angle of rotation (in radians)

void setup() {
  orientation(PORTRAIT);
  smooth();
}

void draw() {
  background(150, 140, 130);

  // if sensor data is available, set new angle
  if (accelData != null) {
    float x = map(accelData[1], 12.0, -12.0, 0, width);    // scale reading to screen dimensions
    float y = map(accelData[0], 12.0, -12.0, 0, height);
    angle = atan2(y - height/2, x - width/2);              // calculate angle between center and screen coordinates
  }

  // translate to center of screen, rotate angle
  translate(width/2, height/2);
  rotate(angle);

  // draw a circle at the center of the screen
  fill(255);
  noStroke();
  ellipse(0, 0, circleSize, circleSize);

  // draw an arrow pointing downward
  stroke(255);
  strokeWeight(4);
  line(0, 0, lineLen, 0);
  line(lineLen, 0, lineLen-30, -30);
  line(lineLen, 0, lineLen-30, 30);
}

// sensor reading code: start listening to the sensor on sketch start, stop
// listening on exit, and create a special class that extends the built-in
// SensorEventListener to read the sensor data into an array
void onResume() {
  super.onResume();
  sensorManager = (SensorManager)getSystemService(Context.SENSOR_SERVICE);
  sensorListener = new SensorListener();
  accelerometer = sensorManager.getDefaultSensor(Sensor.TYPE_ACCELEROMETER);
  sensorManager.registerListener(sensorListener, accelerometer, SensorManager.SENSOR_DELAY_GAME);  // see top comments for speed options
}
void onPause() {
  sensorManager.unregisterListener(sensorListener);
  super.onPause();
}

class SensorListener implements SensorEventListener {
  void onSensorChanged(SensorEvent event) {
    if (event.sensor.getType() == Sensor.TYPE_ACCELEROMETER) {
      accelData = event.values;
    }
  }
  void onAccuracyChanged(Sensor sensor, int accuracy) {
    // nothing here, but this method is required for the code to work...
  }
}

