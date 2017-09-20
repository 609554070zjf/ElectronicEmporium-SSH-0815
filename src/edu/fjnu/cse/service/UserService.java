package edu.fjnu.cse.service;

import java.util.List;

import edu.fjnu.cse.domain.Goods;
import edu.fjnu.cse.domain.GoodsQueryHelper;
import edu.fjnu.cse.domain.PageBean;
import edu.fjnu.cse.domain.User;
import edu.fjnu.cse.domain.UserQueryHelper;


public interface UserService {
	void saveUser(User user);
	void updateUser(User user);
	void deleteUser(int userId);
	User getUserById(int userId);
	PageBean<User> loadAllAdminByPage(UserQueryHelper helper, PageBean<User> page);
	User findUserByUserNameAndPWD(User user);
	void updatePassword(User user);
	PageBean<User> loadAllUserByPage(UserQueryHelper helper, PageBean<User> pb);
	
	
}
