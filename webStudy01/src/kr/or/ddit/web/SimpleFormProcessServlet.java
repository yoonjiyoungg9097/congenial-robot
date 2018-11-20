package kr.or.ddit.web;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Arrays;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;

import kr.or.ddit.vo.AlbasengVO;

import javax.servlet.annotation.*;


@WebServlet(value="/albamon", loadOnStartup=1)
//loadOnStartup : tomcat 실행시 무조건 실행(서블릿 실행시가 아니라)
//숫자가 0보다 크면 서버가 시작될 때 무조건 해당 서블릿을 초기화
//(숫자가 0에 가까울 수록 먼저 초기화, 숫자 중복시 먼저 작성된 서블릿부터 초기화)
//숫자가 음수일 경우 톰캣 호출시 서블릿이 호출되지 않고 그냥 보통의 서블릿으로 적용됨
//web.xml에서 설정 가능


//impleFormProcessServlet 클래스는 HttpServlet 클래스를 상속 받고 있으며,
//따라서 impleFormProcessServlet은 서블릿으로 동작할 수 있게 된다.
//서블릿은 자바를 이용하여 웹페이지를 동적으로 생성하는 서버측 프로그램
public class SimpleFormProcessServlet extends HttpServlet {
//   public static Map<String, String> gradeMap;
//   public static Map<String, String> licenseMap;
   public static Map<String, String> gradeMap;
   public static Map<String, String> licenseMap;
   
   //class가 메모리에 적재될때 실행됨 (DB라 가정)
   static {
      gradeMap = new HashMap<>();
      licenseMap = new LinkedHashMap<>();
      
      gradeMap.put("G001", "고졸");
      gradeMap.put("G002", "대졸");
      gradeMap.put("G003", "석사");
      gradeMap.put("G004", "박사");
      
      licenseMap.put("L001", "정보처리산업기사");
      licenseMap.put("L002", "정보처리기사");
      licenseMap.put("L003", "정보보안산업기사");
      licenseMap.put("L004", "정보보안기사");
      licenseMap.put("L005", "SQLD");
      licenseMap.put("L006", "SQLP");
      
   }
   //클래스이름.맵변수이름 static이기 때문에
//   public static Map<String, AlbasengVO> albasengs = new LinkedHashMap<>();
   public Map<String, AlbasengVO> albasengs = new LinkedHashMap<>();
   
   @Override
	public void init(ServletConfig config) throws ServletException {
		super.init(config);
		getServletContext().setAttribute("gradeMap", gradeMap);
		getServletContext().setAttribute("licenseMap", licenseMap);
		getServletContext().setAttribute("albasengs", albasengs);
		System.out.println(getClass().getSimpleName()+ " 초기화");
	}
   
   
   @Override
   protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
      req.setCharacterEncoding("UTF-8");
      
      resp.setContentType("text/plain;charset=UTF-8");
      
//      1. 하드코딩
//      String name = req.getParameter("name");
//      System.out.printf("%s : %s\n", "name", name);
//      String age = req.getParameter("age");
//      System.out.printf("%s : %s\n", "age", age);
//      String tel = req.getParameter("tel");
//      System.out.printf("%s : %s\n", "tel", tel);
//      String address = req.getParameter("address");
//      System.out.printf("%s : %s\n", "address", address);
//      String gender = req.getParameter("gender");
//      System.out.printf("%s : %s\n", "gender", gender);
//      String grade = req.getParameter("grade");
//      System.out.printf("%s : %s\n", "grade", grade);
//      String carrer = req.getParameter("carrer");
//      System.out.printf("%s : %s\n", "carrer", carrer);
//      
//      String license[] = req.getParameterValues("license");
//      System.out.printf("%s : %s\n", "license", Arrays.toString(license));
      
      
      
//      VO 객체 생성. 파라미터 할당
//      VO를 대상으로 검증
//      (이름, 주소, 전화번호 필수데이터 검증)
//      1)통과
//		code 생성 ("alba_001")
//		map.put(code, vo)
//		이동(/05/albaList.jsp, 요청 처리 완료 후 이동)
//	  2)불통
//		이동(/01/simpleForm.jsp, 기존 입력데이터를 전달한 채 이동)
      
      	req.setCharacterEncoding("UTF-8");
      	String name = req.getParameter("name");
      	String age = req.getParameter("age");
      	String tel = req.getParameter("tel");
      	String addr = req.getParameter("address");
      	String gender = req.getParameter("gender");
      	String grade = req.getParameter("grade");
      	String career = req.getParameter("career");
      	String[] license = req.getParameterValues("license");
      	
      	
      	AlbasengVO albaVO = new AlbasengVO();
      	req.setAttribute("albaVO", albaVO); 
      	albaVO.setName(name);
      	if(age!=null && age.matches("\\d{1,2}")) {
      		albaVO.setAge(new Integer(age));
      	}
      	albaVO.setTel(tel);
      	albaVO.setAddress(addr);
      	albaVO.setGender(gender);
      	albaVO.setGrade(grade);
      	albaVO.setCareer(career);
      	albaVO.setLicense(license);
      	
    	
      	boolean result = true; //3개의 검증에 통과하지 못했을 경우 false로 
      	Map<String, String> errors = new LinkedHashMap<>();
      	req.setAttribute("errors", errors);
      	if(StringUtils.isBlank(albaVO.getName())) {
      		result = false;
      		errors.put("name", "이름 누락");
      	}
      	if(StringUtils.isBlank(albaVO.getTel())) {
      		result = false;
      		errors.put("tel", "연락처 누락");
      	}
      	if(StringUtils.isBlank(albaVO.getAddress())) {
      		result = false;
      		errors.put("address", "주소 누락");
      	}
      	
//      	if(name==null||addr==null||tel==null
//      			||name.trim().length()==0||addr.trim().length()==0||tel.trim().length()==0) {
//      		page = "/01/simpleForm.jsp";
//      		result = false;
////      		RequestDispatcher rd = req.getRequestDispatcher(page);
////      		rd.forward(req, resp);
//      	}
      	
      	
      	
      	boolean redirct = false;
      	String page = null; 
      	if(result) {//list보여주는 곳으로 이동 - redirect
//      		page = "/05/albaList.jsp";
//      		String code = String.format("alba_%03d", albasengs.size()+1);
//      		albasengs.put(code,albaVO);
//      	    resp.sendRedirect(req.getContextPath()+page);
      		albaVO.setCode(String.format("alba_%03d", albasengs.size()+1));
      		albasengs.put(albaVO.getCode(), albaVO);
      		page = "/05/albaList.jsp";
      		result = true;
      	}else {//초기 form으로 이동 - dispatch
//      		RequestDispatcher rd = req.getRequestDispatcher(page);
//      		rd.forward(req, resp);
      		page = "/01/simpleForm.jsp";
      	}
      	
      	if(redirct) {
      		resp.sendRedirect(req.getContextPath() + page);
      	}else {
      		RequestDispatcher rd = req.getRequestDispatcher(page);
      		rd.forward(req, resp);
      	}
      
      
      
      
      
//      Enumeration<String> names = req.getParameterNames();
//      while (names.hasMoreElements()) {
//         String name = (String) names.nextElement();
//         String[] values = req.getParameterValues(name);
//         System.out.printf("%s : %s\n", name, Arrays.toString(values));
//      }
//      
//      Map<String,String[]> parameterMap = req.getParameterMap();
//      for (Entry<String, String[]> entry : parameterMap.entrySet()) {
//         String name = entry.getKey();
//         String[] value = entry.getValue();
//         System.out.printf("%s : %s\n", name, Arrays.toString(value));
//      }
//      StringBuffer sb = new StringBuffer();
//      sb.append(name +"\n");
//      sb.append(age + "\n");
//      sb.append(tel + "\n");
//      sb.append(address + "\n");
//      sb.append(gender + "\n");
//      switch(grade) {
//      case "g001":
//         sb.append("고졸\n");
//         break;
//      case "g002":
//         sb.append("대졸\n");
//         break;
//      case "g003":
//         sb.append("석사\n");
//         break;
//      case "g004":
//         sb.append("박사\n");
//         break;   
//      }
//      sb.append(carrer + "\n");
//      for (int i = 0; i < license.length; i++) {
//         switch (license[i]) {
//         case "L001":
//            sb.append(license);
//            break;
//
//         default:
//            break;
//         }
//      }
//      sb.append(license);
//
//      PrintWriter out = resp.getWriter();
//      out.println(sb.toString());
//      out.close();
//      
      
      
   }
}