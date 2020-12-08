class Gradient {
  PImage image;
  
  Gradient() {
    image = createImage(width, height, RGB);
    for (int i = 0; i < image.pixels.length; i++) {
      image.pixels[i] = getColour(i);
    }
  }
  
  void display() {
    image(image, 0, 0);
  }
  
  float getGradientProgress(int i) {
    return map(getPixelY(i), 0, height, 0, 1);
  }
  
  color getColour(int i) {
    float gradientProgress = getGradientProgress(i);
    float[] start = colourProfile.baseColours[0];
    float[] end = colourProfile.baseColours[colourProfile.baseColours.length - 1];
    for (float[] checkpoint : colourProfile.baseColours) {
      if (gradientProgress >= checkpoint[0]) {
        start = checkpoint;
      }
      if (gradientProgress < checkpoint[0]) {
        end = checkpoint;
        break;
      }
    }
    float sectionProgress = map(gradientProgress, start[0], end[0], 0, 1);
    return smootherLerpColor(int(start[1]), int(end[1]), sectionProgress);
  }
  
  color smootherLerpColor(color a, color b, float progress) {
    float huea = hue(a);
    float hueb = hue(b);
    float delta = hueb - huea;

    if (delta < -180) {
      hueb += 360;
    } else if (delta > 180) {
      huea += 360;
    }
    float hue = (huea + progress * (hueb - huea)) % 360;
    float saturation = lerp(saturation(a), saturation(b), progress);
    float brightness = lerp(brightness(a), brightness(b), progress);
    return color(hue, saturation, brightness);
  }
}
