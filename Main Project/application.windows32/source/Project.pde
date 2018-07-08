import org.gicentre.utils.stat.*;    // For chart classes.
import java.util.Arrays;
import java.util.*;
import controlP5.*;
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

void settings()
{
  size( SCREENX, SCREENY ); 
}

void setup()
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
  size(400, 400);
  
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

void controlEvent(ControlEvent theEvent) {
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

float[] prices( ArrayList dataPoints )
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

float[] propertyType( ArrayList dataPoints )
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

float[] condition( ArrayList dataPoints )
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

void draw()
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

void mousePressed(){
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

ArrayList sortPrices(ArrayList<DataPoint> dataPoints)
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

int averagePrice(ArrayList dataPoints)
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
  
ArrayList highestPrices(ArrayList dataPoints)
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

ArrayList lowestPrices(ArrayList dataPoints){
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