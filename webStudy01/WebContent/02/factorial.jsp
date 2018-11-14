<%@page import="java.math.BigDecimal"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%!// 	double factorial(int operand){//long이 표현할 수 있는 비트수가 부족하기때문에
// 		if(operand<0){//음수일때는 팩토리얼이 실행될 수 없는 조건
// 			throw new IllegalArgumentException("음수는 팩토리얼 연산 불가");//uncheckedException 또는 Runtime
// 		}else if(operand<=1){
// 			return operand;
// 		}else{
// 			return operand*factorial(operand-1);
// 		}
// 	}

	BigDecimal factorial(int operand) {//long이 표현할 수 있는 비트수가 부족하기때문에
		if (operand < 0) {//음수일때는 팩토리얼이 실행될 수 없는 조건
			throw new IllegalArgumentException("음수는 팩토리얼 연산 불가");//uncheckedException 또는 Runtime
		} else if (operand <= 1) {
			return new BigDecimal(operand);
		} else {
			return new BigDecimal(operand).multiply(factorial(operand-1));
		}
	}%>   
 
<%
	String operandStr = request.getParameter("operand");
	boolean flag = false;
	
	if(operandStr != null && operandStr.matches("\\d{2}|100")){//{3}으로 해버리면 100보다 넘는수도 포함되기때문에
		flag = true;
	}
			
		
	%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>02/factorial.jsp</title>
</head>
<body>
	<form action="<%=request.getContextPath() %>/02/factorial.jsp">
		Factorial operand : <input type="number" min="1" max="100" 
								name="operand" value="<%= operandStr%>"/>
		<button type="submit">전송</button>
	</form>
	
	
<%-- 	
	
// 	String operandStr = request.getParameter("operand");
// 	boolean flag = false;
// 	int operand = 0;
// 	if(operandStr != null && operandStr.matches("\\d{2}|100")){//{3}으로 해버리면 100보다 넘는수도 포함되기때문에
// 		operand = Integer.parseInt(operandStr);
// 	}
	
// 	if(operand>=1 &&operand<=100){
// 		out.print("<div>"+factorial(operand)+"</div>");
// 	}
// // 		long result=1;
// // 		for(int i=10; i>=1; i--){
// // 			result *= i;
// // 		}
		
 --%>
 <%
 	if(flag){
 		int operand = Integer.parseInt(operandStr);
 	
 %>
	
	<div>
		<%=factorial(operand) %>
	</div>
<%
 	}
%>
</body>
</html>