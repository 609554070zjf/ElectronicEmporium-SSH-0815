/**
 * 
 */
package edu.fjnu.cse.intercept;

import java.util.Map;

import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.Interceptor;

import edu.fjnu.cse.domain.User;

/**
 * @author Javon
 * 
 */
public class AuthenIntercetpor implements Interceptor {

	@Override
	public void destroy() {
		// TODO Auto-generated method stub

	}

	@Override
	public void init() {
		// TODO Auto-generated method stub

	}

	@Override
	public String intercept(ActionInvocation invocation) throws Exception {
		Map<String, Object> session = invocation.getInvocationContext()
				.getSession();

		User user = (User) session.get("user");

		if (user == null) {
			return "login_page";
		}

		System.out.println("user logged, to actual page!!");

		return invocation.invoke();
	}

}
