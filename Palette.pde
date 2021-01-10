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
    JSONArray jsonColours = selectedPalette.getJSONArray("colours");
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
  
  float convertHexColour(String hex) {
    if (hex.charAt(0) == '#') {
      hex = hex.substring(1);
    }
    return unhex(hex);
  }
}
