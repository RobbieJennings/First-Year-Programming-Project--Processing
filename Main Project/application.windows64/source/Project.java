import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import org.gicentre.utils.stat.*; 
import java.util.Arrays; 
import java.util.*; 
import controlP5.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Project extends PApplet {

    // For chart classes.



//
ControlP5 cp5;

String textValue = "";
ArrayList<DataPoint> dataPoints = new ArrayList();
ArrayList<DataPoint> postcode = new ArrayList();
ArrayList<DataPoint> county = new ArrayList();
ArrayList<DataPoint> city = new ArrayList();
ArrayList<DataPoint> current = new ArrayList();

BarChart barChart;
Chart myChart;

String enquiry;
int lastEvent1;
int lastEvent2;

Widget widget1, widget2, widget3, widget4, widget5, widget6, widget7, widget8, widget9, widget10;
ArrayList widgetList;

PFont myFont;

ArrayList area;
DataPoint thisDataPoint;

public void settings()
{
  size( SCREENX, SCREENY ); 
}

public void setup()
{
  Table data = loadTable( "pp-10k.csv" );
  dataPoints = new ArrayList();

  PFont font = createFont("arial", 20);
  cp5 = new ControlP5(this);

  cp5.addTextfield("County")
    .setPosition(20, 525)
    .setSize(200, 40)
    .setFont(font)
    .setFocus(true)
    .setColor(color(255))
    .setColorCaptionLabel(color(20,20,20))
    .setFont(createFont("arial", 20));
    
  fill(255);
  ;
  cp5.addTextfield("Post Code")
    .setPosition(280, 525)
    .setSize(200, 40)
    .setFont(font)
    .setFocus(true)
    .setColor(color(255))
    .setColorCaptionLabel(color(20,20,20))
    .setFont(createFont("arial", 20));
  fill(255);
  ;
  cp5.addTextfield("City/Town")
    .setPosition(550, 525)
    .setSize(200, 40)
    .setFont(font)
    .setFocus(true)
    .setColor(color(255))
    .setColorCaptionLabel(color(20,20,20))
    .setFont(createFont("arial", 20));
  fill(255);
  ;

  //cp5.addBang("clear")
  //  .setPosition(350, 450)
  //  .setSize(80, 40)
  //  .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
  //  ;    

  textFont(font);

  dataPoints = new ArrayList();
  for( int index = 0; index < data.getRowCount(); index++ )
  {
     thisDataPoint = new DataPoint( data.getInt( index, PRICE ), data.getString( index, DATE_OF_SALE ), data.getString( index, POSTCODE ), 
      data.getString( index, PROPERTY_TYPE ), data.getString( index, OLD_NEW ), data.getString( index, NUM_NAME ), data.getString( index, STREET ),
      data.getString( index, LOCALITY ), data.getString( index, TOWN ), data.getString( index, DISTRICT ), data.getString( index, COUNTY ) );
    dataPoints.add( thisDataPoint );
  }
     
  current = dataPoints;
     
  barChart = new BarChart(this);
  myChart = new Chart(barChart);
  myChart.yAxis = prices( dataPoints );

  area = new ArrayList();

  myFont=loadFont("ComicSansMS-30.vlw");
  textFont(myFont, 10);

  widget1 = new Widget(10, 10, WIDGET_LENGTH / 2, WIDGET_HEIGHT,
  "Prices", color(currentColor),
  myFont, EVENT_BUTTON1, true);
  
  widget2 = new Widget(10, 50, WIDGET_LENGTH / 2, WIDGET_HEIGHT,
  "Type", color(currentColor),
  myFont, EVENT_BUTTON2, false); 
  
  widget3 = new Widget(10, 90, WIDGET_LENGTH / 2, WIDGET_HEIGHT,
  "Old/New", color(currentColor), 
  myFont, EVENT_BUTTON3, false);
  
  
  widget4 = new Widget(100, 10, WIDGET_LENGTH / 2, WIDGET_HEIGHT,
  "Bar Chart", color(currentColor),
  myFont, EVENT_BUTTON4, true);
  
  widget5 = new Widget(100, 50, WIDGET_LENGTH / 2, WIDGET_HEIGHT,
  "Table", color(currentColor),
  myFont, EVENT_BUTTON5, false); 
  
  widget6 = new Widget(100, 90, WIDGET_LENGTH / 2, WIDGET_HEIGHT,
  "Pie Chart", color(currentColor), 
  myFont, EVENT_BUTTON6, false);
  
  widget7 = new Widget(15, 130, WIDGET_LENGTH, WIDGET_HEIGHT,
  "Average Price", color(currentColor), 
  myFont, EVENT_BUTTON7, false);
  
  widget8 = new Widget(15, 170, WIDGET_LENGTH, WIDGET_HEIGHT,
  "Most Expensive", color(currentColor), 
  myFont, EVENT_BUTTON8, false);
  
  widget9 = new Widget(15, 210, WIDGET_LENGTH, WIDGET_HEIGHT,
  "Least Expensive", color(currentColor), 
  myFont, EVENT_BUTTON9, false);
  
  widget10 = new Widget(15, 450, WIDGET_LENGTH, WIDGET_HEIGHT,
  "All Properties", color(currentColor), 
  myFont, EVENT_BUTTON10, false);
  
  widgetList = new ArrayList();
  widgetList.add(widget1); widgetList.add(widget2); widgetList.add(widget3); widgetList.add(widget4); widgetList.add(widget5); 
  widgetList.add(widget6); widgetList.add(widget7); widgetList.add(widget8); widgetList.add(widget9); widgetList.add(widget10);
  
  lastEvent1 = EVENT_BUTTON1;
  lastEvent2 = EVENT_BUTTON2;
}

public void controlEvent(ControlEvent theEvent) {
  if (theEvent.isAssignableFrom(Textfield.class)) {
    for (int i = 0; i < dataPoints.size(); i++) {
      DataPoint thisDataPoint = ( DataPoint ) dataPoints.get(i);
      if ( thisDataPoint.county.contains( theEvent.getStringValue() ) )
        area.add(thisDataPoint);
    }
  
    String value = theEvent.getStringValue();
    //String temp = "LONDON";
    
    county = new ArrayList();
    postcode = new ArrayList();
    city = new ArrayList();
    
    for ( int i = 0; i < dataPoints.size(); i++) {
      DataPoint thisDataPoint = ( DataPoint ) dataPoints.get(i);
      if (thisDataPoint.county.equals(value)) {
        county.add(thisDataPoint);
        System.out.println(county.get(county.size() - 1));
        current = county;
        if( lastEvent1 == EVENT_BUTTON1 )
        {
          myChart.enquiry = "Property Prices";
          myChart.yAxis = prices( current );
        }
        else if( lastEvent1 == EVENT_BUTTON2 )
        {
          myChart.enquiry = "Property Type";
          myChart.yAxis = propertyType( current );
        }
        else if( lastEvent1 == EVENT_BUTTON3 )
        {
          myChart.enquiry = "Property Condition";
          myChart.yAxis = condition( current );
        }
      }
      if (thisDataPoint.postCode.equals(value)) {
        postcode.add(thisDataPoint);
        System.out.println(postcode.get(postcode.size()-1));
        current = postcode;
        if( lastEvent1 == EVENT_BUTTON1 )
        {
          myChart.enquiry = "Property Prices";
          myChart.yAxis = prices( current );
        }
        else if( lastEvent1 == EVENT_BUTTON2 )
        {
          myChart.enquiry = "Property Type";
          myChart.yAxis = propertyType( current );
        }
        else if( lastEvent1 == EVENT_BUTTON3 )
        {
          myChart.enquiry = "Property Condition";
          myChart.yAxis = condition( current );
        }
      }
      if (thisDataPoint.town.equals(value)) {
        city.add(thisDataPoint);
        System.out.println(city.get(city.size()-1));
        current = city;
        if( lastEvent1 == EVENT_BUTTON1 )
        {
          myChart.enquiry = "Property Prices";
          myChart.yAxis = prices( current );
        }
        else if( lastEvent1 == EVENT_BUTTON2 )
        {
          myChart.enquiry = "Property Type";
          myChart.yAxis = propertyType( current );
        }
        else if( lastEvent1 == EVENT_BUTTON3 )
        {
          myChart.enquiry = "Property Condition";
          myChart.yAxis = condition( current );
        }
      }
    }
  }
}

//ArrayList<DataPoint> totalData( ArrayList<DataPoint> county, ArrayList<DataPoint> postcode, ArrayList<DataPoint> city )
//{
//  ArrayList<DataPoint> totalData = new ArrayList();
//  for( int i = 0; i < county.size(); i++ )
//  {
//    DataPoint thisCountyDataPoint = county.get( i );
//    for( int j = 0; i < postcode.size(); j++ )
//    {
//      DataPoint thisPostcodeDataPoint = postcode.get( j );
//      for( int k = 0; k < city.size(); k++ )
//      {
//        DataPoint thisCityDataPoint = city.get( k );
//        if( thisCountyDataPoint.equals( thisPostcodeDataPoint ) && thisCountyDataPoint.equals( thisCityDataPoint ) )
//        {
//          totalData.add( thisCountyDataPoint );
//        }
//      }
//    }    
//  }
//  return totalData;
//}

public float[] prices( ArrayList dataPoints )
{
  float[] prices = new float[ 6 ];
  for( int index = 0; index < dataPoints.size(); index++ )
  {
    DataPoint thisDataPoint = ( DataPoint ) dataPoints.get( index );
    if( thisDataPoint.price < 100000 )
    {
      prices[ 0 ]++;
    }
    else if( thisDataPoint.price >= 100000 && thisDataPoint.price < 200000 )
    {
      prices[ 1 ]++;
    }
    else if( thisDataPoint.price >= 200000 && thisDataPoint.price < 300000 )
    {
      prices[ 2 ]++;
    }
    else if( thisDataPoint.price >= 300000 && thisDataPoint.price < 400000 )
    {
      prices[ 3 ]++;
    }
    else if( thisDataPoint.price >= 400000 && thisDataPoint.price < 500000 )
    {
      prices[ 4 ]++;
    }
    else if( thisDataPoint.price >= 500000 )
    {
      prices[ 5 ]++;
    }
  }
  return prices;
}

public float[] propertyType( ArrayList dataPoints )
{
  float[] propertyType = new float[ 5 ];
  for( int index = 0; index < dataPoints.size(); index++ )
  {
    DataPoint thisDataPoint = ( DataPoint ) dataPoints.get( index );
    if( thisDataPoint.propertyType.equals( "Detatched" ) )
    {
      propertyType[ 0 ]++;
    }
    else if( thisDataPoint.propertyType.equals( "Semi-Detatched" ) )
    {
      propertyType[ 1 ]++;
    }
    else if( thisDataPoint.propertyType.equals( "Terraced" ) )
    {
      propertyType[ 2 ]++;
    }
    else if( thisDataPoint.propertyType.equals( "Flats/Maisonettes" ) )
    {
      propertyType[ 3 ]++;
    }
    else if( thisDataPoint.propertyType.equals( "Other" ) )
    {
      propertyType[ 4 ]++;
    }
  }
  return propertyType;
}

public float[] condition( ArrayList dataPoints )
{
  float[] condition = new float[ 2 ];
  for( int index = 0; index < dataPoints.size(); index++ )
  {
    DataPoint thisDataPoint = ( DataPoint ) dataPoints.get( index );
    if( thisDataPoint.oldNew.equals( "Established Property" ) )
    {
      condition[ 0 ]++;
    }
    else if( thisDataPoint.oldNew.equals( "Newly Built Property" ) )
    {
      condition[ 1 ]++;
    }
  }
  return condition;
}

public void draw()
{
  background(220);
  if( lastEvent1 == EVENT_NULL || lastEvent1 == EVENT_BUTTON1 || lastEvent1 == EVENT_BUTTON2 || lastEvent1 == EVENT_BUTTON3 )
  myChart.draw();
  if( lastEvent1 == EVENT_BUTTON7 )
  {
    textSize(60);
    text( averagePrice( current ), 350, 200 );
    textSize(10);
  }
  if( lastEvent1 == EVENT_BUTTON8 )
  {
    ArrayList highestPrices = highestPrices( current );
    for( int i = 0; i < highestPrices.size(); i++ )
    {
      text( highestPrices.get(i).toString(), 200, 10 + ( ( i + 1 ) * 50 ) );
    }
  }
  if( lastEvent1 == EVENT_BUTTON9 )
  {
    ArrayList lowestPrices = lowestPrices( current );
    for( int i = 0; i < lowestPrices.size(); i++ )
    {
      text( lowestPrices.get(i).toString(), 200, 10 + ( ( i + 1 ) * 50 ) );
    }
  }
  
  for(int i = 0; i < widgetList.size(); i++){
    Widget aWidget = (Widget)widgetList.get(i);
    if(mouseX >= aWidget.x && mouseX <= aWidget.x + aWidget.width && mouseY >= aWidget.y && mouseY <= aWidget.y + aWidget.height)
    {
      stroke(255);
      aWidget.draw();
    }
    else
    {
      stroke(0);
      aWidget.draw();
    }
    noStroke();             
    fill(0);
  }
  text(textValue, 360, 180);
}

public void mousePressed(){
  int event;
  
  for(int i = 0; i<widgetList.size(); i++){
    Widget aWidget = (Widget) widgetList.get(i);
    event = aWidget.getEvent(mouseX,mouseY);
    switch(event) {
      case EVENT_BUTTON1:
        println("Price");
        lastEvent1 = EVENT_BUTTON1;
        myChart.enquiry = "Property Prices";
        myChart.yAxis = prices( current );
        widget1.selected = true;
        widget2.selected = false;
        widget3.selected = false;
        widget7.selected = false;
        widget8.selected = false;
        widget9.selected = false;
        break;
      case EVENT_BUTTON2:
        println("Type");
        lastEvent1 = EVENT_BUTTON2;
        myChart.enquiry = "Property Type";
        myChart.yAxis = propertyType( current );
        widget1.selected = false;
        widget2.selected = true;
        widget3.selected = false;
        widget7.selected = false;
        widget8.selected = false;
        widget9.selected = false;
        break;
      case EVENT_BUTTON3:
        println("Old/New");
        lastEvent1 = EVENT_BUTTON3;
        myChart.enquiry = "Property Condition";
        myChart.yAxis = condition( current );   
        widget1.selected = false;
        widget2.selected = false;
        widget3.selected = true;
        widget7.selected = false;
        widget8.selected = false;
        widget9.selected = false;
        break;
      case EVENT_BUTTON4:
        println("Bar Chart");
        lastEvent2 = EVENT_BUTTON4;
        myChart.chartType="barChart";
        widget4.selected = true;
        widget5.selected = false;
        widget6.selected = false;
        break;
      case EVENT_BUTTON5:
        println("Table");
        lastEvent2 = EVENT_BUTTON5;
        widget4.selected = false;
        widget5.selected = true;
        widget6.selected = false;
        myChart.chartType="table";
        break;
      case EVENT_BUTTON6:
        println("Pie Chart");
        lastEvent2 = EVENT_BUTTON6;
        widget4.selected = false;
        widget5.selected = false;
        widget6.selected = true;
        myChart.chartType = "pieChart";
        break;
      case EVENT_BUTTON7:
        println("Averages");
        lastEvent1 = EVENT_BUTTON7;
        lastEvent2 = EVENT_NULL;
        widget1.selected = false;
        widget2.selected = false;
        widget3.selected = false;
        widget7.selected = true;
        widget8.selected = false;
        widget9.selected = false;
        break;
      case EVENT_BUTTON8:
        println("Most Expensive");
        lastEvent1 = EVENT_BUTTON8;
        lastEvent2 = EVENT_NULL;
        widget1.selected = false;
        widget2.selected = false;
        widget3.selected = false;
        widget7.selected = false;
        widget8.selected = true;
        widget9.selected = false;
        break;
      case EVENT_BUTTON9:
        println("Least Expensive");
        lastEvent1 = EVENT_BUTTON9;
        lastEvent2 = EVENT_NULL;
        widget1.selected = false;
        widget2.selected = false;
        widget3.selected = false;
        widget7.selected = false;
        widget8.selected = false;
        widget9.selected = true;
        break;
      case EVENT_BUTTON10:
        println("All Properties");
        current = dataPoints;
        if( lastEvent1 == EVENT_BUTTON1 )
        {
          myChart.enquiry = "Property Prices";
          myChart.yAxis = prices( current );
        }
        else if( lastEvent1 == EVENT_BUTTON2 )
        {
          myChart.enquiry = "Property Type";
          myChart.yAxis = propertyType( current );
        }
        else if( lastEvent1 == EVENT_BUTTON3 )
        {
          myChart.enquiry = "Property Condition";
          myChart.yAxis = condition( current );
        }
        break;
    } 
  }
}

public ArrayList sortPrices(ArrayList<DataPoint> dataPoints)
{
  float[] prices = new float[dataPoints.size()];
  for(int i = 0; i < dataPoints.size(); i++)
  {
    prices[i] = (dataPoints.get(i)).getPrice();
  }
  Arrays.sort(prices);
  ArrayList<DataPoint> dataPointsInOrder = new ArrayList<DataPoint>();
  for(int j = 0; j < prices.length; j++)
  {
    for(int k = 0; k < dataPoints.size(); k++)
    {
       if(prices[j] == dataPoints.get(k).getPrice())
       {
         dataPointsInOrder.add(dataPoints.get(k));       
       }
    }
  }
  return dataPointsInOrder;
}

public int averagePrice(ArrayList dataPoints)
{
  float averagePrice;
  float total = 0;
  for(int i = 0; i < dataPoints.size(); i++)
  {
    DataPoint thisDataPoint = (DataPoint) dataPoints.get(i);
    total += thisDataPoint.getPrice();
  }
  averagePrice = total / dataPoints.size();
  return (int) averagePrice;
}
  
public ArrayList highestPrices(ArrayList dataPoints)
{
   ArrayList dataPointsInOrder = sortPrices( dataPoints );
   ArrayList highestPrices = new ArrayList( );
   for( int i = dataPointsInOrder.size() - 1; i > dataPointsInOrder.size() - 10; i-- )
   {
     if( i >= 0 )
     {
       highestPrices.add( dataPointsInOrder.get( i ) );
     }
   }
   return highestPrices;
}

public ArrayList lowestPrices(ArrayList dataPoints){
   ArrayList dataPointsInOrder = sortPrices( dataPoints );
   ArrayList lowestPrices = new ArrayList();
   for( int i = 0; i < 9; i++ )
   {
     if( i < dataPointsInOrder.size() )
     {
       lowestPrices.add( dataPointsInOrder.get( i ) );
     }  
   }
   return lowestPrices;
}

public void clear() {
  cp5.get(Textfield.class, "textValue").clear();
}
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
      barChart.setBarGap(PApplet.parseFloat(5));
      barChart.showValueAxis(true);
      barChart.showCategoryAxis(true);
      this.chartType="barChart";
      this.enquiry="Property Prices";
  }
  
  public void draw(){
      textSize(16);
      setEnquiry();
      setChartType();
      textSize(10);
  }
  
  public void setEnquiry(){
      if(enquiry.equals("Property Prices")){
          if(chartType.equals("barChart")){
            priceRanges = new String[]{"< \u20ac100k","\u20ac100k - \n\u20ac200k","\u20ac200k - \n\u20ac300k","\u20ac300k - \n\u20ac400k","\u20ac400k - \n\u20ac500k","\u20ac500k+"};
          }
          else priceRanges = new String[]{" < \u20ac100k"," \u20ac100k - \u20ac200k"," \u20ac200k - \u20ac300k"," \u20ac300k - \u20ac400k"," \u20ac400k - \u20ac500k"," \u20ac500k+"};
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
  
  public void setChartType(){
      if(chartType.equals("barChart")){
        text(enquiry, 480, 480);
        text("  Number\n      Of\nProperties", 180, 294);
        barChart.setData(yAxis);
        barChart.setBarLabels(xAxis);
        barChart.draw(280, 30,width/1.5f,height/1.5f);
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
  
  public void pieChart(float diameter, float[] data, float[] angles) {
      float lastAngle = 0;
      for (int i = 0; i < data.length; i++) {
        float colour = map(i, 0, data.length, 60, 240);
        fill(0,colour,colour);
        arc(580, 210, diameter, diameter, lastAngle+rotate, lastAngle+radians(angles[i])+rotate);
        lastAngle += radians(angles[i]);
      }
      //rotate+=0.01;
  }
  
  public void table(){
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
final int SCREENX = 800;
final int SCREENY = 600;

final int PRICE = 0;
final int DATE_OF_SALE = 1;
final int POSTCODE = 2;
final int PROPERTY_TYPE = 3;
final int OLD_NEW = 4;
final int NUM_NAME = 5;
final int STREET = 6;
final int LOCALITY = 7;
final int TOWN = 8;
final int DISTRICT = 9;
final int COUNTY = 10;

final int EVENT_NULL=0;
final int EVENT_BUTTON1=1;
final int EVENT_BUTTON2=2;
final int EVENT_BUTTON3 = 3;
final int EVENT_BUTTON4 = 4;
final int EVENT_BUTTON5 = 5;
final int EVENT_BUTTON6 = 6;
final int EVENT_BUTTON7 = 7;
final int EVENT_BUTTON8 = 8;
final int EVENT_BUTTON9 = 9;
final int EVENT_BUTTON10 = 10;
final int WIDGET_LENGTH = 150;
final int WIDGET_HEIGHT = 20;

final int Red = color(255, 0, 0);
final int Green = color(0, 255, 0);
final int Blue = color(0, 0, 255);
final int currentColor = color(255);
// Robert from here until line 59
class DataPoint
{
  int price;
  String[] dateOfSale, timeOfSale;
  int yearOfSale, monthOfSale, dayOfSale, hourOfSale, minuteOfSale;
  String postCode, propertyType, oldNew, numName, street, locality, town, district, county;

  DataPoint( int price, String dateOfSale, String postCode, String propertyType, String oldNew, String numName, String street, String locality, String town, String district, String county )
  {
    this.price = price;
    this.dateOfSale = dateOfSale.split( " " );
    this.timeOfSale = this.dateOfSale[ 1 ].split( ":" );
    this.dateOfSale = this.dateOfSale[ 0 ].split( "/" );
    this.yearOfSale = Integer.parseInt( this.dateOfSale[ 0 ] );
    this.monthOfSale = Integer.parseInt( this.dateOfSale[ 1 ] );
    this.dayOfSale = Integer.parseInt( this.dateOfSale[ 2 ] );
    this.hourOfSale = Integer.parseInt( this.timeOfSale[ 0 ] );
    this.minuteOfSale = Integer.parseInt( this.timeOfSale[ 1 ] );
    this.postCode = postCode;
    this.propertyType = "";
    if( propertyType.equals( "D" ) )
    {
      this.propertyType = "Detatched";
    }
    else if( propertyType.equals( "S" ) )
    {
      this.propertyType = "Semi-Detatched";
    }
    else if( propertyType.equals( "T" ) )
    {
      this.propertyType = "Terraced";
    }
    else if( propertyType.equals( "F" ) )
    {
      this.propertyType = "Flats/Maisonettes";
    }
    else if( propertyType.equals( "O" ) )
    {
      this.propertyType = "Other";
    }
    this.oldNew = "";
    if( oldNew.equals( "N" ) )
    {
      this.oldNew = "Newly Built Property";
    }
    else if( oldNew.equals( "Y" ) )
    {
      this.oldNew = "Established Property";
    }
    this.numName = numName;
    this.street = street;
    this.locality = locality;
    this.town = town;
    this.district = district;
    this.county = county;
  }
  
  //Robbies work up to this point, after this point is Claire's work
  
  public int getPrice() {                                                
    return price;
  }

  public String getDateOfSale() {
    return dayOfSale + "/" + monthOfSale + "/" + yearOfSale + " " + hourOfSale + ":" + minuteOfSale;
  }

  public String getPostcode() {
    return postCode;
  }

  public String getPropertyType() {
    return propertyType;
  }

  public String getOldNew() {
    return oldNew;
  }

  public String getHouseNumberOrName() {
    return numName;
  }

  public String getStreet() {
    return street;
  }

  public String getLocality() {
    return locality;
  }

  public String getTown() {
    return town;
  }

  public String getDistrict() {
    return district;
  }

  public String getCounty() {
    return county;
  }

  public String toString() {
    return price + ", " + dayOfSale + "/" + monthOfSale + "/" + yearOfSale + " " + hourOfSale + ":" + minuteOfSale + ", " + postCode + ", " + propertyType + ", " + oldNew + ", " +numName + "\n" + street + ", " + locality + ", " + town + ", " + district + ", " + county  ;
  } 
}
class Widget {
  int x, y, width, height;
  String label; 
  int event;
  int widgetColor, labelColor;
  PFont widgetFont;
  boolean selected;

  Widget(int x,int y, int width, int height, String label,
  int widgetColor, PFont widgetFont, int event, boolean selected){
    this.x=x;
    this.y=y;
    this.width = width; 
    this.height= height;
    this.label=label;
    this.event=event; 
    this.widgetColor=widgetColor; 
    this.widgetFont=widgetFont;
    labelColor= color(0);
    this.selected = selected;
   }
   
  public void draw(){
    if( selected )
    {
      widgetColor = color(255, 215, 0);
    }
    else
    {
      widgetColor = color(255);
    }
    fill(widgetColor);
    rect(x,y,width,height);
    fill(labelColor);
    text(label, x+10, y+height-10);
  }
  public int getEvent(int mX, int mY){
    
     if(mX>x && mX < x+width && mY >y && mY <y+height )
     {
       return event;
     }
     else
     {
       return EVENT_NULL;
     }
  }
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--present", "--window-color=#666666", "--stop-color=#cccccc", "Project" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
