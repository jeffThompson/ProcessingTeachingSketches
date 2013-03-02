import android.content.Context;                // required imports for sensor data
import android.hardware.Sensor;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;
import android.hardware.SensorManager;

/*
ACCELEROMETER
 Jeff Thompson | 2013 | www.jeffreythompson.org
 
 Reading the built-in sensors like the accelerometer is a bit tricker than many
 other examples; it requires several built-in Android objects and a custom class
 to handle the readings.
 
 The trade-off? It's really cool! This example, a ball moves with the tilt of
 the device.
 
 A NOTE ON SPEED OF READING:
 The sensors can be read at three different rates, depending on need:
 1. SENSOR_DELAY_FASTEST
 2. SENSOR_DELAY_GAME
 3. SENSOR_DELAY_NORMAL
 
 More information on the Sensor class and it's methods can be found here:
 http://developer.android.com/reference/android/hardware/Sensor.html
 
 Built from many examples, but very helpful was this Processing version:
 http://www.akeric.com/blog/?p=1313
 
 CHALLENGE:
 1. Make the ball change color when it hits the walls, change color based on the
    speed of motion, or react in some other way to the sensor reading.
 2. Get the ball speed into a more useful range using map() on the accelerometer values.
 3. Create an array of balls that all bump around the screen!
 4. Try the other sensors such as the MAGNETIC_FIELD sensor instead - see the full
    list using the API link above.
 */

int ballSize = 800;                // size for rolling ball

SensorManager sensorManager;       // keep track of sensor
SensorListener sensorListener;     // special class for noting sensor changes
Sensor accelerometer;              // Sensor object for accelerometer
float[] accelData;                 // x,y,z sensor data
float ballX, ballY;                // ball coordinates
PFont font;

void setup() {
  orientation(LANDSCAPE);                  // basic setup
  smooth();
  noStroke();

  font = createFont("SansSerif", 72);      // font setup
  textFont(font);
  textAlign(CENTER, CENTER);

  ballX = width/2;                         // start ball in the center
  ballY = height/2;
}

void draw() {
  background(0, 255, 150);

  // if we are able to get sensor data
  if (accelData != null) {

    // display the reading - uses nf() to format the numbers so the # of decimal places
    // is managable and consistent
    fill(0);
    text("x: " + nf(accelData[0], 2, 3) + ", y: " + nf(accelData[1], 2, 3) + ", z: " + nf(accelData[2], 2, 3), width/2, height/2);

    // move the ball, hit the edges of the screen
    ballX -= accelData[0];    // subtract so we move in the correct direction L-R
    ballY += accelData[1];
    if (ballX-ballSize/2 <= 0) ballX = ballSize/2;
    if (ballX+ballSize/2 >= width) ballX = width-ballSize/2;
    if (ballY-ballSize/2 <= 0) ballY = ballSize/2;
    if (ballY+ballSize/2 >= height) ballY = height-ballSize/2;    

    // draw the ball!
    fill(255, 150);
    ellipse(ballX, ballY, ballSize, ballSize);
  }

  // trouble loading the data? let us know...
  else {
    text("[ no accelerometer data ]", width/2, height/2);
  }
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

