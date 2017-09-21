/**
 * 
 */
package edu.fjnu.cse.action;

import java.util.Map;

import org.apache.struts2.interceptor.SessionAware;

import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

import edu.fjnu.cse.domain.GoodsQueryHelper;
import edu.fjnu.cse.domain.PageBean;
import edu.fjnu.cse.domain.User;
import edu.fjnu.cse.domain.UserQueryHelper;
import edu.fjnu.cse.service.UserService;

/**
 * @author Javon
 *
 */
public class UserAction extends ActionSupport implements ModelDriven<User>,SessionAware{
	private UserService userService;
	private UserQueryHelper helper = new UserQueryHelper();
	private User user = new User();
	private PageBean<User> pb = new PageBean<User>();
	private int pageCode = 1;
	private Map<String, Object> session = null;
	private String pwd;
	private String newPwd;


	@Override
	public User getModel() {
		return user;
	}
	public UserService getUserService() {
		return userService;
	}
	public void setUserService(UserService userService) {
		this.userService = userService;
	}
	public UserQueryHelper getHelper() {
		return helper;
	}
	public void setHelper(UserQueryHelper helper) {
		this.helper = helper;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public PageBean<User> getPb() {
		return pb;
	}
	public void setPb(PageBean<User> pb) {
		this.pb = pb;
	}
	public int getPageCode() {
		return pageCode;
	}
	public void setPageCode(int pageCode) {
		this.pageCode = pageCode;
	}
	
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getNewPwd() {
		return newPwd;
	}
	public void setNewPwd(String newPwd) {
		this.newPwd = newPwd;
	}
	public String toAdd() throws Exception{
		return "add_page";
	}
	
	/**
	 * 添加用户
	 * @return
	 * @throws Exception
	 */
	public String add() throws Exception{
		System.out.println(user);
		userService.saveUser(user);
		if(session.get("user") != null){
			return "loadAllAdmin";
		}
		else return "login_page";
	}
	
	/**
	 * 去用户修改页面
	 * @return
	 * @throws Exception
	 */
	public String toUpdate() throws Exception{
		user = userService.getUserById(user.getUserId());
		return "update_page";
	}
	
	/**
	 * 修改用户-管理员
	 * @return
	 * @throws Exception
	 */
	public String update() throws Exception{
		user.setPassword(userService.getUserById(user.getUserId()).getPassword());
		userService.updateUser(user);
		return "loadAllAdmin";
	}
	
	/**
	 * 删除用户
	 * @return
	 * @throws Exception
	 */
	public String delete() throws Exception{
		userService.deleteUser(user.getUserId());
		return "loadAllAdmin";
	}
	
	/**
	 * 加载所有管理员
	 * @return
	 * @throws Exception
	 */
	public String loadAllAdmin() throws Exception{
		pb.setPageSize(10);
		System.out.println(helper);
		pb = userService.loadAllAdminByPage(helper,pb);
		return "load_page";
	}
	
	/**
	 * 管理员详细信息
	 * @return
	 * @throws Exception
	 */
	public String infoAdmin() throws Exception{
		user = userService.getUserById(user.getUserId());
		return "info_page";
	}
	
	/**
	 * 登录
	 * @return
	 * @throws Exception
	 */
	public String login() throws Exception{
		user = userService.findUserByUserNameAndPWD(user);
		session.clear();
		if(user != null){
			session.put("user", user);
		}
		else{
			this.addActionError("用户名或密码或身份错误！");
			return "login_page";
		}
		if(user.getIdentify() == 2){
			return "toUserMain";
		}
		else return "loginSuccess_admin";
	}
	
	@Override
	public void setSession(Map<String, Object> session) {
		this.session = session;
	}
	
	/**
	 * 用户个人信息
	 * @return
	 * @throws Exception
	 */
	public String infoUser() throws Exception{
		int userId = ((User)session.get("user")).getUserId();
		user = userService.getUserById(userId);
		return "info_page_user";
	}
	
	/**
	 * 去修改用户页面
	 * @return
	 * @throws Exception
	 */
	public String toUpdateUser() throws Exception{
		int userId = ((User)session.get("user")).getUserId();
		user = userService.getUserById(userId);
		return "update_page_user";
	}
	
	/**
	 * 去用户主页
	 * @return
	 * @throws Exception
	 */
	public String toUserMain() throws Exception{
		return "loginSuccess_user";
	}
	
	/**
	 * 修改用户-用户
	 * @return
	 * @throws Exception
	 */
	public String updateUser() throws Exception{
		user.setPassword(userService.getUserById(user.getUserId()).getPassword());
		userService.updateUser(user);
		return "toUserMain";
	}
	
	/**
	 * 去修改密码界面
	 * @return
	 * @throws Exception
	 */
	public String toUpdatePwd() throws Exception{
		return "update_pwd";
	}
	
	/**
	 * 去添加用户界面
	 * @return
	 * @throws Exception
	 */
	public String toReg() throws Exception{
		return "reg_page";
	}
	
	/**
	 * 加载所用用户
	 * @return
	 * @throws Exception
	 */
	public String loadAllUser() throws Exception{
		pb.setPageSize(10);
		System.out.println(helper);
		pb = userService.loadAllUserByPage(helper,pb);
		return "load_page";
	}
	
	/**
	 * 修改用户密码
	 * @return
	 * @throws Exception
	 */
	public String updatePassword() throws Exception{
		int userId = ((User)session.get("user")).getUserId();
		int identify = ((User)session.get("user")).getIdentify();
		user.setPassword(pwd);
		user = userService.findUserByUserNameAndPWD(user);
		if(user != null){
			user.setPassword(newPwd);
			userService.updatePassword(user);
		}
		else{
			this.addActionError("原密码错误！");
			return "update_pwd";
		}
		if(user.getIdentify() == 2){
			return "toUserMain";
		}
		else return "loginSuccess_admin";
	}
	
	/**
	 * 退出系统
	 * @return
	 * @throws Exception
	 */
	public String quitSys() throws Exception{
		session.clear();
		return "login_page";
	}
}
