package com.nms.objectSnmp.impl;


import java.io.File;
import java.io.FileOutputStream;
import java.io.PrintStream;

import nis.nms.util.BaseAction;
import nis.nms.util.Constant;

import org.apache.log4j.Logger;

import com.zhtelecom.common.snmp.impl.SNMPAPIImpl;
import com.zhtelecom.mib.MibType;
import com.zhtelecom.mib.MibValueSymbol;
import com.zhtelecom.mib.snmp.SnmpObjectType;


public class GenJavaCodeTool
{
	public GenJavaCodeTool()
	{
	}

	public static String getType(SnmpObjectType snmpobjecttype)
	{
		MibType mibtype = snmpobjecttype.getSyntax();
		if (mibtype.hasTag(0, 2))
			return "int";
		if (mibtype.hasTag(1, 1))
			return "long";
		if (mibtype.hasTag(1, 2))
			return "long";
		if (mibtype.hasTag(0, 4))
			return "String";
		if (mibtype.hasTag(0, 6))
			return "String";
		if (mibtype.hasTag(1, 0))
			return "String";
		if (mibtype.hasTag(1, 3))
			return "long";
		if (mibtype.hasTag(1, 4))
			return "String";
		if (mibtype.hasTag(1, 6))
		{
			return "long";
		} else
		{
			Logger.getLogger(GenJavaCodeTool.class).debug((new StringBuilder("未知的SNMP MIB数据类型: ")).append(mibtype).append("，  将用String类型来映射（仅用于SNMP查询操作）").toString());
			return "String";
		}
	}

	public static void genJavaCode(SNMPAPIImpl snmpapi,String entityName, String oid) throws Exception
	{
		Logger.getLogger(GenJavaCodeTool.class).debug("开始执行生成javaBean");
		String errorMsg="";
		try
		{
			PrintStream out =  System.out;
			System.out.println(Constant.JAVABEAN_PATH);
			File file = new File(Constant.JAVABEAN_PATH);
			if(!file.exists()){//如果路径不存在 则创建
				file.mkdirs();
			}
			MibValueSymbol mibvaluesymbol = snmpapi.getMibSymbolByOid(oid);
			//table 和 Column 禁止创建
			if(!mibvaluesymbol.isTable() && !mibvaluesymbol.isTableColumn()){
				PrintStream printstream = new PrintStream(new FileOutputStream((new StringBuilder(String.valueOf(Constant.JAVABEAN_PATH))).append(entityName).append(".java").toString()));
				System.setOut(printstream);
				System.out.println((new StringBuilder("package ")).append(Constant.PACKAGE_NAME).append(" ;").toString());
				System.out.println("//GenJavaCodeTool, auto create OM Object!");
				System.out.println((new StringBuilder("public class ")).append(entityName.toUpperCase()).append(" extends  com.zhtelecom.common.snmp.OMMappingInfo").toString());
				System.out.println("{");
				System.out.println("    private static final long serialVersionUID = 1L;");
				System.out.println();
				MibValueSymbol amibvaluesymbol[] = mibvaluesymbol.getChildren();
				for (int i = 0; i < amibvaluesymbol.length; i++)
				{
					MibValueSymbol mibvaluesymbol1 = amibvaluesymbol[i];
					if (!mibvaluesymbol1.isTable() && !mibvaluesymbol1.isTableRow())
					{
						String s2 = mibvaluesymbol1.getName();
						SnmpObjectType snmpobjecttype = (SnmpObjectType)mibvaluesymbol1.getType();
						String s5 = getType(snmpobjecttype);
						System.out.println((new StringBuilder("    private ")).append(s5).append(" ").append(s2).append(" ;").toString());
						System.out.println();
					}
				}

				System.out.println("    public String toString()");
				System.out.println("    {");
				StringBuffer stringbuffer = new StringBuffer("        return ");
				for (int j = 0; j < amibvaluesymbol.length; j++)
				{
					MibValueSymbol mibvaluesymbol2 = amibvaluesymbol[j];
					if (!mibvaluesymbol2.isTable() && !mibvaluesymbol2.isTableRow())
					{
						String s3 = mibvaluesymbol2.getName();
						stringbuffer.append((new StringBuilder("\"")).append(s3).append("=\"+").append(s3).append("+\"|\"+").toString());
					}
				}

				stringbuffer.deleteCharAt(stringbuffer.length() - 1);
				stringbuffer.append(" ;");
				System.out.println(stringbuffer);
				System.out.println("    }");
				System.out.println();
				System.out.println("    public String getMappingOID()");
				System.out.println("    {");
				System.out.println((new StringBuilder("        return \"")).append(oid).append("\";").toString());
				System.out.println("    }");
				for (int k = 0; k < amibvaluesymbol.length; k++)
				{
					MibValueSymbol mibvaluesymbol3 = amibvaluesymbol[k];
					if (!mibvaluesymbol3.isTable() && !mibvaluesymbol3.isTableRow())
					{
						String s4 = mibvaluesymbol3.getName();
						SnmpObjectType snmpobjecttype1 = (SnmpObjectType)mibvaluesymbol3.getType();
						String s6 = getType(snmpobjecttype1);
						String s7 = s4.replaceFirst(s4.substring(0, 1), s4.substring(0, 1).toUpperCase());
						System.out.println((new StringBuilder("    public ")).append(s6).append(" get").append(s7).append("()").toString());
						System.out.println("    {");
						System.out.println((new StringBuilder("        return ")).append(s4).append(" ;").toString());
						System.out.println("    }");
						System.out.println((new StringBuilder("    public void set")).append(s7).append("(").append(s6).append(" value)").toString());
						System.out.println("    {");
						System.out.println((new StringBuilder("        ")).append(s4).append("=value ;").toString());
						System.out.println("    }");
					}
				}

				System.out.println("}");
				printstream.close();
				//System.setOut(null);
				System.setOut(out);
				Logger.getLogger(GenJavaCodeTool.class).debug("生成javaBean成功！");
			}else{
				errorMsg="i18n_GenJavaCodeTool.genJavaCode.nodeInfoErr_n81i";
				throw new Exception();
			}
		}
		catch (Exception exception)
		{
			errorMsg = "i18n_GenJavaCodeTool.genJavaCode.cannotFind_n81i";
			Logger.getLogger(GenJavaCodeTool.class).error("Failed to generate javaBean!The MIB definition of this OID is not found",exception);
			throw new Exception("i18n_GenJavaCodeTool.genJavaCode.createBeanErr_n81i"+errorMsg);
		}
		
	}
}
