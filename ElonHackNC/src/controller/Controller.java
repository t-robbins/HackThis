package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.Servlet;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import beans.Bubble;
import beans.User;
import database.Account;


/**
 * Servlet implementation class Controller
 */
@WebServlet("/Controller")
public class Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private DataSource ds;
	private Map<String, String> actionMap = new HashMap<>();
	HttpSession session;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Controller() {
		// Build a Map of action parameters to pages

		actionMap.put("index", "/index.jsp");
		actionMap.put("login", "/login.jsp");
		actionMap.put("createaccount", "/createaccount.jsp");
		actionMap.put("userprofile", "/userprofile.jsp");
		actionMap.put("error", "/error.jsp");
		actionMap.put("bubblerequest", "/bubble.jsp");
		actionMap.put("editprofile", "/editprofile.jsp");
		actionMap.put("list", "/list.jsp");
	}

	/**
	 * @see Servlet#init(ServletConfig)
	 */
	@Override
	public void init(ServletConfig config) throws ServletException {

		try {
			InitialContext initContext = new InitialContext();

			Context env = (Context) initContext.lookup("java:comp/env/");

			ds = (DataSource) env.lookup("jdbc/elonhackdb");

		} catch (NamingException e) {
			e.printStackTrace();
			throw new ServletException();
		}

	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	@Override
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		String action = request.getParameter("action");
		session = request.getSession();

		Connection conn = null;

		try {
			conn = ds.getConnection();
		} catch (SQLException e) {
			throw new ServletException();
		}

		if (action == null || !actionMap.containsKey(action)) {
			action = "error";
		}

		if (action.equals("bubblerequest")) {
			String bubbleName = request.getParameter("bubble");
			Account account = new Account(conn);
			try {
				Bubble b = account.getBubble(bubbleName);
				session.setAttribute("parent", b);
				// generate string
				String parent = "1, 0, " + b.getTitle() + ";";
				ArrayList<Bubble> children = account
						.getSubBubbles(b.getTitle());
				String finalStr = parent;
				if (children != null) {
					String childrenStr = "";
					for (int i = 0; i < children.size(); i++) {
						Bubble child = children.get(i);
						int id = i + 2;
						childrenStr += id + ", " + 1 + ", " + child.getTitle()
								+ ";";
					}
					finalStr = parent + childrenStr;
				}
				session.setAttribute("diagramString", finalStr);
			} catch (SQLException e) {
				e.printStackTrace();
				action = "error";
			}
		}

		if(action.equals("list")) {
		String hackathon = request.getParameter("hackathon");
		//if(!hackathon.equals(null)){
			Account account = new Account(conn);
			try {
				ArrayList<String> hacks = account.getHacks(hackathon);
				String hackStr = ""; 
				if (hacks != null) { 
				for(int i = 0; i < hacks.size(); i ++) {
					hackStr += (i+1) + ", " + 0 + ", " + hacks.get(i)
							+ ";";
				}
				}
				session.setAttribute("hackString", hackStr);
				 
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} 
		}
		//}
		
		
		// Forward to the requested page.
		request.getRequestDispatcher(actionMap.get(action)).forward(request,
				response);

		try {
			conn.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	@Override
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		String action = request.getParameter("action");

		Connection conn = null;

		try {
			conn = ds.getConnection();
		} catch (SQLException e) {
			try {
				conn = ds.getConnection();
			} catch (SQLException e1) {
				throw new ServletException();
			}
		}

		if (action.equals("dologin")) {
			String username = request.getParameter("username");
			String password = request.getParameter("password");

			User user = new User(username, password);

			request.setAttribute("username", username);
			request.setAttribute("password", "");
			request.setAttribute("message", "");
			Account account = new Account(conn);

			try {
				if (account.login(username, password)) {

					session = request.getSession();

					user = account.getUser(username);
					session.setAttribute("user", user);

					String from = request.getParameter("from");

					response.sendRedirect(from);

					//
					// request.getRequestDispatcher("/index.jsp").forward(request,
					// response);

				} else {
					request.setAttribute("message",
							"email address or password not recognized");
					request.getRequestDispatcher("/login.jsp").forward(request,
							response);
				}
			} catch (SQLException e) {
				// Do something sensible here --> forward to error.jsp
				e.printStackTrace();
			}

		} else if (action.equals("createaccount")) {

			String email = request.getParameter("email");
			String password = request.getParameter("password");
			String username = request.getParameter("username");
			String repeat = request.getParameter("repeat");

			request.setAttribute("email", email);

			if (!password.equals(repeat)) {
				request.setAttribute("message", "Passwords do not match");
				request.getRequestDispatcher("/createaccount.jsp").forward(
						request, response);
			} else {
				User user = new User(username, email, password);
				Account account = new Account(conn);

				if (!user.validate()) {
					// password or email have wrong format
					request.setAttribute("username", username);
					request.setAttribute("password", password);
					request.setAttribute("message", user.getMessage());
					request.getRequestDispatcher("/createaccount.jsp").forward(
							request, response);
				} else {
					try {
						if (account.emailExists(email)) {
							// Account already exists with this email
							request.setAttribute("message",
									"An account with this email already exists");
							request.getRequestDispatcher("/createaccount.jsp")
									.forward(request, response);
						} else if (account.usernameExists(username)) {
							// Account already exists with this email
							request.setAttribute("message",
									"An account with this username already exists");
							request.getRequestDispatcher("/createaccount.jsp")
									.forward(request, response);
						} else {
							// Account can be created
							account.create(username, email, password);
							account.sendEmail(username, email, password);
							request.getRequestDispatcher("/index.jsp").forward(
									request, response);
						}
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
			}

		} else if (action.equals("userprofile")) {
			request.getRequestDispatcher("/userprofile.jsp").forward(request,
					response);
		} else if (action.equals("subtopic")) {
			// should probably check that the idea title is unique

			Account account = new Account(conn);
			String title = request.getParameter("title");
			String summary = request.getParameter("summary");
			Bubble b = (Bubble) session.getAttribute("parent");
			String hackathon = b.getHackathon();
			User u = (User) session.getAttribute("user");
			String author = u.getUsername();
			// String parentTitle = b.getTitle();

			try {
				account.createTopic(title, summary, author, hackathon, b);
				
				if(!u.getUsername().equals(b.getAuthor())){
					account.sendEmailNote(u.getUsername(), b.getAuthor(), b.getTitle());
				}

			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				// request.getRequestDispatcher("/error.jsp").forward(request,
				// response);
			}
			request.getRequestDispatcher("/bubble.jsp").forward(request,
					response);
		} else if (action.equals("editprofile")) {

			String email = request.getParameter("email");
			String password = request.getParameter("password");
			String username = request.getParameter("username");
			String repeat = request.getParameter("repeat");
			String aboutme = request.getParameter("aboutme");
			String website = request.getParameter("website");
			String github = request.getParameter("github");
			String pictureurl = request.getParameter("pictureurl");
			System.out.println(aboutme);

			request.setAttribute("email", email);

			if (!password.equals(repeat)) {
				request.setAttribute("message", "Passwords do not match");
				request.setAttribute("aboutMe", aboutme);
				request.setAttribute("website", website);
				request.setAttribute("github", github);
				request.setAttribute("pictureurl", pictureurl);
				request.setAttribute("password", password);
				request.setAttribute("email", email);
				request.setAttribute("username", username);
				request.getRequestDispatcher("/editprofile.jsp").forward(
						request, response);
			} else {
				User user = new User(username, email, password);
				Account account = new Account(conn);

				if (!user.validate()) {
					// password or email have wrong format
					request.setAttribute("aboutMe", aboutme);
					request.setAttribute("website", website);
					request.setAttribute("github", github);
					request.setAttribute("pictureurl", pictureurl);
					request.setAttribute("password", password);
					request.setAttribute("email", email);
					request.setAttribute("username", username);
					request.setAttribute("message", user.getMessage());
					request.getRequestDispatcher("/editprofile.jsp").forward(
							request, response);
				} else {
					try {
						account.editProfile(username, email, password, website, github, pictureurl, aboutme);
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					String contextpath = request.getContextPath() + "/index.jsp";
					session.setAttribute("currentPage", contextpath);
					request.getRequestDispatcher("/logout.jsp").forward(
							request, response);
				}
			}

		} 

		else {
			request.getRequestDispatcher(actionMap.get(action)).forward(
					request, response);
		}

		try {
			conn.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}