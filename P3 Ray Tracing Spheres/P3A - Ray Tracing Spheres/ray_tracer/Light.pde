public class Light {

  public Vector position;
  public Color c;
  
  public Light(Vector position, Color c) {
    this.position = position;
    this.c = c;
  }
  
  public Light(Vector position) {
    this(position, new Color());
  }
  
  public Light(Color c) {
    this(new Vector(), c);
  }
  
  public Vector getPosition() {
    return this.position;
  }
  
  public Color getColor() {
    return this.c;
  }
  
  public void setPosition(Vector position) {
    this.position = position;
  }
  
  public void setColor(Color c) {
    this.c = c;
  }
  
  public String toString() {
    String s = "Light position: " + this.position.toString() +
                     "\t color: " + this.c.toString() + "\n";
    return s;
  }
}
