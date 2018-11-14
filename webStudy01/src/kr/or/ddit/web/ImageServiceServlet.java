package kr.or.ddit.web;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
