PShader myShader;


void setup() {

  size( 512, 512, P2D );


  // Load the shader file from the "data" folder
  myShader = loadShader( "shader.glsl" );
  
  // Pass the dimensions of the viewport to the shader
  myShader.set( "iResolution", float(width), float(height),0 );
 
 
 
}


void draw() {
  background(0);
  
  myShader.set( "iGlobalTime", float(millis())/500);
 
  shader(myShader);

  // Draw the output of the shader onto a rectangle that covers the whole viewport
  rect(0, 0, width, height);

  // Call resetShader() so that further geometry remains unaffected by the shader
  resetShader();


}


