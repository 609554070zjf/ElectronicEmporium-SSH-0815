/**
 * 
 */
package edu.fjnu.cse.domain;

/**
 * @author Javon
 *
 */
public class UserQueryHelper {
	private String qryUserName;
	
	private String qryUserSex;

	public String getQryUserName() {
		return qryUserName;
	}

	public void setQryUserName(String qryUserName) {
		this.qryUserName = qryUserName;
	}

	public String getQryUserSex() {
		return qryUserSex;
	}

	public void setQryUserSex(String qryUserSex) {
		this.qryUserSex = qryUserSex;
	}

	@Override
	public String toString() {
		return "UserQueryHelper [qryUserName=" + qryUserName + ", qryUserSex="
				+ qryUserSex + "]";
	}
	
}
