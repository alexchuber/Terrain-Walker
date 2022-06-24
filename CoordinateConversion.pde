// **CREDIT to my professor for this file. (Don't want to namedrop in case this repo is indexed on search engines.)
// Convert a Cartesian X/Y coordinate to a hex coordinate
// Inputs:
//    x         -- The x-coordinate to be converted
//    y         -- The y-coordinate to be converted
//    hexRadius -- The radius of the hexagons
//    stepScale -- The scale of a "step" between hexagons (1.0f should be the default, higher if there is any gap)
//    xOrigin   -- The x "origin" of your coordinates, if you're starting from somewhere other than 0, 0
//    yOrigin   -- The y "origin" of your coordinates, if you're starting from somewhere other than 0, 0
//
// Return: A PVector containing the x, y value of an equivalent hex
//
/* Usage examples -- assuming:
    - a radius of 30,
    - no "gap" between hexes (i.e. a scale of 1.0f)
    - the first hexagon is centered at 0, 0,
    - then you could call this function with:
    CartesianToHex(anyX, anyY, 30, 1.0f, 0, 0);
    
    Given:
    - a radius of 42,
    - setting the "gap" to 5% of the distance between polygons (i.e. a scale of 1.05f)
    - the first hexagon is centered at the screen center (width/2, height/2),
    - then you could call this function with:
    CartesianToHex(anyX, anyY, 42, 1.05f, width/2, height/2);
*/
public PVector CartesianToHex(float xPos, float yPos, float hexRadius, float stepScale, float xOrigin, float yOrigin)
{
  float startX = xPos - xOrigin;
  float startY = yPos - yOrigin;

  float col = (2.0/3.0f * startX) / (hexRadius * stepScale);
  float row = (-1.0f/3.0f * startX + 1/sqrt(3.0f) * startY) / (hexRadius * stepScale);
  
  /*===== Convert to Cube Coordinates =====*/
  float x = col;
  float z = row;
  float y = -x - z; // x + y + z = 0 in this system
  
  float roundX = round(x);
  float roundY = round(y);
  float roundZ = round(z);
  
  float xDiff = abs(roundX - x);
  float yDiff = abs(roundY - y);
  float zDiff = abs(roundZ - z);
  
  if (xDiff > yDiff && xDiff > zDiff)
    roundX = -roundY - roundZ;
  else if (yDiff > zDiff)
    roundY = -roundX - roundZ;
  else
    roundZ = -roundX - roundY;
    
  /*===== Convert Cube to Axial Coordinates =====*/
  PVector result = new PVector(roundX, roundZ);
  
  return result;
}
