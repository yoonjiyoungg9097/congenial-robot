package kr.or.ddit.web;

import java.io.IOException;
import java.util.Arrays;
import java.util.Enumeration;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/albamon_ziji")
public class SimpleFormProcessServlet_ziji extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
//		1) 하드코딩
//		String name = req.getParameter("name");
//		String age = req.getParameter("age");
//		String tel = req.getParameter("tel");
//		String addr = req.getParameter("address");
//		String gender = req.getParameter("gender");
//		String grade = req.getParameter("grade");
//		String career = req.getParameter("career");
//		String[] license = req.getParameterValues("license");
//		
//		System.out.printf("%s : %s\n", "name", name);
//		System.out.printf("%s : %s\n", "age", age);
//		System.out.printf("%s : %s\n", "tel", tel);
//		System.out.printf("%s : %s\n", "address", addr);
//		System.out.printf("%s : %s\n", "gender", gender);
//		System.out.printf("%s : %s\n", "grade", grade);
//		System.out.printf("%s : %s\n", "career", career);
//		System.out.printf("%s : %s\n", "license", Arrays.toString(license));
//		req.setCharacterEncoding("UTF-8"); //디코딩방식 결정 
		
		req.setCharacterEncoding("UTF-8");
		Enumeration<String> names = req.getParameterNames();
		while (names.hasMoreElements()) {
			String name = (String) names.nextElement();
			String[] values = req.getParameterValues(name);
			System.out.printf("%s : %s\n", name, Arrays.toString(values));
		}
		
		Map<String, String[]> parameterMap = req.getParameterMap();
		for(Entry<String, String[]> entry : parameterMap.entrySet()) {
			String name = entry.getKey();
			String[] value = entry.getValue();
			System.out.printf("%s : %s\n", name, Arrays.toString(value));
		}
	}
}

