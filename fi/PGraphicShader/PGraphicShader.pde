// The shader that will contain the blending code
PShader myShader;

// Start with that mode
int blendIndex = 0;

// Textures
PImage sourceImage, targetImage;

PGraphics pg;

void setup() {

  size( 512, 512, P2D );
  pg = createGraphics(640, 360, P2D);  
 
  // Load texture images
  sourceImage = loadImage( "tex00.jpg" );
  targetImage = loadImage( "tex01.jpg" );
 
  // Load the shader file from the "data" folder
  myShader = loadShader( "shader.glsl" );
  
  // Pass the dimensions of the viewport to the shader
  myShader.set( "sketchSize", float(width), float(height) );
  
  // Pass the images to the shader
  myShader.set( "topLayer", sourceImage ); 
  myShader.set( "lowLayer", targetImage );

  // Pass the resolution of the images to the shader
  myShader.set( "topLayerResolution", float( sourceImage.width ), float( sourceImage.height ) );
  myShader.set( "lowLayerResolution", float( targetImage.width ), float( targetImage.height ) );
  
  blendIndex =1;

  
}


void draw() {

  // How much of the top layer should be blended in the lower layer?
  float blendOpacity = float( mouseX ) / float( width );
  myShader.set( "blendAlpha", blendOpacity );
  // Pass the index of the blend mode to the shader
  myShader.set( "blendMode", blendIndex );
  
  //pg.beginDraw();
  pg.filter(myShader);
  // Apply the specified shader to any geometry drawn from this point  
  //shader(myShader);
  //pg.beginDraw();
  // Draw the output of the shader onto a rectangle that covers the whole viewport
  rect(0, 0, width, height);
  //pg.endDraw();
  
  //image(pg, 0, 0, width, height);


  // Call resetShader() so that further geometry remains unaffected by the shader
  //resetShader();

}




