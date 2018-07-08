// Chart class written by david scolard.

class Chart{
  
  String[] xAxis; 
  float[] yAxis;
  String[] priceRanges;
  String enquiry;
  String chartType;
  float rotate=0;
  
  Chart(BarChart barChart){
      barChart.setMinValue(0);
      barChart.setBarColour(color(57,87,255));
      barChart.setBarGap(float(5));
      barChart.showValueAxis(true);
      barChart.showCategoryAxis(true);
      this.chartType="barChart";
      this.enquiry="Property Prices";
  }
  
  void draw(){
      textSize(16);
      setEnquiry();
      setChartType();
      textSize(10);
  }
  
  void setEnquiry(){
      if(enquiry.equals("Property Prices")){
          if(chartType.equals("barChart")){
            priceRanges = new String[]{"< €100k","€100k - \n€200k","€200k - \n€300k","€300k - \n€400k","€400k - \n€500k","€500k+"};
          }
          else priceRanges = new String[]{" < €100k"," €100k - €200k"," €200k - €300k"," €300k - €400k"," €400k - €500k"," €500k+"};
          this.xAxis = priceRanges;
          return;
      }
      
      else if(enquiry.equals("Property Condition")){
          String[] conditions = {"Established Property","Newly Built"};
          this.xAxis = conditions;
          return;
      }
      
      else if(enquiry.equals("Property Type")){
          String[] types =  {"Detached","Semi-D","Terraced","Flats", "Other"};
          this.xAxis = types;
      }
  }
  
  void setChartType(){
      if(chartType.equals("barChart")){
        text(enquiry, 480, 480);
        text("  Number\n      Of\nProperties", 180, 294);
        barChart.setData(yAxis);
        barChart.setBarLabels(xAxis);
        barChart.draw(280, 30,width/1.5,height/1.5);
        return;
      }
      
      if(chartType.equals("pieChart")){
        float[] angles = new float[yAxis.length];
        int total = 0;
        for(int i=0; i<yAxis.length; i++){
          total+=yAxis[i];
        }
        text(enquiry, 270, 60);
        stroke(0);
        line(260, 70, 440, 70);
        int textYPos = 100;
        for(int i=0; i<angles.length; i++){
          float percentage = yAxis[i]/total;
          angles[i]=percentage*360;
          String display = (int)(percentage*100)+"%"+": "+xAxis[i];
          text(display, 270, textYPos);
          textYPos+=20;
        }
        pieChart(300, angles, angles);
        return;
    }
    
    if(chartType.equals("table")){
      table();
    }
  }
  
  void pieChart(float diameter, float[] data, float[] angles) {
      float lastAngle = 0;
      for (int i = 0; i < data.length; i++) {
        float colour = map(i, 0, data.length, 60, 240);
        fill(0,colour,colour);
        arc(580, 210, diameter, diameter, lastAngle+rotate, lastAngle+radians(angles[i])+rotate);
        lastAngle += radians(angles[i]);
      }
      //rotate+=0.01;
  }
  
  void table(){
    int yPos = 120;   
    
    stroke(150);
    line(565, 30+370, 565, 30);
    line(380, yPos-35, 380+375, yPos-35);
    
    text(this.enquiry, 400, yPos-50);
    text("Number of Properties", 600, yPos-50);
    
    for(int i=0; i<xAxis.length; i++){
      text(this.xAxis[i], 400, yPos);
      text((int)this.yAxis[i], 650, yPos);
      yPos+=30;
    }
  }
}