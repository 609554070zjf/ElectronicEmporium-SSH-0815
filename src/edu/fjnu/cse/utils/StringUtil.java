package edu.fjnu.cse.utils;

/**
 * 
 * @author Javon
 *
 * 字符串工具类
 */
public class StringUtil {

	/**
	 * 判断是否是空串或null
	 * @param str
	 * @return
	 */
	public static boolean isEmpty(String str){
		if("".equals(str)|| str==null){
			return true;
		}else{
			return false;
		}
	}
	
	/**
	 * 判断是否是非空串或非null
	 * @param str
	 * @return
	 */
	public static boolean isNotEmpty(String str){
		if(!"".equals(str)&&str!=null){
			return true;
		}else{
			return false;
		}
	}
}
