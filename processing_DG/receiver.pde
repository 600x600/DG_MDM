class Receiver {
  JSONObject json;

  float bg_color_picker;
  float caos_amount_picker;
  //float fish_speed_picker;

  Receiver() {
  }

  void getData(JSONObject data) {
    json = data;

    //Aguieira
    JSONArray aguieiraArray = json.getJSONArray("aguieira");
    JSONObject firstEntryApa = aguieiraArray.getJSONObject(0);
    String volString_AGUIEIRA = firstEntryApa.getString("Volume armazenado");
    String cotaString_AGUIEIRA = firstEntryApa.getString("Cota");
    String caudAString_AGUIEIRA = firstEntryApa.getString("Caudal Afluente");
    String caudEString_AGUIEIRA = firstEntryApa.getString("Caudal Efluente");

    volume_AGUIEIRA = float(volString_AGUIEIRA);
    cota_AGUIEIRA = float(cotaString_AGUIEIRA);
    caudA_AGUIEIRA = float(caudAString_AGUIEIRA);
    caudE_AGUIEIRA = float(caudEString_AGUIEIRA);

    //Raiva
    JSONArray raivaArray = json.getJSONArray("raiva");
    JSONObject secondEntryApa = raivaArray.getJSONObject(0);
    String volString_RAIVA = secondEntryApa.getString("Volume armazenado");
    String cotaString_RAIVA = secondEntryApa.getString("Cota");
    String caudAString_RAIVA = secondEntryApa.getString("Caudal Afluente");
    String caudEString_RAIVA = secondEntryApa.getString("Caudal Efluente");

    volume_RAIVA = float(volString_RAIVA);
    cota_RAIVA = float(cotaString_RAIVA);
    caudA_RAIVA = float(caudAString_RAIVA);
    caudE_RAIVA = float(caudEString_RAIVA);

    //Coimbra
    JSONArray coimbraArray = json.getJSONArray("coimbra");
    JSONObject thirdEntryApa = coimbraArray.getJSONObject(0);
    String cotaString_COIMBRA = thirdEntryApa.getString("Cota");
    String caudAString_COIMBRA = thirdEntryApa.getString("Caudal Afluente");
    String caudEString_COIMBRA = thirdEntryApa.getString("Caudal Efluente");

    cota_COIMBRA = float(cotaString_COIMBRA);
    caudA_COIMBRA = float(caudAString_COIMBRA);
    caudE_COIMBRA = float(caudEString_COIMBRA);

    //IPMA
    JSONArray ipmaArray = json.getJSONArray("figueira");
    JSONObject firstEntryIpma = ipmaArray.getJSONObject(0);
    String ondString = firstEntryIpma.getString("Ondulacao");
    String perOString = firstEntryIpma.getString("Periodo Onda");
    String perPString = firstEntryIpma.getString("Periodo Pico");
    String tempString = firstEntryIpma.getString("Temperatura");


    ondulacao = float(ondString);
    periodo_onda = float(perOString);
    periodo_pico = float(perPString);
    temperatura = float(tempString);

    bg_color_picker = caudE_RAIVA + caudE_AGUIEIRA;
    caos_amount_picker = caudE_COIMBRA;
    //fish_speed_picker = caudE_COIMBRA;
  }

  void getValues() {
    //map data to project values...
    val1 = 4;

    //BG COLOR
    if (bg_color_picker >= 720) {
      chosenBG = bg_base1;
      chosenH = bg_highlight1;
    } else if (bg_color_picker >= 360) {
      chosenBG = bg_base2;
      chosenH = bg_highlight2;
    } else {
      chosenBG = bg_base3;
      chosenH = bg_highlight3;
    }

    //BG NOISE AMOUNT
    caosAmount = map(caos_amount_picker, 5, 200, 0.001, 0.01);
    // fish_speed = map(fish_speed_picker, 5, 200, 1.2, 3);


    // FISH COLORS
    // BODY
    if (volume_AGUIEIRA >= 90) {
      c2 = orange;
    } else if (volume_AGUIEIRA >= 40) {
      c2 = yellow;
    } else {
      c2 = pink;
    }

    // TAIL
    if (volume_RAIVA >= 95) {
      c1 = orange;
    } else if (volume_RAIVA >= 90) {
      c1 = yellow;
    } else {
      c1 = pink;
    }

    // FINS
    if (cota_COIMBRA >= 18.8) {
      c3 = orange;
    } else if (cota_COIMBRA >= 17.8) {
      c3 = yellow;
    } else {
      c3 = pink;
    }

    //FISH PARTS
    //BODY
    if (caudA_AGUIEIRA >= 200) {
      chosen_body = body3;
    } else if (caudA_AGUIEIRA >= 50) {
      chosen_body = body1;
    } else {
      chosen_body = body2;
    }

    //TAIL
    if (caudA_COIMBRA >= 200) {
      chosen_tail = tail1;
    } else {
      chosen_tail = tail2;
    }

    //FINS
    if (caudA_RAIVA >= 150) {
      chosen_fins = fins1;
    } else {
      chosen_fins = fins2;
    }
  }
}
