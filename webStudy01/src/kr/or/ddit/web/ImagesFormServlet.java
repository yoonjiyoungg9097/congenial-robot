package kr.or.ddit.web;

import java.io.BufferedReader;
import java.io.File;
import java.io.FilenameFilter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ImagesFormServlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
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
		
		// action 속성의 값은 context/imageService, method="get"
		// mime타입은 출력스트림 개방하기 전에 셋팅해줘야 한다 (메인타입/서브타입 메인타입은 문자열이기때문에 text)
		resp.setContentType("text/html;charset=UTF-8");
		InputStream in = this.getClass().getResourceAsStream("Image.html");
		InputStreamReader isr = new InputStreamReader(in, "UTF-8");
		BufferedReader br = new BufferedReader(isr);
		StringBuffer html = new StringBuffer();
		String temp = null;
		while ((temp = br.readLine()) != null) {//파일이 끝날때까지
			html.append(temp+"\n");
		}
		
//		StringBuffer options = new StringBuffer();
//		String pattern = "<option>%s</option\n>";   //%s는 문자 %d는 숫자
//		for(String name : filenames) {
//			options.append(String.format(pattern, name));
//		}
		
		
		StringBuffer sb = new StringBuffer();
		//sb.append("<select name=image onchange=changeHandler();>");
		for(int i=0; i<filenames.length; i++) {
			sb.append("<option>"+filenames[i]+"</option>\n");
		}
		//sb.append("</select>");
		//sb.append("<input type=submit value=전송");
		
		int start = html.indexOf("@Image");
		int end = start + "@Image".length();
		String replacetext = sb.toString();

		//             바꿀위치            바꿔줄 내용
		html.replace(start, end, replacetext);

		PrintWriter out = resp.getWriter();
		out.println(html.toString()); //html은 최종적으로 완성된 html코드
		out.close();
		
	}
}
