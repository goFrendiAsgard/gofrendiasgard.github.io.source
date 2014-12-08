Title: Arduino + Sonar Sensor + LED
date: 2014-12-05
comments: true
slug: arduino
---

<!-- PELICAN_BEGIN_SUMMARY -->
I have just play up with arduino, HC-SR04 sonar sensor.
<!-- PELICAN_END_SUMMARY -->

Thanks to project board and arduino. Nowaday, anyone can build their own robot easily.
There are many instruction to do that in [instructables](http://www.instructables.com/tag/type-id/category-technology/channel-arduino/)
Very cool, just do exactly as the instruction and you can make your very own high-tech toys.

As a newbie, today I try to play around with HC-SR04 sonar sensor. I plan to build a very simple robot that can detect obstacle by using sonar.
I use LED since DC Motor is a bit complicated and dangerous for newbie (I mean you can damage the arduino board itself if you set it wrong).
So, my current prototype robot doesn't able to move anywhere.

Here is my prototype robot in action:
{% youtube woXSY94KMFw %}

Basically it will detect any obstacle less than 20 cm in front of the sonar sensor, and will turn off one of the LED.
Let's think LED as motor. If you have 2 motors, and one of them is switched off, you will get your robot turn it's direction.

The schema is as follows:

{% img /images/gunvarrel-02.png %}

HC-SR04 will operate under 5 volt voltage. Thus, I simply connect 5 volt VCC from arduino board to VCC pin of HC-SR04.

HC-SR04 also has another 3 pins. GND that should be connected to arduino's ground, ECHO, and TRIG.
Whenever you send 3 volt to ECHO, HC-SR04 will emmit ultrasonic wave. You can catch the echo by read on ECHO pin.

Pin 1-13 in arduino has 3 volt voltage and 0.03 ampere current. However, the LED should only accept 2 volt. 
This is why you need a 100 ohm resistor. Please take a look at these calculations:

$V_{Total} = V_{LED} + V_{Resistor}$

$5 volt = 2 volt + V_{Resistor}$

$V_{Resistor} = 1 volt$

Since $V = I * R$, then

$R_{Resistor} = \frac{V_{Resistor}}{I}$

$R_{Resistor} = \frac{1 volt}{0.03 ampere}$

$R_{Resistor} = 100 \Omega$

It is really worth for anyone who want to mess up with electronics stuff to know about `Kirchoff Voltage Law` and `Kirchoff Current Law`.
Those two laws are not usually discussed in any instructables.

And here is the code:
```
    /*
     * Gunvarrel v 0.0.2
     * Purpose: To emulate simple sonar robot
     * Description: Far from perfect. I use LED instead of motor
     * Author: Go Frendi Gunawan
     */
    int left_motor   = 12;  // left  motor
    int right_motor  = 13;  // right motor
    int sonar_trig   = 8;   // sonar trigger
    int sonar_echo   = 7;   // sonar echo

    void setup(){
      Serial.begin(9600);
      pinMode(left_motor,   OUTPUT);
      pinMode(right_motor,  OUTPUT);
      pinMode(sonar_trig,   OUTPUT);
      pinMode(sonar_echo,   INPUT );
    }

    void straight(){
      digitalWrite(left_motor,  HIGH);
      digitalWrite(right_motor, HIGH);
      delay(100);
    }

    void turn(){
      digitalWrite(left_motor, LOW);
      digitalWrite(right_motor, HIGH);
      delay(100);
    }
    void loop(){
      // shout out
      digitalWrite(sonar_trig, LOW);
      digitalWrite(sonar_trig, HIGH);
      delayMicroseconds(20);
      digitalWrite(sonar_trig, LOW);
      // listen
      int duration = pulseIn(sonar_echo, HIGH);
      int distance = (duration/2) / 29.1;
      Serial.println(distance);
      if(distance < 20){
        turn();
      }else{
        straight();
      }
    }
```