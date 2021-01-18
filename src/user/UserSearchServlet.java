package user;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
//사용자를 검색하는 동작을 수행하는 서블릿,컨트롤러 역할
@WebServlet("/UserSearchServlet")
public class UserSearchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String userName = request.getParameter("userName");
		response.getWriter().write(getJSON(userName));//제이슨형태로 화면에 출력
	}
	
	public String getJSON(String userName) {//파싱하기 쉬운 하나의 형태,특정 회원 정보가 제이슨 형태로 출력, 서블릿은 제이슨을 만듦
		if(userName == null) userName = "";
		StringBuffer result = new StringBuffer("");
		result.append("{\"result\":[");
		UserDAO2 userDAO2 = new UserDAO2();
		ArrayList<User> userList = userDAO2.search(userName);
		for(int i=0;i<userList.size();i++) {
			result.append("[{\"value\": \""+userList.get(i).getUserName() + "\"},");
			result.append("{\"value\": \""+userList.get(i).getUserAge() + "\"},");
			result.append("{\"value\": \""+userList.get(i).getUserGender() + "\"},");
			result.append("{\"value\": \""+userList.get(i).getUserEmail() + "\"}],");
		}
		result.append("]}");
		return result.toString();
	}
}
