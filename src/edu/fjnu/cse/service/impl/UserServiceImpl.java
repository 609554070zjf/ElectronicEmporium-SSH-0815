/**
 * 
 */
package edu.fjnu.cse.service.impl;

import edu.fjnu.cse.dao.UserDao;
import edu.fjnu.cse.domain.PageBean;
import edu.fjnu.cse.domain.User;
import edu.fjnu.cse.domain.UserQueryHelper;
import edu.fjnu.cse.service.UserService;

/**
 * @author Javon
 *
 */
public class UserServiceImpl implements UserService{
	private UserDao userDao;

	public UserDao getUserDao() {
		return userDao;
	}

	public void setUserDao(UserDao userDao) {
		this.userDao = userDao;
	}

	@Override
	public void saveUser(User user) {
		userDao.save(user);
	}

	@Override
	public void updateUser(User user) {
		userDao.update(user);
	}

	@Override
	public void deleteUser(int userId) {
		userDao.delete(userId);
	}

	@Override
	public User getUserById(int userId) {
		return userDao.getUserById(userId);
	}

	@Override
	public PageBean<User> loadAllAdminByPage(UserQueryHelper helper,
			PageBean<User> page) {
		page.setTotalRecord(userDao.cntAdminByHelper(helper));
		page.setDatas(userDao.loadScopedAdminByHelper(helper, page.getStartIndex(), page.getEndIndex()-page.getStartIndex()));
		return page;
	}

	@Override
	public User findUserByUserNameAndPWD(User user) {
		return userDao.findUserByUserNameAndPWD(user);
	}

	@Override
	public void updatePassword(User user) {
		userDao.updatePassword(user);
	}

	@Override
	public PageBean<User> loadAllUserByPage(UserQueryHelper helper,
			PageBean<User> page) {
		page.setTotalRecord(userDao.cntUserByHelper(helper));
		page.setDatas(userDao.loadScopedUserByHelper(helper, page.getStartIndex(), page.getEndIndex()-page.getStartIndex()));
		return page;
	}
	
	
}
