class Palette {
  JSONObject palettes, selectedPalette;
  
  Palette() {
    this("palettes.json");
  }
  
  Palette(String filename) {
    palettes = loadJSONObject(filename).getJSONObject("palettes");
  }
  
  float[][] getColours(String paletteName) {
    selectedPalette = this.getSelectedPalette(paletteName);
    JSONArray jsonColours = this.getPaletteColours();
    JSONArray jsonStops = selectedPalette.getJSONArray("stops");
    float[][] colours = new float[jsonColours.size()][2];
    for (int i = 0; i < jsonColours.size(); i++) {
      colours[i] = new float[]{jsonStops.getFloat(i), this.convertHexColour(jsonColours.getString(i))};
    }
    
    return colours;
  }
  
  JSONObject getSelectedPalette(String paletteName) {
    String[] paletteId = split(paletteName, ".");
    selectedPalette = palettes;
    for (String id : paletteId) {
      selectedPalette = selectedPalette.getJSONObject(id);
    }
    return selectedPalette;
  }
  
  JSONArray getPaletteColours() {
    JSONArray jsonColours = selectedPalette.getJSONArray("colours");
    if (jsonColours == null) {
      jsonColours = selectedPalette.getJSONArray("colors");
    }
    return jsonColours;
  }
  
  float convertHexColour(String hex) {
    if (hex.charAt(0) == '#') {
      hex = hex.substring(1);
    }
    return unhex(hex);
  }
}
