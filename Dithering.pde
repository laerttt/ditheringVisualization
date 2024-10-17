
PImage starry;
int FACTOR = 1;
int TOGGCOL = 0;
void setup(){
  surface.setTitle("Michelangelo's David");
  size(750,660);
  background(0);
  starry = loadImage("david.jpg");
  image(starry, 10, 10);
  if(TOGGCOL==0){
    starry.filter(GRAY);
    //starry.filter(INVERT);
  }
}
void draw(){
  starry.loadPixels();
  for(int y = 0; y < starry.height-1; y++){
    for(int x = 1; x < starry.width-1; x++){
  //  for(int y = 0; y < 100 ; y++){
  //    for(int x = 1; x < 100; x++){
  
      color pix = starry.pixels[index(x,y)];
      float r = red(pix);
      float g = green(pix);
      float b = blue(pix);
      
      int factor=FACTOR; //quant factor
      
      int nR = round(factor*r/255) * (255/factor);
      int nG = round(factor*g/255) * (255/factor);
      int nB = round(factor*b/255) * (255/factor);
      
      starry.pixels[index(x,y) ] = color(nR,nG,nB);
      
      //quant err
      float eR = r - nR;
      float eG = g - nG;
      float eB = b - nB;
      starry.pixels[index(x,y)] = color(nR,nG,nB);
      starry.pixels[(index(x+1,y))] = newPixel(starry.pixels[(index(x+1,y))],eR,eG,eB,7);
      starry.pixels[(index(x-1,y+1))] = newPixel(starry.pixels[(index(x-1,y+1))],eR,eG,eB,3);
      starry.pixels[(index(x,y+1))] = newPixel(starry.pixels[(index(x,y+1))],eR,eG,eB,5);
      starry.pixels[(index(x+1,y+1))] = newPixel(starry.pixels[(index(x+1,y+1))],eR,eG,eB,1);
    }
  }
  starry.updatePixels();
  image(starry, 380, 10);
}


int index(int x, int y){
  return  x + y * starry.width;
}

color newPixel(color pixel,float qR, float qG, float qB, int mode){
  float r = red(pixel);
  float g = green(pixel);
  float b = blue(pixel);
  if(mode == 7){
    return color(r+qR*7/16,g+qG*7/16,b+qB*7/16);
  }
  else if(mode == 3){
    return color(r+qR*3/16,g+qG*3/16,b+qB*3/16);
}
  else if(mode == 5){
    return color(r+qR*5/16,g+qG*5/16,b+qB*5/16);
  }
  else if(mode == 1){
    return color(r+qR*1/16,g+qG*1/16,b+qB*1/16);
  }
  return color(255);
}
