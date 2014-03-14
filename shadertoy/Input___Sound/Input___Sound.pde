import ddf.minim.*;
import ddf.minim.analysis.*;
PShader myShader;

// Textures
PImage img;


Minim minim;
AudioPlayer player;
FFT         fft;


void setup() {

  size( 512, 512, P2D );


  // Load the shader file from the "data" folder
  myShader = loadShader( "shader.glsl" );
  
  // Pass the dimensions of the viewport to the shader
  myShader.set( "iResolution", float(width), float(height) );
 
   // we pass this to Minim so that it can load files from the data directory
  minim = new Minim(this);
  
  // loadFile will look in all the same places as loadImage does.
  // this means you can find files that are in the data folder and the 
  // sketch folder. you can also pass an absolute path, or a URL.
  player = minim.loadFile("marcus_kellis_theme.mp3");
  
  // play the file
  player.loop();
  
   // create an FFT object that has a time-domain buffer 
  // the same size as jingle's sample buffer
  // note that this needs to be a power of two 
  // and that it means the size of the spectrum will be half as large.
  fft = new FFT( player.bufferSize(), player.sampleRate() );
 
}


void draw() {
  background(0);
  
  // perform a forward FFT on the samples in jingle's mix buffer,
  // which contains the mix of both the left and right channels of the file
  fft.forward( player.mix );
  img = createImage(fft.specSize(), 1, ARGB);
  for(int i = 0; i <  fft.specSize() ; i++) {
    float a = fft.getBand(i)*255;
    img.pixels[i] = color(a, 0, 0, 0); 
  }
  //img = loadImage( "tex00.jpg" );
  myShader.set( "iChannel0", img ); 
  shader(myShader);

  // Draw the output of the shader onto a rectangle that covers the whole viewport
  rect(0, 0, width, height);

  // Call resetShader() so that further geometry remains unaffected by the shader
  resetShader();


}


