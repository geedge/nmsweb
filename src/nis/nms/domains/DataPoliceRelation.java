package nis.nms.domains;



/**
 * DataPoliceRelation entity. @author MyEclipse Persistence Tools
 */

public class DataPoliceRelation  implements java.io.Serializable {


    // Fields    

     private long id;
     private DetectionSetInfo detectionSetInfo;
     private Metadata metadata;
     private String policeState;
     private String policeValue;
     private String policeUnit;
     private String policeSymbols;
     private Long policeLevel;
     private String policeShowInfo;
     private Long policeEmergent;
     private String marker;
     private Long markerFiledId;
     
    // Constructors

    /** default constructor */
    public DataPoliceRelation() {
    }

    
    /** full constructor */
    public DataPoliceRelation(DetectionSetInfo detectionSetInfo, Metadata metadata, String policeState, String policeValue, String policeUnit, String policeSymbols,Long policeLevel,String policeShowInfo) {
        this.detectionSetInfo = detectionSetInfo;
        this.metadata = metadata;
        this.policeState = policeState;
        this.policeValue = policeValue;
        this.policeUnit = policeUnit;
        this.policeSymbols = policeSymbols;
        this.policeLevel = policeLevel;
        this.policeShowInfo = policeShowInfo;
    }

   
    // Property accessors

    public long getId() {
        return this.id;
    }
    
    public void setId(long id) {
        this.id = id;
    }

    public DetectionSetInfo getDetectionSetInfo() {
        return this.detectionSetInfo;
    }
    
    public void setDetectionSetInfo(DetectionSetInfo detectionSetInfo) {
        this.detectionSetInfo = detectionSetInfo;
    }

    public Metadata getMetadata() {
        return this.metadata;
    }
    
    public void setMetadata(Metadata metadata) {
        this.metadata = metadata;
    }

    public String getPoliceState() {
        return this.policeState;
    }
    
    public void setPoliceState(String policeState) {
        this.policeState = policeState;
    }

    public String getPoliceValue() {
        return this.policeValue;
    }
    
    public void setPoliceValue(String policeValue) {
        this.policeValue = policeValue;
    }

    public String getPoliceUnit() {
        return this.policeUnit;
    }
    
    public void setPoliceUnit(String policeUnit) {
        this.policeUnit = policeUnit;
    }

    public String getPoliceSymbols() {
        return this.policeSymbols;
    }
    
    public void setPoliceSymbols(String policeSymbols) {
        this.policeSymbols = policeSymbols;
    }


	public Long getPoliceLevel() {
		return policeLevel;
	}


	public void setPoliceLevel(Long policeLevel) {
		this.policeLevel = policeLevel;
	}


	public String getPoliceShowInfo() {
		return policeShowInfo;
	}


	public void setPoliceShowInfo(String policeShowInfo) {
		this.policeShowInfo = policeShowInfo;
	}

	public Long getPoliceEmergent()
	{
		return policeEmergent;
	}

	public void setPoliceEmergent(Long policeEmergent)
	{
		this.policeEmergent = policeEmergent;
	}


	
	public String getMarker()
	{
		return marker;
	}


	
	public void setMarker(String marker)
	{
		this.marker = marker;
	}


	
	public Long getMarkerFiledId()
	{
		return markerFiledId;
	}


	
	public void setMarkerFiledId(Long markerFiledId)
	{
		this.markerFiledId = markerFiledId;
	}
}