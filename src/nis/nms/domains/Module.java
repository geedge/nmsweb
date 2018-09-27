/**
 * Module.java
 * 版权所有(C) 2010 北京中科智源育成信息技术有限公司
 * @author ZhengXi
 * @date 2010-11-19
 * @version V1.0
 */
package nis.nms.domains;

/**
 * 桌面组件对象属性载体
 * 
 * @author ZhengXi
 * @version V1.0
 */
public class Module {
	private int id; // 主键id
	private String icon; // 图标路径
	private String title; // 组件标题
	private String url; // 访问路径

	private boolean showIcon = true;// 是否在桌面显示
	private boolean cashe = false;// 是否缓存
	private int width; // 组件窗口宽度
	private int height; // 组件窗口高度
	private int top; // 组件窗口默认top
	private int left; // 组件窗口默认left

	private String key; // 拼音首字母字符串
	private String pinyin; // 全拼字母字符串

	public Module() {
	}

	public Module(int id, String icon, String title, String url,
			boolean showIcon, boolean cashe, int width, int height, int top,
			int left, String key, String pinyin) {
		super();
		this.id = id;
		this.icon = icon;
		this.title = title;
		this.url = url;
		this.showIcon = showIcon;
		this.cashe = cashe;
		this.width = width;
		this.height = height;
		this.top = top;
		this.left = left;
		this.key = key;
		this.pinyin = pinyin;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getIcon() {
		return icon;
	}

	public void setIcon(String icon) {
		this.icon = icon;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public boolean isShowIcon() {
		return showIcon;
	}

	public void setShowIcon(boolean showIcon) {
		this.showIcon = showIcon;
	}

	public boolean isCashe() {
		return cashe;
	}

	public void setCashe(boolean cashe) {
		this.cashe = cashe;
	}

	public int getWidth() {
		return width;
	}

	public void setWidth(int width) {
		this.width = width;
	}

	public int getHeight() {
		return height;
	}

	public void setHeight(int height) {
		this.height = height;
	}

	public int getTop() {
		return top;
	}

	public void setTop(int top) {
		this.top = top;
	}

	public int getLeft() {
		return left;
	}

	public void setLeft(int left) {
		this.left = left;
	}

	public String getKey() {
		return key;
	}

	public void setKey(String key) {
		this.key = key;
	}

	public String getPinyin() {
		return pinyin;
	}

	public void setPinyin(String pinyin) {
		this.pinyin = pinyin;
	}

}
