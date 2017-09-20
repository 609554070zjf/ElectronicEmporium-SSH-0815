/**
 * 
 */
package edu.fjnu.cse.utils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * @author I
 *	日期判断
 */
public class DateUtil {
	
	private final static String PATTERN = "yyyy-MM-dd";
	
	/**
	 * 判断是否是一个合法日期 
	 * @param str
	 * @return
	 */
	public static boolean isValidDate(String str){
		SimpleDateFormat sdf = new SimpleDateFormat(PATTERN);
		boolean parseSuccess = true;
		try{
			sdf.setLenient(false);
			Date date = sdf.parse(str);
		}catch(ParseException e){
			parseSuccess = false;
		}
		return parseSuccess;
	}
	
	/**
	 * 字符串转成日期
	 * patter="yyyy-MM-dd"
	 * @param str
	 * @return
	 */
	public static Date StringToDate(String str){
		SimpleDateFormat sdf = new SimpleDateFormat(PATTERN);
		sdf.setLenient(false);
		Date date = null;
		try {
			date = sdf.parse(str);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return date;
	}
	
	/**
	 * 日期转换成字符串
	 * patter="yyyy-MM-dd"
	 * @param date
	 * @return
	 */
	public static String DateToString(Date date){
		SimpleDateFormat sdf = new SimpleDateFormat(PATTERN);
		return sdf.format(date);
	}
	
}
