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