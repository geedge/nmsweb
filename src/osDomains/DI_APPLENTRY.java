package osDomains ;
//GenJavaCodeTool, auto create OM Object!
public class DI_APPLENTRY extends  com.zhtelecom.common.snmp.OMMappingInfo
{
    private static final long serialVersionUID = 1L;

    private int applIndex ;

    private String applName ;

    private String applDirectoryName ;

    private String applVersion ;

    private long applUptime ;

    private int applOperStatus ;

    private long applLastChange ;

    private long applInboundAssociations ;

    private long applOutboundAssociations ;

    private long applAccumulatedInboundAssociations ;

    private long applAccumulatedOutboundAssociations ;

    private long applLastInboundActivity ;

    private long applLastOutboundActivity ;

    private long applRejectedInboundAssociations ;

    private long applFailedOutboundAssociations ;

    public String toString()
    {
        return "applIndex="+applIndex+"|"+"applName="+applName+"|"+"applDirectoryName="+applDirectoryName+"|"+"applVersion="+applVersion+"|"+"applUptime="+applUptime+"|"+"applOperStatus="+applOperStatus+"|"+"applLastChange="+applLastChange+"|"+"applInboundAssociations="+applInboundAssociations+"|"+"applOutboundAssociations="+applOutboundAssociations+"|"+"applAccumulatedInboundAssociations="+applAccumulatedInboundAssociations+"|"+"applAccumulatedOutboundAssociations="+applAccumulatedOutboundAssociations+"|"+"applLastInboundActivity="+applLastInboundActivity+"|"+"applLastOutboundActivity="+applLastOutboundActivity+"|"+"applRejectedInboundAssociations="+applRejectedInboundAssociations+"|"+"applFailedOutboundAssociations="+applFailedOutboundAssociations+"|" ;
    }

    public String getMappingOID()
    {
        return "1.3.6.1.2.1.27.1.1";
    }
    public int getApplIndex()
    {
        return applIndex ;
    }
    public void setApplIndex(int value)
    {
        applIndex=value ;
    }
    public String getApplName()
    {
        return applName ;
    }
    public void setApplName(String value)
    {
        applName=value ;
    }
    public String getApplDirectoryName()
    {
        return applDirectoryName ;
    }
    public void setApplDirectoryName(String value)
    {
        applDirectoryName=value ;
    }
    public String getApplVersion()
    {
        return applVersion ;
    }
    public void setApplVersion(String value)
    {
        applVersion=value ;
    }
    public long getApplUptime()
    {
        return applUptime ;
    }
    public void setApplUptime(long value)
    {
        applUptime=value ;
    }
    public int getApplOperStatus()
    {
        return applOperStatus ;
    }
    public void setApplOperStatus(int value)
    {
        applOperStatus=value ;
    }
    public long getApplLastChange()
    {
        return applLastChange ;
    }
    public void setApplLastChange(long value)
    {
        applLastChange=value ;
    }
    public long getApplInboundAssociations()
    {
        return applInboundAssociations ;
    }
    public void setApplInboundAssociations(long value)
    {
        applInboundAssociations=value ;
    }
    public long getApplOutboundAssociations()
    {
        return applOutboundAssociations ;
    }
    public void setApplOutboundAssociations(long value)
    {
        applOutboundAssociations=value ;
    }
    public long getApplAccumulatedInboundAssociations()
    {
        return applAccumulatedInboundAssociations ;
    }
    public void setApplAccumulatedInboundAssociations(long value)
    {
        applAccumulatedInboundAssociations=value ;
    }
    public long getApplAccumulatedOutboundAssociations()
    {
        return applAccumulatedOutboundAssociations ;
    }
    public void setApplAccumulatedOutboundAssociations(long value)
    {
        applAccumulatedOutboundAssociations=value ;
    }
    public long getApplLastInboundActivity()
    {
        return applLastInboundActivity ;
    }
    public void setApplLastInboundActivity(long value)
    {
        applLastInboundActivity=value ;
    }
    public long getApplLastOutboundActivity()
    {
        return applLastOutboundActivity ;
    }
    public void setApplLastOutboundActivity(long value)
    {
        applLastOutboundActivity=value ;
    }
    public long getApplRejectedInboundAssociations()
    {
        return applRejectedInboundAssociations ;
    }
    public void setApplRejectedInboundAssociations(long value)
    {
        applRejectedInboundAssociations=value ;
    }
    public long getApplFailedOutboundAssociations()
    {
        return applFailedOutboundAssociations ;
    }
    public void setApplFailedOutboundAssociations(long value)
    {
        applFailedOutboundAssociations=value ;
    }
}
