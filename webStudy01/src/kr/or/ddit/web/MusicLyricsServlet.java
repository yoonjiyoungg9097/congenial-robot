package kr.or.ddit.web;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FilenameFilter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.PrintWriter;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MusicLyricsServlet extends HttpServlet {
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ServletContext context = req.getServletContext();
		File folder = new File("d:/contents");
		String[] musicnames = folder.list(new FilenameFilter() {
			
			@Override
			public boolean accept(File dir, String name) {
				String mime = context.getMimeType(name);
				return mime.startsWith("text/");
			}
		});
		
		resp.setContentType("text/html;charset=UTF-8");
		InputStream in = this.getClass().getResourceAsStream("song.html");
		InputStreamReader isr = new InputStreamReader(in, "UTF-8");
		BufferedReader br = new BufferedReader(isr);
		StringBuffer html = new StringBuffer();
		String temp = null;
		while((temp = br.readLine())!= null) {
			html.append(temp+"\n");
		}
		
		StringBuffer sb = new StringBuffer();
		for(int i=0; i<musicnames.length; i++) {
			sb.append("<option>"+musicnames[i]+"</option>\n");
		}
		
		int start = html.indexOf("@Music");
		int end = start + "@Music".length();
		String replacetext = sb.toString();
		
		html.replace(start, end, replacetext);

		PrintWriter out = resp.getWriter();
		out.println(html.toString()); //html은 최종적으로 완성된 html코드
		out.close();
		
		String song = req.getParameter("music");
		if(song == null || song.trim().length()==0) {
			resp.sendError(400);
			return;
		}
		
		
	}	
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html;charset=UTF-8");
		String song = req.getParameter("music");
		if(song == null || song.trim().length()==0) {
			resp.sendError(400);
			return;
		}
		File folder = new File("d:/contents");
		File songFile = new File(folder,song);
		if(!songFile.exists()) {
			resp.sendError(404);//존재하지 않는다
			return;
		}
		
		// 컴퓨터에 있는 파일을 불러오는 용도
		FileInputStream fis = new FileInputStream(songFile);
		//가사내용을 받아오는 스트링버퍼객체 --------------------------------???
		StringBuffer sb = new StringBuffer();
		InputStreamReader isr2 = new InputStreamReader(fis, "EUC-KR");
		BufferedReader br2 = new BufferedReader(isr2);
		String temp2 = null;
		while((temp2=br2.readLine())!=null) {
			sb.append(temp2+"<br>");
		}
		
		
		////////////////////////////////////////////////////////////////////
		InputStream in = this.getClass().getResourceAsStream("songlyrics.html");
		InputStreamReader isr = new InputStreamReader(in, "UTF-8");
		BufferedReader br = new BufferedReader(isr);
		StringBuffer html = new StringBuffer();
		String temp = null;
		while((temp=br.readLine())!=null) {
			html.append(temp);
		}
		
		int start = html.indexOf("@songlyrics");
		int end = start+"@songlyrics".length();
		String rep = sb.toString();
		html.replace(start, end, rep);
		
		///////////////////////////////////////////////////////////////////
		PrintWriter out = resp.getWriter();
		out.println(html.toString()); //html은 최종적으로 완성된 html코드
		out.close();
		
	}
}
