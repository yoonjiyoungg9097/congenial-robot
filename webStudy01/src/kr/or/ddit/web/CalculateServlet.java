package kr.or.ddit.web;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.web.calculate.Operator;

public class CalculateServlet extends HttpServlet {
//	@FunctionalInterface
//	interface RealOperator{
//		public int operate(int left, int right);
//	}
	
	//final String add = "add";
//	enum Operator{	//열거형 상수집합
//		ADD("+", new RealOperator() {
//			@Override
//			public int operate(int left, int right) {
//				return left + right;
//			}
//		}),
//		MINUS("-", (left, right)->{return left-right;}),
//		MULTIPLY("*", (a, b)->{return a*b;}),//파라미터명은 중요하지 않다
//		DIVIDE("/", (c,d)->{return c/d;});	//각각 value를 가짐 각각 Operator타입
//		
//		
//		private String sign;
//		private RealOperator realOperator;
//		Operator(String sign, RealOperator realOperator){
//			this.sign = sign;
//			this.realOperator = realOperator;
//		}
//		public String getSign(){
//			return this.sign;
//		}
//		public int operate(int left, int right) {
//			return realOperator.operate(left, right);
//		}
//	}
	
//	class Operator{
//		final Operator ADD = new Operator();
//	}
	
	@Override
	public void init(ServletConfig config) throws ServletException {
		super.init(config);
//		getServletContext().setAttribute("", object);
		ServletContext application = getServletContext();
		String contentFolder = application.getInitParameter("contentFolder");
		File folder = new File(contentFolder);
		application.setAttribute("contentFolder", folder);
		System.out.println(getClass().getSimpleName()+ " 초기화");
	}
	
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		// 파라미터 확보 ( 입력태그의 name 속성값으로 이름 결정 )
		String leftOp = req.getParameter("leftOp");
		String operatorStr = req.getParameter("operator");
		String rightOp = req.getParameter("rightOp");
		System.out.println(operatorStr);
		int left, right = 0;
		boolean valid = true;
//		String sum = null;
		
		
		// 검증
		if(leftOp == null || !leftOp.matches("\\d+") 
			|| rightOp==null || !rightOp.matches("\\d{1,6}")){
			//resp.sendError(400);
			valid = false;
		}
		
		Operator operator = null;
		try {
			operator = Operator.valueOf(operatorStr.toUpperCase());//파라미터로 넘겨온 값을 대문자로 바꿔서
		}catch (Exception e) {//nullpointexception과 IlligalArgumentException둘다 잡아주기 위해서 상위인 exception을 catch해줌
			valid = false;
		}
		
//		if(rightOp == null || rightOp.trim().length()==0) {
//			resp.sendError(400);
//			return;
//		}
		
//		if(operator == null || operator.trim().length()==0) {
//			valid = false;
//		}
		
		if(!valid) {
			resp.sendError(HttpServletResponse.SC_BAD_REQUEST);
			return;
		}
		
		// 통과
		//   연산자에 따라 연산 수행
		// 	 	일반 텍스트의 형태로 연산 결과를 제공
		// 연산결과 : 2 * 3 = 6
		// 불통 400 에러 발생
//		if(operator.equals("add")) {
//			sum = left + "+" + right + "=" + (left+right);
//		}else if(operator.equals("minus")) {
//			sum = left + "-" + right + "=" + (left-right);
//		}else if(operator.equals("multiply")) {
//			sum = left + "*" + right + "=" + (left*right);
//		}else if(operator.equals("divide")) {
//			sum = left + "/" + right + "=" + (left/right);
//		}
		
		
		//System.out.println(right);
		//System.out.println(left);
		
//		switch (operator) {
//		case ADD:
//			result = String.format(pattern, left, "+", right, (left+right));
//			break;
//			
//		case MINUS:
//			result = String.format(pattern, left, "-", right, (left-right));
//			break;
//			
//		case MULTIPLY:
//			result = String.format(pattern, left, "*", right, (left*right));
//			break;
//			
//		case DIVIDE:
//			result = String.format(pattern, left, "/", right, (left/right));
//			break;
//
////		default:
////			break;
//		}
		
		
//		switch (operator) {
//		case ADD:
//			result = String.format(pattern, left, operator.getSign(), right, (left+right));
//			break;
//			
//		case MINUS:
//			result = String.format(pattern, left, operator.getSign(), right, (left-right));
//			break;
//			
//		case MULTIPLY:
//			result = String.format(pattern, left, operator.getSign(), right, (left*right));
//			break;
//			
//		case DIVIDE:
//			result = String.format(pattern, left, operator.getSign(), right, (left/right));
//			break;
//
////		default:
////			break;
//		}
		
		right = Integer.parseInt(rightOp);
		left = Integer.parseInt(leftOp);
		String pattern = "%d %s %d = %d";
		String result = String.format(pattern, left, operator.getSign(), right, operator.operate(left, right));
		String accept = req.getHeader("Accept");
		String mime = null;
		if(accept.contains("plain")) {
			mime = "text/plain;charset=UTF-8";
		}else if(accept.contains("json")) {
			mime = "application/json;charset=UTF-8";
			result = "{\"result\":\""+result+"\"}";
		}else {
			mime = "text/html;chartset=UTF-8";
		}
		
		resp.setContentType(mime);
		PrintWriter out = resp.getWriter();
		out.println(result);
		out.close();
	}
}
