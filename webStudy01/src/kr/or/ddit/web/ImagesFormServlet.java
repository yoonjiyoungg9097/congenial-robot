package kr.or.ddit.web;

import java.io.BufferedReader;
import java.io.File;
import java.io.FilenameFilter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fasterxml.jackson.databind.ObjectMapper;

import kr.or.ddit.utils.CookieUtil;

public class ImagesFormServlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ServletContext context = req.getServletContext();
//		File folder = new File("d:/contents");
//		String contentFolder = context.getInitParameter("contentFolder");
//		File folder = new File(contentFolder);
		File folder = (File)context.getAttribute("contentFolder");
		String[] filenames = folder.list(new FilenameFilter() {//functional 인터페이스
			
			@Override
			public boolean accept(File dir, String name) {
				String mime = context.getMimeType(name); //이미지 메인타입은 모두 jpg
				//return name.toLowerCase().endsWith("jpg");
				return mime.startsWith("image/");
			}
		});
		
		
		
		
		StringBuffer sb = new StringBuffer();
		//sb.append("<select name=image onchange=changeHandler();>");
		sb.append("<option>그림선택</option>");
		for(int i=0; i<filenames.length; i++) {
			sb.append("<option>"+filenames[i]+"</option>\n");
		}
		//sb.append("</select>");
		//sb.append("<input type=submit value=전송");
		
//		int start = html.indexOf("@Image");
//		int end = start + "@Image".length();
//		
//		
//		String replacetext = sb.toString();
//		//             바꿀위치            바꿔줄 내용
//		html.replace(start, end, replacetext);
		
		req.setAttribute("optionsAttr", sb.toString());
		
		
		//JSON 형태 기록
		String imgCookieValue = new CookieUtil(req).getCookieValue("imageCookie");
		StringBuffer imgTags = new StringBuffer();
		if(imgCookieValue!=null) {
			//unmarshalling 언마샬링
			ObjectMapper mapper = new ObjectMapper();
//			mapper.readValue(imgCookieValue, String[].class);
			
			String[] imgNames = mapper.readValue(imgCookieValue, String[].class);
//			String[] imgNames = imgCookieValue.split(",");
			String imgPattern = "<img src='imageService?image=%s'/>";
			for(String imgName : imgNames) {
				imgTags.append(String.format(imgPattern, imgName));
			}
		}
		
		req.setAttribute("imgTags", imgTags);
//		start = html.indexOf("@Image1");
//		end = start + "@Image1".length();
//		html.replace(start, end, imgTags.toString());

		String view = "/WEB-INF/views/ImageView.jsp";
		RequestDispatcher rd = req.getRequestDispatcher(view);
		rd.include(req, resp);
		
//		PrintWriter out = resp.getWriter();
//		out.println(html); //html은 최종적으로 완성된 html코드
//		out.close();
		
		
		
	}
}
