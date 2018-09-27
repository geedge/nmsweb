package nis.nms.domains;

import java.util.List;

/**
 * Brand entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class SetDetDataCon implements java.io.Serializable {

	// Fields

	private Long id;
	private String menuName;
	private String policeLevel;//,1,2,4,
	private String policeEmergent;//,0,1,
	private String policeLevelForShow;//,1,2,4,
	private String policeEmergentFowShow;//,0,1,
	
	// Constructors

	/** default constructor */
	public SetDetDataCon() {
	}

	/** full constructor */
	public SetDetDataCon(String menuName, String policeLevel, String policeEmergent) {
		this.menuName = menuName;
		this.policeLevel = policeLevel;
		this.policeEmergent = policeEmergent;
	}

	// Property accessors
	
	public Long getId()
	{
		return id;
	}

	
	public void setId(Long id)
	{
		this.id = id;
	}

	
	public String getMenuName()
	{
		return menuName;
	}

	
	public void setMenuName(String menuName)
	{
		this.menuName = menuName;
	}

	
	public String getPoliceLevel()
	{
		return policeLevel;
	}

	
	public void setPoliceLevel(String policeLevel)
	{
		this.policeLevel = policeLevel;
	}

	
	public String getPoliceEmergent()
	{
		return policeEmergent;
	}

	
	public void setPoliceEmergent(String policeEmergent)
	{
		this.policeEmergent = policeEmergent;
	}

	
	public String getPoliceLevelForShow()
	{
		return policeLevelForShow;
	}

	
	public void setPoliceLevelForShow(String policeLevelForShow)
	{
		this.policeLevelForShow = policeLevelForShow;
	}

	
	public String getPoliceEmergentFowShow()
	{
		return policeEmergentFowShow;
	}

	
	public void setPoliceEmergentFowShow(String policeEmergentFowShow)
	{
		this.policeEmergentFowShow = policeEmergentFowShow;
	}

	
}