package nis.nms.web;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.util.HashSet;
import java.util.Map.Entry;
import java.util.Properties;
import java.util.Set;

import org.apache.log4j.Logger;

public class Test {
	static Logger logger = Logger.getLogger(Test.class);

	public static void main(String[] args) {

		File out = new File("D:\\wwr\\ru.txt");
		File ru = new File("D:\\wwr\\ru翻译-181017.txt");

		try {
			BufferedReader ruReader = new BufferedReader(new FileReader(ru));
			BufferedReader outReader = new BufferedReader(new FileReader(out));
			Properties ruProp = new Properties();
			ruProp.load(ruReader);
			Properties outProp = new Properties();
			outProp.load(outReader);

			Set<Entry<Object, Object>> entrySet = ruProp.entrySet();
			for (Entry<Object, Object> entry : entrySet) {
				String key = (String) entry.getKey();
				String zhValue = outProp.getProperty(key);
				String ruValue = ruProp.getProperty(key);
				if (zhValue != null) {
					System.out.println("#########" + zhValue + "#############");
					Set<Entry<Object, Object>> outEntrySet = outProp.entrySet();
					for (Entry<Object, Object> entry2 : outEntrySet) {
						String temp = (String) entry2.getValue();

						if (zhValue.equals(temp)) {
							System.out.println((String) entry2.getKey() + "--> " + ruValue);
						}

					}
				}
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

}
