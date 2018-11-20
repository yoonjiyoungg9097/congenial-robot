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

import org.apache.commons.lang3.StringUtils;

import kr.or.ddit.web.model2.FileList;

@WebServlet("/fileBrowser.do")
public class ServerFileBrowser extends HttpServlet {//Controller
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//파일 목록을 보여주고 
		//그게 디렉토리라면 그폴더안에있는 목록보여주고
		//..링크 추가하면 다시 상위폴더로
		//파라미터로 넘겨줌
		String path= req.getParameter("path");
		String name= req.getParameter("name");
		String option = req.getParameter("option");
		String movePath = getServletContext().getRealPath("/")+"moveFolder\\";
		
		FileList fileList=new FileList();
		getServletContext().getRealPath("/");//webcontents까지
		if(path==null) {
			path=getServletContext().getRealPath("/");
		}else {//폴더가 아닌경우 폴더인 경우 이름의 .이 들어가지 않기 때문에
			File file=new File(path);//윤지렁이가 선택한 파일
			if(name.contains(".")) {
				path=file.getParentFile().getAbsolutePath();//선택한 파일의 부모 절대경로
				
				if(StringUtils.isBlank(option)) {
					resp.sendError(400);
				}
				//넘어온 option값이 null이 아닐때
				//option은 중간에 조작가능성이 있기 때문에 copy를 중심으로 비교해준다
				if("copy".equals(option)) {
					fileList.copyFile(file);
				}else if("delete".equals(option)) {
					fileList.deleteFile(file);
				}else if("move".equals(option)) {
					fileList.moveFile(file, movePath);
				}
				
		}
			else {
				if("copy".equals(option)) {
					fileList.copyFile(file);
				}else if("delete".equals(option)) {
					fileList.deleteFile(file);
				}else if("move".equals(option)) {
					fileList.moveFile(file, movePath);
				}
				
			}
		}
		//FileList에서 정의해준 메서드를 이용해 파일 리스트 생성
		List<File> filefile=fileList.getFileList(path);
//		if(delete!=null) {
//			fileList.deleteFile(path);
//		}
		
		if(filefile!=null) {
			//디스패치 형식으로 jsp로 전달하기때문에 원본 request값이 유지된다.
			//그래서 포워드 방식을 사용
			//request에 setattribute를 이용해 파일리스트를 전달
			req.setAttribute("file", filefile);
		}else {
			
		}
		
		// fileBrowser.jsp의 경로로  포워드방식으로  request와 response를 전달한다.
		// 포워드 방식이기 때문에 경로를 서버사이드 절대경로를 사용한다.
		String view="/WEB-INF/views/fileBrowser.jsp";
		RequestDispatcher rd= req.getRequestDispatcher(view);
		rd.forward(req, resp);
	}
}
