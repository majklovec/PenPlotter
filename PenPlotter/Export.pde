class Export extends Com
{
  BufferedWriter writer;
  boolean cnc;
  float originX;
  float originY;
  
  public Export(String ext)
  {
    if(".cnc".equals(ext))
    {
      cnc = true;
      originX = homeX;
      originY = homeY;
    }
    else
    {
      cnc = false;
      originX = 0;
      originY = 0;
    }
  }
  
  
  
  public void listPorts() {}

    public void disconnect() {}

    public void connect(int port) {}

    public void connect(String name) {
    }

    public void sendMotorOff() {}

    public void moveDeltaX(float x) {
        send("G0 X" + (x-originX) + "\n");
    }

    public void moveDeltaY(float y) {
        send("G0 Y" + (y-originY) + "\n");
    }

    public void sendMoveG0(float x, float y) {
        send("G0 X" + (x-originX) + " Y" + (y-originY) + "\n");
    }

    public void sendMoveG1(float x, float y) {
        send("G1 X" + (x-originX) + " Y" + (y-originY) + "\n");
    }

    public void sendG2(float x, float y, float i, float j) {
        send("G2 X" + (x-originX) + " Y" + (y-originY) + " I" + i + " J" + j + "\n");
    }

    public void sendG3(float x, float y, float i, float j) {
        send("G3 X" + (x-originX) + " Y" + (y-originY) + " I" + i + " J" + j + "\n");
    }

    public void sendSpeed(int speed) {
        send("G0 F" + speed + "\n");
    }

    public void sendHome() {}

    public void sendSpeed() {
        send("G0 F" + speedValue + "\n");
    }

    public void sendPenWidth() {}

    public void sendSpecs() {}

    public void sendPenUp() {
        if(cnc)
          send("G0 Z"+cncSafeHeight+"\n");
        else
        {
          send("G4 P"+servoDwell+"\n");
          send("M340 P3 S"+servoUpValue+"\n");
          send("G4 P"+servoDwell+"\n");
        }
    }

    public void sendPenDown() {
      if(cnc)
        send("G0 Z0\n");
      else
      {
        send("G4 P"+servoDwell+"\n");
        send("M340 P3 S"+servoDownValue+"\n");
        send("G4 P"+servoDwell+"\n");
      }
    }

    public void sendAbsolute() {
        send("G90\n");
    }

    public void sendRelative() {
        send("G91\n");
    }
    
    public void sendMM()
    {
      send("G21\n");
    }

    public void sendPixel(float da, float db, int pixelSize, int shade, int pixelDir) {}


    public void initArduino() {}

    public void clearQueue() {}

    public void queue(String msg) {}

    public void nextMsg() {}

    public void send(String msg) {
        try{
          writer.write(msg);
        } catch(Exception e)
        {
          e.printStackTrace();
          System.out.println(e);
        }
    }

    public void oksend(String msg) {}

    public void serialEvent() {}
    
    public void export(File file)
    {
          try {
               writer = new BufferedWriter(new FileWriter(file));               
                currentPlot.plot();
                while(currentPlot.isPlotting())
                  currentPlot.nextPlot(false);
                        
          } catch (IOException e) {
                System.out.print(e);
            } finally {
                try {
                    if (writer != null)
                        writer.close();
                } catch (IOException e) {
                }
            }
    }
}