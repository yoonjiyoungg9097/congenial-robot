package kr.or.ddit.web;

import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.tomcat.util.http.ContentType;

import kr.or.ddit.web.model2.FileList;

@WebServlet("/fileBrowser.do")
public class ServerFileBrowser extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//파일 목록을 보여주고 
		//그게 디렉토리라면 그폴더안에있는 목록보여주고
		//..링크 추가하면 다시 상위폴더로
		//파라미터로 넘겨줌
		String path= req.getParameter("path");
		String name= req.getParameter("name");
		getServletContext().getRealPath("/");
		if(path==null) {
			path=getServletContext().getRealPath("/");
		}else {
			if(name.contains(".")) {
				File file=new File(path);
				path=file.getParentFile().getAbsolutePath();
			}
		}
		FileList fileList=new FileList();
		List<File> filefile=fileList.getFileList(path);
		if(filefile!=null) {
			
			req.setAttribute("file", filefile);
		}else {
			
		}
		String view="/WEB-INF/views/fileBrowser.jsp";
		RequestDispatcher rd= req.getRequestDispatcher(view);
		rd.forward(req, resp);
	}
}
