/*
 * Copyright (c) Thomas Robbins, Schuyler Goodwin, Miles Camp, Evan Walmer March 1, 2014
 */
package database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

//import javax.mail.Message;
//import javax.mail.MessagingException;
//import javax.mail.Session;
//import javax.mail.Transport;
//import javax.mail.internet.InternetAddress;
//import javax.mail.internet.MimeMessage;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;

import beans.Bubble;
import beans.User;

//import com.github.sendgrid.SendGrid;

public class Account {
	private Connection conn;

	public Account(Connection conn) {
		this.conn = conn;
	}

	public void create(String username, String email, String password)
			throws SQLException {
		String sql = "insert into user_table (username, email, password) values (?, ?, ?)";

		PreparedStatement stmt = conn.prepareStatement(sql);

		stmt.setString(1, username);
		stmt.setString(2, email);
		stmt.setString(3, password);

		stmt.executeUpdate();

		stmt.close();
	}

	public boolean emailExists(String email) throws SQLException {
		String sql = "select count(*) as count from user_table where email=?";

		PreparedStatement stmt = conn.prepareStatement(sql);

		stmt.setString(1, email);

		ResultSet rs = stmt.executeQuery();

		int count = 0;

		if (rs.next()) {
			count = rs.getInt("count");
		}

		rs.close();
		stmt.close();

		if (count == 0) {
			return false;
		} else {
			return true;
		}

	}

	public boolean usernameExists(String username) throws SQLException {
		String sql = "select count(*) as count from user_table where email=?";

		PreparedStatement stmt = conn.prepareStatement(sql);

		stmt.setString(1, username);

		ResultSet rs = stmt.executeQuery();

		int count = 0;

		if (rs.next()) {
			count = rs.getInt("count");
		}

		rs.close();
		stmt.close();

		if (count == 0) {
			return false;
		} else {
			return true;
		}
	}

	public boolean login(String username, String password) throws SQLException {

		String sql = "select count(*) as count from user_table where username=? and password=?";

		PreparedStatement stmt = conn.prepareStatement(sql);

		stmt.setString(1, username);
		stmt.setString(2, password);

		ResultSet rs = stmt.executeQuery();

		int count = 0;

		if (rs.next()) {
			count = rs.getInt("count");
		}

		rs.close();
		stmt.close();

		if (count == 0) {
			return false;
		} else {
			return true;
		}
	}

	public User getUser(String username) throws SQLException {
		String sql = "select * from user_table where username=?";
		PreparedStatement stmt = conn.prepareStatement(sql);

		stmt.setString(1, username);

		ResultSet rs = stmt.executeQuery();

		User user = null;

		if (rs.next()) {
			String email = rs.getString("email");
			String password = rs.getString("password");
			String github = rs.getString("github");
			String picture = rs.getString("picture");
			String personalWeb = rs.getString("personal_site");
			String aboutme = rs.getString("about_me");

			user = new User(username, email, password, github,
					picture, personalWeb, aboutme);

		}
		rs.close();
		stmt.close();
		return user;

	}



	public Bubble getBubble(String bname) throws SQLException {

		String sql = "select summary, title, date, username as author, name "
				+ "as hack from idea AS i join hackathon AS h "
				+ "on (i.hack_id = h.hackathon_id) join user_table AS u "
				+ "on (i.user_id = u.user_id) where title=?";

		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, bname);

		ResultSet rs = stmt.executeQuery();

		Bubble b = null;

		if (rs.next()) {
			String title = rs.getString("title");
			String summary = rs.getString("summary");
			String author = rs.getString("author");
			String hack = rs.getString("hack");
			String date = rs.getTimestamp("date").toGMTString();
			b = new Bubble(title, summary, date, hack, author);
		}

		rs.close();
		stmt.close();
		return b;

	}

	public ArrayList<Bubble> getSubBubbles(String parentTitle)
			throws SQLException {

		String sql = "select ii.title as title, ii.summary as summary, ii.date as date, h.name as hack, "
				+ "u.username as author "
				+ "from idea AS i "
				+ "join idea_association as a on (i.idea_id = a.parent_id) "
				+ "join idea as ii on (a.child_id = ii.idea_id) "
				+ "join hackathon AS h on (ii.hack_id = h.hackathon_id) "
				+ "join user_table AS u on (ii.user_id = u.user_id) "
				+ "where i.title=?";

		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, parentTitle);

		ResultSet rs = stmt.executeQuery();

		ArrayList<Bubble> subBubbles = new ArrayList<>();

		while (rs.next()) {
			String title = rs.getString("title");
			String summary = rs.getString("summary");
			String author = rs.getString("author");
			String hack = rs.getString("hack");
			String date = rs.getTimestamp("date").toGMTString();
			Bubble b = new Bubble(title, summary, date, hack, author);
			subBubbles.add(b);
		}

		rs.close();
		stmt.close();

		if (subBubbles.size() > 0) {
			return subBubbles;
		} else {
			return null;
		}

	}

	public void sendEmail(String username, String email, String password) {
		Context initCtx;
		try {
			initCtx = new InitialContext();
			Session session = (Session) initCtx
					.lookup("java:comp/env/mail/SendGrid");

			Message message = new MimeMessage(session);
			message.setFrom(new InternetAddress("trobbins2@elon.edu"));
			InternetAddress to[] = new InternetAddress[1];

			to[0] = new InternetAddress(email);

			message.setRecipients(Message.RecipientType.TO, to);
			message.setSubject("Welcome to HackThis! Login information enclosed");

			message.setContent(
					"Hello,"
							+ "\n You've recently created a HackThis account. "
							+ "\n Your login information follows: "
							+ "\nUsername: "
							+ username
							+ "\nPassword: "
							+ password
							+ "\n\nClick http://elonhack.elonhacknc.cloudbees.net/Controller?action=login "
							+ "to login and share your ideas!", "text/plain");

			Transport.send(message);

		} catch (NamingException | MessagingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	public void createTopic(String title, String summary, String author,
			String hackathon, Bubble parent) throws SQLException {

		String sql = "select hackathon_id as hack from hackathon where name = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, hackathon);

		ResultSet rs = stmt.executeQuery();

		int hackid = 0;
		if (rs.next()) {
			hackid = rs.getInt("hack");
		}

		rs.close();
		stmt.close();

		if (hackid != 0) {

			String sql2 = "select user_id from user_table where username=?";

			PreparedStatement stmt2 = conn.prepareStatement(sql2);
			stmt2.setString(1, author);

			ResultSet rs2 = stmt2.executeQuery();

			int userid = 0;
			if (rs2.next()) {
				userid = rs2.getInt("user_id");
			}

			rs2.close();
			stmt2.close();

			if (userid != 0) {
				String insert = "insert into idea (summary, title, hack_id, user_id) "
						+ "values (?, ?, ?, ?)";
				PreparedStatement stmtInsert = conn.prepareStatement(insert);
				stmtInsert.setString(1, summary);
				stmtInsert.setString(2, title);
				stmtInsert.setInt(3, hackid);
				stmtInsert.setInt(4, userid);

				stmtInsert.executeUpdate();

				stmtInsert.close();

				String parentid = "select user_id from user_table where username=?";
				PreparedStatement pstmt = conn.prepareStatement(parentid);
				pstmt.setString(1, parent.getAuthor());

				ResultSet prs = pstmt.executeQuery();

				int pid = 0;

				if (prs.next()) {
					pid = prs.getInt("user_id");
				}

				prs.close();
				pstmt.close();

				if (pid != 0) {
					String insert2 = "insert into idea_association (parent_id, child_id) "
							+ "values (?, ?)";
					PreparedStatement stmt3 = conn.prepareStatement(insert2);
					stmt3.setInt(1, pid);
					stmt3.setInt(2, userid);

					stmt3.executeUpdate();

					stmt3.close();
				}
			}

		}

	}
	
	public void editProfile(String username, String email, String password,
			String website, String github, String pictureurl, String aboutme)
			throws SQLException {
		String sqlquerey = "SELECT user_id  FROM user_table WHERE username = ?";
		PreparedStatement stmt = conn.prepareStatement(sqlquerey);
		stmt.setString(1, username);
		ResultSet rs = stmt.executeQuery();

		String id = "";
		if (rs.next()) {
			id = rs.getString("user_id");
		}
		System.out.println(id);
		rs.close();
		stmt.close();

		if (!id.equals("")) {

			String sqlupdate = "UPDATE user_table SET email=?, password=?, github=?, personal_site=?, picture=?, about_me=? WHERE user_id=?";
			PreparedStatement stmt2 = conn.prepareStatement(sqlupdate);

			stmt2.setString(1, email);
			stmt2.setString(2, password);
			stmt2.setString(3, github);
			stmt2.setString(4, website);
			stmt2.setString(5, pictureurl);
			stmt2.setString(6, aboutme);
			stmt2.setString(7, id);

			stmt2.executeUpdate();
			stmt2.close();
		}
	}


}