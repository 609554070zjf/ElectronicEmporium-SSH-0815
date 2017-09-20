/**
 * 
 */
package edu.fjnu.cse.utils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * @author I
 *	�����ж�
 */
public class DateUtil {
	
	private final static String PATTERN = "yyyy-MM-dd";
	
	/**
	 * �ж��Ƿ���һ���Ϸ����� 
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
	 * �ַ���ת������
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
	 * ����ת�����ַ���
	 * patter="yyyy-MM-dd"
	 * @param date
	 * @return
	 */
	public static String DateToString(Date date){
		SimpleDateFormat sdf = new SimpleDateFormat(PATTERN);
		return sdf.format(date);
	}
	
}
