package kr.or.ddit.web;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Arrays;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.ArrayUtils;
import org.apache.commons.lang3.StringUtils;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.sun.org.apache.bcel.internal.generic.CPInstruction;

import kr.or.ddit.utils.CookieUtil;
import kr.or.ddit.utils.CookieUtil.TextType;

@WebServlet("/imageService")
public class ImageServiceServlet extends HttpServlet {
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		
		// 요청 파라미터 확보 : 파라미터명(image)
		// 이미지 스트림밍
		String img = req.getParameter("image");//입력태그의 name속성값   parameter검증이 필요하다
		if(img == null || img.trim().length()==0 ) {
			resp.sendError(400);
			return;
		}

//		String contentFolder = getServletContext().getInitParameter("contentFolder");
//		File folder = new File(contentFolder);
		File folder = (File)getServletContext().getAttribute("contentFolder");
		File imgFile = new File(folder,img);
		if(!imgFile.exists()) {
			resp.sendError(404);
			return;
		}
		
		//쿠키값 : A,B
		String imgCookieValue = new CookieUtil(req).getCookieValue("imageCookie");
		String[] cookieValues = null;
		ObjectMapper mapper = new ObjectMapper();
		if(StringUtils.isBlank(imgCookieValue)) {//imgCookieValue==null
			cookieValues = new String[] {imgFile.getName()};
		}else {
			String[] cValues = mapper.readValue(imgCookieValue, String[].class);
			cookieValues = new String[cValues.length+1];
			System.arraycopy(cValues, 0, cookieValues, 0, cValues.length);
			cookieValues[cookieValues.length-1] = imgFile.getName();
		}
//		imgCookieValue = Arrays.toString(cookieValues);
//		imgCookieValue = imgCookieValue.replaceAll("[\\[\\]\\s]", "");
		
		//marshalling 마샬링
		
		imgCookieValue = mapper.writeValueAsString(cookieValues);
		System.out.println(imgCookieValue);
		
		
		Cookie imageCookie = CookieUtil.createCookie("imageCookie", imgCookieValue, req.getContextPath(), TextType.PATH, 60*60*24*3);
		resp.addCookie(imageCookie);
		
		ServletContext context = req.getServletContext();
		context.getMimeType(context.getMimeType(img));																																																																																																													
		
		
		int pointer = -1;
		byte[] buffer = new byte[1024];
		FileInputStream fis = new FileInputStream(imgFile);
		OutputStream os = resp.getOutputStream();
		while((pointer = fis.read(buffer))!=-1) { // -1 : EOF 문자																		
			os.write(buffer,0,pointer);
			
		}
		
//		resp.setContentType("image/jpeg");
//		File imgFile = new File("d:/contents/"+img);
//		FileInputStream fis = new FileInputStream(imgFile);
//		OutputStream out = resp.getOutputStream();
//		byte[] buffer = new byte[1024];
//		int pointer = -1;
//		while((pointer = fis.read(buffer))!= -1){
//			out.write(buffer);
//		}
		fis.close();
		os.close();
		
		
		
		
		
		
		
	}
	
	
}
