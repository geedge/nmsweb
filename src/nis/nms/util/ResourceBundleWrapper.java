package nis.nms.util;

import java.util.ResourceBundle;
/**
 * ResourceBundle包装类
 * 解决：当配置文件没有key时抛出异常的的问题
 * @author fang
 *
 */
public class ResourceBundleWrapper {
	private ResourceBundle rb;
	public ResourceBundleWrapper(ResourceBundle rb) {
		this.rb = rb;
	}
	
	/**
	 * 当配置文件中没有配置key时，返回 null
	 * @param key
	 * @return
	 */
	public String getString(String key){
		return getString(key, null);
	}

	/**
	 * 当配置文件中没有key时，返回 def 默认值
	 * @param key
	 * @param def
	 * @return
	 */
	public String getString(String key,String def){
		if(rb.containsKey(key)){
			return rb.getString(key);
		}
		return def;
	}
	
	
	public boolean containsKey(String key){
		return rb.containsKey(key);
	}
	
	public ResourceBundle getRb() {
		return rb;
	}
	public void setRb(ResourceBundle rb) {
		this.rb = rb;
	}
	
}
