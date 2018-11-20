package kr.or.ddit.web;

import java.io.*;
import javax.servlet.http.*;
import javax.servlet.*;
import java.util.*;
import javax.servlet.annotation.*;

@WebServlet("/gugudan.do") // web.xml에 선언해줘야하는것
public class GugudanServlet extends HttpServlet {

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String minDanStr = req.getParameter("minDan");
		String maxDanStr = req.getParameter("maxDan");

		int minDan = 2;
		int maxDan = 9;
		if (minDanStr != null && minDanStr.matches("\\d")) {
			minDan = Integer.parseInt(minDanStr);
		}

		if (maxDanStr != null && maxDanStr.matches("[0-9]")) {
			maxDan = Integer.parseInt(maxDanStr);
		}
		// 2~9단까지의 구구단을 table태그를 이용하여 출력
		// 단, 한행에 한단씩
		// 테스트시에는 /gugudan.do 요청을 사용
		// web.xml을 사용하지 말것

		resp.setContentType("text/html;charset=UTF-8");
		InputStream in = this.getClass().getResourceAsStream("gugudan.205");
		InputStreamReader isr = new InputStreamReader(in, "UTF-8");
		BufferedReader br = new BufferedReader(isr);
		StringBuffer html = new StringBuffer();
		String temp = null;
		while ((temp = br.readLine()) != null) {
			html.append(temp);
		}

		StringBuffer sb = new StringBuffer();

		for (int dan = minDan; dan <= maxDan; dan++) {
			sb.append("<tr>");
			for (int gu = 1; gu <= 9; gu++) {
				sb.append(String.format("<td>%d * %d = %d</td>", dan, gu, dan * gu));
			}
			sb.append("</tr>");
		}

		int start = html.indexOf("@gugudan");
		int end = start + "@gugudan".length();
		String replacetext = sb.toString();

		html.replace(start, end, replacetext);

		PrintWriter out = resp.getWriter();
		out.println(html.toString());
//		out.close();
	}

//	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
//		
//	}
//
//	@Override
//	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//		// super.doPost(req, resp);
//		
//	}

}