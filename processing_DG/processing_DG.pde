//DESIGN GENERATIVO (MDM | UC), 2026

import processing.sound.*;
Amplitude amp;
AudioIn in;

Fish fish_obj;

JSONObject json;
PShape fish;
String lastTime = "";
int lastCheckTime = 0;
int checkInterval = 1000; //1s

color a = color(0, 255, 0);
color b = color(0, 0, 255);

//Figueira da Foz
float periodo_pico, periodo_onda, ondulacao, temperatura;

//Aguieira
float volume_AGUIEIRA, cota_AGUIEIRA;
float caudA_AGUIEIRA, caudE_AGUIEIRA;

//Raiva
float volume_RAIVA, cota_RAIVA;
float caudA_RAIVA, caudE_RAIVA;

//Coimbra
float cota_COIMBRA;
float caudA_COIMBRA, caudE_COIMBRA;

int canvasWidth = 350;
int canvasHeight = 24;
float scaling = 10;

PGraphics canvas; // https://processing.org/reference/PGraphics.html
Tx tx;

int count = 0; //just a println helper, to be deleted

//-----

color chosenBG, chosenH;
float caosAmount;
color c1, c2, c3;
PShape body1, body2, body3;
PShape fins1, fins2;
PShape tail1, tail2;
PShape chosen_body, chosen_fins, chosen_tail;
float fish_speed;
float yPos;

//---

void settings() {
  // Find the larger scaling that fits your screen
  while (canvasWidth * scaling > displayWidth) scaling--;
  size(int(canvasWidth * scaling), int(canvasHeight * scaling));
  pixelDensity(1); // Do not remove this line
  noSmooth(); // Do not remove this line
}

int val1; //placeholder

Receiver receiver;
Background[] bg;

void setup() {
  frameRate(30);
  canvas = createGraphics(canvasWidth, canvasHeight);
  tx = new Tx(canvasWidth, canvasHeight);

  body1 = loadShape("body1.svg"); // stripes
  body2 = loadShape("body2.svg"); // scales
  body3 = loadShape("body3.svg"); // dots

  fins1 = loadShape("fins1.svg"); // straight
  fins2 = loadShape("fins2.svg"); // pointed

  tail1 = loadShape("tail1.svg"); // 3 spikes
  tail2 = loadShape("tail2.svg"); // 2 spikes

  amp = new Amplitude(this);
  in = new AudioIn(this, 0);
  in.start();
  amp.input(in);

  receiver = new Receiver();

  chosenBG = bg_highlight2;
  chosenH = bg_base2;
}

void draw() {
  if (millis() - lastCheckTime > checkInterval) {
    update();
    lastCheckTime = millis();
  }

  float soundVolume = amp.analyze();
  float target_speed = map(soundVolume, 0, 1, 1.2, 30);
  fish_speed = lerp(fish_speed, target_speed, 0.1);
  //fish_speed = map(soundVolume, 0, 1, 1.2, 6);

  // Draw animation on a (offscreen) canvas
  canvas.beginDraw();
  canvas.background(chosenBG);

  for (int i = 0; i < bg.length; i++) {
    bg[i].display(canvas);
    bg[i].move();
  }

  canvas.blendMode(NORMAL);

  if (fish_obj !=null) {
    fish_obj.speed = fish_speed; //making sure the fish can react to sound WHILE swimming

    fish_obj.swim();
    fish_obj.display(canvas);

    if (fish_obj.isOffScreen(canvasWidth)) {

      yPos = random(1, 10);
      println("recalculated yPos: ", yPos);
      fish_obj = new Fish(chosen_body, chosen_fins, chosen_tail, c1, c2, c3, fish_speed, yPos);
      fish_obj.loadAndCHoose();
    }
  }

  canvas.endDraw();

  // Draw canvas on window
  image(canvas, 0, 0, width, height);

  // Send canvas to server
  tx.send(canvas);
}


void update() {
  json = loadJSONObject("data.json");

  if (json != null) {
    String currentTime = json.getString("time");

    //has time changed?
    if (!currentTime.equals(lastTime)) {
      background(chosenBG);
      receiver.getData(json);
      receiver.getValues();

      yPos = random(1, 10);
      println("recalculated yPos: ", yPos);
      fish_obj = new Fish(chosen_body, chosen_fins, chosen_tail, c1, c2, c3, fish_speed, yPos);
      fish_obj.loadAndCHoose();

      count++;

      /* println(" ");
       println(" ");
       println("TIME CHANGED TO: " + json.getString("time"));
       println(" ");
       println("----> AGUIEIRA:");
       println("Volume armazenado: " + volume_AGUIEIRA, "Cota: " +  cota_AGUIEIRA);
       println("Caudal A: " + caudA_AGUIEIRA, "Caudal E: " +  caudE_AGUIEIRA);
       println(" ");
       println("----> RAIVA:");
       println("Volume armazenado: " + volume_RAIVA, "Cota: " +  cota_RAIVA);
       println("Caudal A: " + caudA_RAIVA, "Caudal E: " +  caudE_RAIVA);
       println(" ");
       println("----> COIMBRA:");
       println("Cota: " +  cota_COIMBRA);
       println("Caudal A: " + caudA_COIMBRA, "Caudal E: " +  caudE_COIMBRA);
       println(" ");
       println("----> FIGUEIRA DA FOZ:");
       println("Ondulacao: " + ondulacao);
       println("Periodo onda: " + periodo_onda, "Periodo pico: " + periodo_pico);
       println("Temperatura: " + temperatura);
       */

      bg = new Background[val1];

      for (int i = 0; i < bg.length; i++) {
        bg[i] = new Background(caosAmount, chosenBG, chosenH);
      }

      //update lastTime so it only prints once per update
      lastTime = currentTime;
    }
  }
}
