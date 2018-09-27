package nis.nms.domains;

import java.util.List;

public class MetadataDictionaryVO {
	private Long mId;
	private String filedComments;
	private List<OptionTable> listOT;
	
	public Long getmId() {
		return mId;
	}
	public void setmId(Long mId) {
		this.mId = mId;
	}
	public List<OptionTable> getListOT() {
		return listOT;
	}
	public void setListOT(List<OptionTable> listOT) {
		this.listOT = listOT;
	}
	public String getFiledComments() {
		return filedComments;
	}
	public void setFiledComments(String filedComments) {
		this.filedComments = filedComments;
	}
	
}
