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
	/**
	 * 保存用户
	 * @param user
	 */
	void save(User user);
	
	/**
	 * 删除用户
	 * @param userId
	 */
	void delete(int userId);
	
	/**
	 * 修改用户
	 * @param user
	 */
	void update(User user);
	
	/**
	 * 根据用户id查询用户
	 * @param userId
	 * @return
	 */
	User getUserById(int userId);
	
	/**
	 * 查询管理员记录数（分页+组合查询）
	 * @param helper
	 * @return
	 */
	public int cntAdminByHelper(UserQueryHelper helper);

	/**
	 * 查询管理员列表（分页+组合查询）
	 * @param helper
	 * @param startIndex
	 * @param fetchSize
	 * @return
	 */
	public List<User> loadScopedAdminByHelper(UserQueryHelper helper,
			Integer startIndex, int fetchSize);

	/**
	 * 根据用户名和密码查找用户
	 * @param user
	 * @return
	 */
	User findUserByUserNameAndPWD(User user);

	/**
	 * 修改密码
	 * @param user
	 */
	void updatePassword(User user);

	/**
	 * 查询用户的记录数（分页+组合查询）
	 * @param helper
	 * @return
	 */
	int cntUserByHelper(UserQueryHelper helper);

	/**
	 * 查询用户列表（分页+组合查询）
	 * @param helper
	 * @param startIndex
	 * @param i
	 * @return
	 */
	Collection<User> loadScopedUserByHelper(UserQueryHelper helper,
			int startIndex, int i);
}
