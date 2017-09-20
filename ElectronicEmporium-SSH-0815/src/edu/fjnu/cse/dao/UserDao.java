/**
 * 
 */
package edu.fjnu.cse.dao;

import java.util.Collection;
import java.util.List;

import edu.fjnu.cse.domain.User;
import edu.fjnu.cse.domain.UserQueryHelper;

/**
 * @author Javon
 *
 */
public interface UserDao {
	void save(User user);
	
	void delete(int userId);
	
	void update(User user);
	
	User getUserById(int userId);
	
	public int cntAdminByHelper(UserQueryHelper helper);

	public List<User> loadScopedAdminByHelper(UserQueryHelper helper,
			Integer startIndex, int fetchSize);

	User findUserByUserNameAndPWD(User user);

	void updatePassword(User user);

	int cntUserByHelper(UserQueryHelper helper);

	Collection<User> loadScopedUserByHelper(UserQueryHelper helper,
			int startIndex, int i);
}
