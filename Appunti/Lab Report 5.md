[[Microelectronics Theory]]
# 1) Experiments with LEDs and ATMEGA Microcontroller
**Group No. B2**
**Date 17/04/25**

| Last Name/First Name | ID Number |
| -------------------- | --------- |
| Miotto Isabella      | 2066715   |
| Orso Marco           | 2074059   |
| Sette Andrea         | 2066747   |

Purpose of the exercise: to use an ATMEGA Microcontroller board to implement simple programs:
- Controlling a digital output
- Power control on digital output by PWM
- Reading from analog input
- Use of a 7-segment display
- Writing basic programs in "C" language

Instrumentation needed:
- Board with ATMEGA Microcontroller
- Breadboard

## 1.1) First Experiment
**First experiment:** implementation of the "soft-start" function (soft start) of an LED

| Component type        | Manufacturer Code/Value     |
| --------------------- | --------------------------- |
| 0.25 W resistances    | 560, 75 $[\ohm]$            |
| 5 mm LED              | C503BRANCA0B0AA1 , Cree     |
| NPN transistor        | P2N2222AG, ON Semiconductor |
| Potentiometer 10 κΩ   |                             |
| Arduino DUE board     |                             |
| Breadboard and cables |                             |
| Switch                | FSM2JART, RS Code 745-5185  |

![[Pasted image 20250418184441.png|Diagram|250]]
### 1.1.1) Prelab
1. What is the value of VCC for the adopted board? And the operating voltage of the LED? $$\begin{align}&V_{CC}=3.3 &&[V]\\ &V_{\text{on, LED}}=1.3 && [V]\end{align}$$
2. What is the maximum current that can be delivered from the chosen output pin$$\begin{align}
   &I_{\text{out, reccomended}}=15 \ &&[mA] \\
   &I_{\text{out, max}}=20 \ &&[mA]
   \end{align}$$
3. Choose the value of the resistance R1. (We choose a current on diode around 3,2 mA)
$$R_1=560 \ [\ohm]$$
What criterion was used in choosing this value? 
We choose a reference current to pass through the diode at around $3.2 \ [mA]$. By looking at the datasheet it is possible to to find the voltage across the resistance:
$$V=3.3-V_{diode}=3.3-1.3= 2 \ [V]\rightarrow R=\frac VI=625 \ [\ohm]$$

The closest value was $560 [\ohm]$ which didn't stray too far from our expected results.

4. Choose the value of the resistance $R_2$ . $$R_2 = 75 \ [\ohm]$$
What criterion was used in choosing this value? 
When the button is open, the input pin is electrically disconnected from both ground and $V_{cc}$, so its voltage “floats”. A resistor provides a weak but constant path to $V_{cc}$, forcing the pin to a defined HIGH level whenever the switch isn’t actively pulling it LOW.
  
### 1.1.2) In the Laboratory
>[!col]
> 1. Write, compile and verify the code to realize the "soft-start" of the LED: when the button is pressed once, the optical power of the LED has to gradually increase from 0 to the maximum value (in 2 seconds). When the button is pressed again, the LED's optical power has to gradually decrease from 0 to the minimum value (in 2 seconds).
>
![[Pasted image 20250419131124.png|Led Power|250]]

**Code:**
```cpp
int ledPin = 6;
int brightness = 0;
volatile bool on = true;
volatile unsigned long lastInterTime = 0;

int switchPin = 2;

unsigned long previousMillis = 0;

void setup() {
  pinMode(ledPin, OUTPUT);
  digitalWrite(ledPin, LOW);

  pinMode(switchPin, INPUT);
  attachInterrupt(digitalPinToInterrupt(switchPin), changeLED, RISING);
    
  Serial.begin(9600);
}

void loop() { 
  int i = on ? 1 : -1; //if on i = 1, otherwise i = -1

  unsigned long currentMillis = millis();
  if (currentMillis - previousMillis >= 2000 / 255) {
    previousMillis=currentMillis;
    brightness = clamp0255(brightness + i);
    analogWrite(ledPin, expChange(brightness + i));
  }
}

void changeLED() {
  unsigned long interruptTime = millis(); //debounce
  if (interruptTime - lastInterTime > 50) {
    on = !on;
    lastInterTime = interruptTime;
  }
}

int clamp0255(int toClamp) {
  if (toClamp < 0) return 0;
  if (toClamp > 255) return 255;
  return toClamp;
}

/*
Human eyes have logarithmic response to light, this function counters this effect
by making the increase be exponential. The result should be a linear percieved change.
A LED has linear luminance, therefore the correction just has to follow 1/gamma 
To know more about this search for gamma correction.
*/
int expChange (float b) {
  float gamma=2.2; //apparently good parameter for light
  return 255*pow(b/255,1/gamma);
}

```

![[Pasted image 20250423175717.png|Real Circuit|450]]
## 1.2) Second Experiment
**Second experiment:** control of an RGB LED by potentiometer

| Component type        | Manufacturer Code/Value     |
| --------------------- | --------------------------- |
| 0.25 W resistances    | 270, 390, 1000 $[\ohm]$     |
| RGB SMD LED           | ASMB-MTB0-0A3A2, Avago      |
| 3 NPN transistors     | P2N2222AG, ON Semiconductor |
| Potentiometer 10 κΩ   |                             |
| Arduino DUE board     |                             |
| Breadboard and cables |                             |
| Switch                | FSM2JART, RS Code 745-5185  |
![[Pasted image 20250419131558.png|Circuit Diagram|350]]
### 1.2.1) Prelab
1. What is the maximum current (Imax) that can be delivered by a digital pin on the adopted microcontroller board? $$I_{max}=15 \ [mA]$$
2. What is the rated voltage ($V_{on}$) of the three LED diodes used? Typical values $$\begin{align}
   &V_{on, red}= 2.1 &&[V] \\
   &V_{on, green}= 3.1 &&[V] \\
   &V_{on, blue}= 3.1 &&[V]
   \end{align}$$
3. Size the base resistors of the transistors so that the current delivered by the digital pins is 2.5 $[mA]$ (assume that the transistor has $V_{BE} =0.7 \ [V]$) $$\begin{align}
   &R_{B, red}= 1040 &&[k\ohm] \\
   &R_{B, green}= 1040 &&[k\ohm] \\
   &R_{B, blue}= 1040 &&[k\ohm]
   \end{align}$$
4. Assuming that the transistors operate in saturation, size the collector resistors of the three BJTs so that the current on the LEDs is 7 mA.$$\begin{align}
   &R_{C, red}= 386 &&[\ohm] \\
   &R_{C, green}= 271 &&[\ohm] \\
   &R_{C, blue}= 271 &&[\ohm]
   \end{align}$$
   

### 1.2.2) In the Laboratory
1. Mount the circuit in the figure
2. Write and compile a program that turns on the three LEDs in dc and report the code in the table
```cpp
int ledPins[] = {10, 9, 7}; //r,g,b
int rgb[] = {0, 0, 0}; //manually ste RGB values

void setup() {
  for (int i= 0; i < 3; i++){
    pinMode(ledPins[i], OUTPUT);
    digitalWrite(ledPins[i], LOW);
  }

  Serial.begin(9600);
}

void loop() {
   for(int i = 0; i < 3; i++) {
	   analogWrite(ledPins[i], rgb[i]);
   }
}
```
3. Measure the base-emitter drop of the three transistors under these conditions. 
$$\begin{align}
   &V_{BE, red}= 726 &&[mV] \\
   &V_{BE, green}= 735 &&[mV] \\
   &V_{BE, blue}= 730 &&[mV]
   \end{align}$$
4. Measure the current delivered by the digital outputs $$I_{\text{pin }10}=I_{\text{pin }9}=I_{\text{pin }7}=2.4 \ [mA]$$
5. Measure the operating voltage of the three LEDs and compare the result with the values given in the datasheet.$$\begin{align}
   &V_{on, red}= 1.9 &&[V] \\
   &V_{on, green}= 2.66 &&[V] \\
   &V_{on, blue}= 2.77 &&[V]
   \end{align}$$By checking the datasheet the voltages on blue and green seem a bit low, since the minimum forward voltage is set at $2.8 \ [V]$. On the other hand the miminum value for $V_{on, red}$ is $1.8 \ [V]$ and fits with our results.
3. What current is flowing through the three LEDs? What is the reason why these current values differ from the one chosen at the design stage (7 $[mA]$)?$$\begin{align}
   &I_{red}= 7.9 &&[mA] \\
   &I_{green}= 8.5 &&[mA] \\
   &I_{blue}= 8.1 &&[mA]
   \end{align}$$
4. The analog input A0 , depending on the position of potentiometer Rvar, reads values between 0 and 1023. Define an algorithm that – as the potentiometer rotates – changes the color combination on the RGB LED gradually (see figure below as an example). Verify the operation of the program and write the code in the box below. 
![[Pasted image 20250424103856.png|RGB Colours|450]]

![[Pasted image 20250424103744.png|HSV and HSL Encoding|450]]
```cpp
int ledPins[] = {10, 9, 7}; //r,g,b
int rgb[] = {0, 0, 0}; 

int potPin = A11;

bool trueIfHSL = false;

void setup() {
  for (int i= 0; i < 3; i++){
    pinMode(ledPins[i], OUTPUT);
    digitalWrite(ledPins[i], LOW);
  }

  Serial.begin(9600);
}

void loop() {
  int hue = map(analogRead(potPin), 0, 1023, 0, 360);
  int bright= 255;

  float C; float X; float m; //to calculate

  calcVal(hue, 1, 1, &C, &X, &m); //& passing address
  applyRGB(hue, C, X, m, bright);

  char buffer[50];
  sprintf(buffer, "R= %d G= %d B= %d", rgb[0], rgb[1], rgb[2]);
  Serial.println(buffer);
}

void calcVal (int hueF, float satF, float lightF, float* C, float* X, float* m) { //*taking address (pointer)
  if (trueIfHSL) calcHSL(hueF, 1, 0.5, C, X, m); //sat=1 lightness = 0.5
  else calcHSV(hueF, 1, 1, C, X, m);             //sat=1 lightness = 1
}

void calcHSL(int hueF, float satF, float lightF, float* C, float* X, float* m) {
  *C = (1-fabs(2 * lightF-1))*satF;
  *X = (*C) * (1 - fabs(fmod(hueF / 60.0, 2) - 1));
  *m = lightF - (*C / 2);
}

void calcHSV(int hueF, float satF, float lightF, float* C, float* X, float* m) {
  *C = satF * lightF;
  *X = (*C) * (1 - fabs(fmod(hueF / 60.0, 2) - 1));
  *m = lightF - *C;
}

void applyRGB(int hue, float C, float X, float m, int bright) {
  float tmpRgb[] = {0, 0, 0};

  if (hue >= 0 && hue < 60) {
	  tmpRgb[0] = C; tmpRgb[1] = X; tmpRgb[2] = 0;
  } else if (hue >= 60 && hue < 120) {
  	tmpRgb[0] = X; tmpRgb[1] = C; tmpRgb[2] = 0;
	} else if (hue >= 120 && hue < 180) {
    tmpRgb[0] = 0; tmpRgb[1] = C; tmpRgb[2] = X;
	} else if (hue >= 180 && hue < 240) {
    tmpRgb[0] = 0; tmpRgb[1] = X; tmpRgb[2] = C;
	} else if (hue >= 240 && hue < 300) {
    tmpRgb[0] = X; tmpRgb[1] = 0; tmpRgb[2] = C;
	} else {
    tmpRgb[0] = C; tmpRgb[1] = 0; tmpRgb[2] = X;
  }

  for(int i = 0; i < 3; i++) {
    rgb[i] = round((tmpRgb[i]+m)*bright);
    analogWrite(ledPins[i], rgb[i]);
  }
}

```

8. Add the code needed to display (on the serial monitor) the intensity (0 to 255) of the signal on the red, green and blue LEDs.
```cpp
int potPin2= A10; //added at beginning

int bright= map(analogRead(potPin2), 0, 1023, 0, 255); //added in loop()
```
9. Document (by photos) the proper operation of the program
![[Pasted image 20250423181044.png|RGB|550]]
Unfortunately the red appears to be a bit purple. The photos were taken with a damaged BJT on the blue led. The measurements were done with a working one but due to time constraints the photos couldn't be retaken

![[Pasted image 20250423181321.png|Log of Values Change due to Potentiometer|450]]
HSV encoding was chosen in this case since it keeps the brightness at full intensity. 

10. Connect a second potentiometer to another analog pin; modify the code so that this second potentiometer allows you to adjust the overall light intensity of the light emitted by the RGB LED
```cpp
int ledPins[] = {10, 9, 7}; //r,g,b
int rgb[] = {0, 0, 0}; 

int potPin = A11;
int potPin = A11;

bool trueIfHSL = true;

void setup() {
  for (int i= 0; i < 3; i++){
    pinMode(ledPins[i], OUTPUT);
    digitalWrite(ledPins[i], LOW);
  }

  Serial.begin(9600);
}

void loop() {
  int hue = map(analogRead(potPin), 0, 1023, 0, 360);
  int bright= map(analogRead(potPin2), 0, 1023, 0, 255); //added in loop()

  float C; float X; float m; //to calculate

  calcVal(hue, 1, 1, &C, &X, &m); //& passing address
  applyRGB(hue, C, X, m, bright);

  char buffer[50];
  sprintf(buffer, "R= %d G= %d B= %d", rgb[0], rgb[1], rgb[2]);
  Serial.println(buffer);
}

void calcVal (int hueF, float satF, float lightF, float* C, float* X, float* m) { //*taking address (pointer)
  if (trueIfHSL) calcHSL(hueF, 1, 0.5, C, X, m); //sat=1 lightness = 0.5
  else calcHSV(hueF, 1, 1, C, X, m);             //sat=1 lightness = 1
}

void calcHSL(int hueF, float satF, float lightF, float* C, float* X, float* m) {
  *C = (1-fabs(2 * lightF-1))*satF;
  *X = (*C) * (1 - fabs(fmod(hueF / 60.0, 2) - 1));
  *m = lightF - (*C / 2);
}

void calcHSV(int hueF, float satF, float lightF, float* C, float* X, float* m) {
  *C = satF * lightF;
  *X = (*C) * (1 - fabs(fmod(hueF / 60.0, 2) - 1));
  *m = lightF - *C;
}

void applyRGB(int hue, float C, float X, float m, int bright) {
  float tmpRgb[] = {0, 0, 0};

  if (hue >= 0 && hue < 60) {
	  tmpRgb[0] = C; tmpRgb[1] = X; tmpRgb[2] = 0;
  } else if (hue >= 60 && hue < 120) {
  	tmpRgb[0] = X; tmpRgb[1] = C; tmpRgb[2] = 0;
	} else if (hue >= 120 && hue < 180) {
    tmpRgb[0] = 0; tmpRgb[1] = C; tmpRgb[2] = X;
	} else if (hue >= 180 && hue < 240) {
    tmpRgb[0] = 0; tmpRgb[1] = X; tmpRgb[2] = C;
	} else if (hue >= 240 && hue < 300) {
    tmpRgb[0] = X; tmpRgb[1] = 0; tmpRgb[2] = C;
	} else {
    tmpRgb[0] = C; tmpRgb[1] = 0; tmpRgb[2] = X;
  }

  for(int i = 0; i < 3; i++) {
    rgb[i] = round((tmpRgb[i]+m)*bright);
    analogWrite(ledPins[i], rgb[i]);
  }
}

```

![[Pasted image 20250423181724.png|New Log With Less Brightness|450]]
By calculating the HSL values corresponding to these RGB values it is clear that the brightness is not 100%. HSL was chosen in order to put emphasis on the brightness change.

## 1.3) Third Experiment
**Third experiment:** control of a 7-segment display using a Microcontroller-based board
**Components needed:**

| Component type        | Manufacturer Code/Value |
| --------------------- | ----------------------- |
| 0.25 W resistances    | 390 $[\ohm]$            |
| 7-segment display     | SC05-11GWA, Kingbright  |
| Potentiometer 10 κΩ   |                         |
| Arduino DUE board     |                         |
| Breadboard and cables |                         |
![[Pasted image 20250419133923.png|Diagram. Only some LEDs represented|350]]
1. Calculate the value of the resistors Ri that allows for a current of 3 $[mA]$ on each LED
$$R_i=366.7 \ [\ohm]$$
2. Mount the circuit in the figure
3. Write a code that displays a numerical value (0 to 9) on the 7-segment display that is proportional to the elapsed time from the start of the program (in seconds); reset the counter when 10 s have elapsed
```cpp
const int ledPins[] = {6, 7, 8, 9, 10, 11, 12, 13}; //follow display schematics
const int in = A2;

unsigned long previousMillis = 0;
int count = 0;

//volatile char number = 0;

const int numberLeds[10][8]={ //10 file 8 colonne
{1,1,1,0,1,1,1,0}, //0
{1,0,0,0,1,0,0,0}, //1
{1,1,0,1,0,1,1,0}, //2
{1,1,0,1,1,1,0,0}, //3
{1,0,1,1,1,0,0,0}, //4
{0,1,1,1,1,1,0,0}, //5
{0,1,1,1,1,1,1,0}, //6
{1,1,0,0,1,0,0,0}, //7
{1,1,1,1,1,1,1,0}, //8
{1,1,1,1,1,1,0,0}  //9
};

void setup() {
  for (int i= 0; i < sizeof(ledPins) / sizeof(ledPins[0]); i++){
    pinMode(ledPins[i], OUTPUT);
    digitalWrite(ledPins[i], LOW);
  }

  Serial.begin(9600);
}

void loop() {
  unsigned long currentMillis = millis();
  if (currentMillis - previousMillis >= 1000){
    changeLED(periodic09(count + 1));

    previousMillis=currentMillis;
  }
}

void changeLED (int number) {
    for (int i = 0; i < 7; i++) 
     digitalWrite(ledPins[i], numberLeds[number][i]);
}

int periodic09(int n){
  if (n>9) return 0;
  return n;
}
```

![[Pasted image 20250423182706.png|4 & 6 Working|450]]
## 1.4) Fourth Experiment
**Fourth experiment:** ambient light sensor (Optional)
Implement a circuit using a microcontroller that detects the intensity of ambient light by using a photodiode, and adjusts the light emitted by an LED accordingly. You want the LED to be off/almost off in the presence of ambient light, and gradually turn on to its maximum value as the illumination level on the photodiode decreases.
![[Pasted image 20250419164737.png|Diagram|350]]
**NOTE:** The circuit would require dual power supply from the operational amplifier. We use 0 V at the negative terminal to avoid errors that could damage the microcontroller board.

**Components Needed:**

| Component type        | Manufacturer Code/Value     |
| --------------------- | --------------------------- |
| 0.25 W resistances    | 1 $[M\ohm]$                 |
| 5 mm LED              | C503BRANCA0B0AA1 , Cree     |
| IR photodiode/visible | SFH203, OSRAM               |
| 1 NPN transistor      | P2N2222AG, ON Semiconductor |
| Arduino DUE board     |                             |
| Breadboard and cables |                             |
1. Briefly explain the operation of the circuit; what is the value of the voltage $V_0$?
The circuit is a” light brightness sensor”, as enough light hit the photodiode the voltage across it is amplified by the opamp and gives to the arduino a “value of brightness” based on the amount of light hitting the photodiode, then with PWM the measured brightness is reported on the diode in output by making it shine more or less. $V_o$ should stay in the range of 0-3.3 $[V]$

2. Measure by bench multimeter the current generated by the photodiode under ambient lighting, and report the value in the report $$I_p=0.8 \ [\mu A]$$
3. Size the resistors so as to obtain:
	a. Output voltage v0 equal to about 1 V (10% max error) in the presence of ambient light
	b. Maximum current on the LED equal to 20 mA
A $1 \ [M\ohm]$ resistor was chosen for point a. since the photodiode emitted $0.8 \ [\mu A]$ at light temperature and $v_0=I_pR_1$. For the second resistor the reasoning was the same as the previous experiences.

4. Assemble the circuit, checking the value of the voltage v0 as the illumination level on the photodiode changes (use the oscilloscope). Add the results to the report
![[Pasted image 20250423182906.png|Oscilloscope measuring Vo change in function of distance|450]]
![[Pasted image 20250423182926.png|Oscilloscope measuring V of photodiode change in function of distance|450]]

5. Is the sensor sensitive to artificial light fluctuation (50 Hz)? If yes, stabilize with one of the capacitors available in the lab. What cutoff frequency was chosen?

Due to the presence of high ambient light it wasn't possible to observe this dependency on the circuit. If it were to be stabilized the capacitance must be in parallel to the $1 [M\ohm]$ resistor and will have the following value:
$$C=\frac{1}{2\pi R f}=265\approx270 \ [nF]$$

6. Write the code needed to perform the required function and report in the report
```cpp
int ledPin = 2;
int input = A0;

int thresh = 341; //341 = 1V + 10% ambient light

void setup() {
  pinMode(ledPin, OUTPUT);
  digitalWrite(ledPin, LOW);

  Serial.begin(9600);
}

void loop() {
  int inputVoltage = analogRead(input);
  if (inputVoltage >= thresh){ 
    int brightness = map(inputVoltage, thresh, 1023, 0, 255);
    brightness = (brightness);
    digitalWrite(ledPin, brightness);
    
    char buffer[50];
    sprintf(buffer, "Brightness= %d Input= %d", brightness, inputVoltage);
    Serial.println(buffer);
  }
  else   {
    digitalWrite(ledPin, LOW);
    char buffer[50];
    sprintf(buffer, "Input= %d", inputVoltage);
    Serial.println(buffer);
  }
}

int expChange (float b) {
  float gamma=2.2; //apparently good parameter for light
  return 255*pow(b/255,1/gamma);
}
```

![[Pasted image 20250423183132.png|Ambient vs Artificial Light|550]]