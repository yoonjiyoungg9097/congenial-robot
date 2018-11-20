<%@page import="java.util.Locale"%>
<%@page import="java.text.DateFormatSymbols"%>
<%@page import="java.util.Calendar"%>
<%@page import="static java.util.Calendar.*"%><!-- 이걸 설정해주면 calendar.year하지 않고 그냥 YEAR해도 된다 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
	.sunday{
		/* 일요일의 칸은 빨간색으로 변경 */
		background-color: red;
	}
	.saturday{
		/* 토요일의 칸은 파란색으로 변경 */
		background-color: blue;
	}
	table{
		/* 달력에 스타일 줌 */
		width: 100%;
		height: 500px;
		border-collapse: collapse;
	}
	td,th{
		border: 1px solid black;
	}
</style>
<script type="text/javascript">/*  이전달, 다음달으 클릭했을때, form태그안에 입력했을때 모두 따로 처리하지 않고 eventHandler로 하나로 처리해준다*/
	function eventHandler(year, month) { //이전달이나 다음달을 클릭했을때 받아오는 값을 파라미터로
		var form = document.calForm;
		if((year && month)  || month==0 ){//자바는 year가 boolean타입이어야하지만 자바스크립트는 정해져있지 않다 반드시 값이 넘어올때만 true가 된다
			//자바에서 1월은 0으로 되어있는데 month==0이라는 조건이 없으면 year&&month에서 month가 false이기 때문에 if문에 들어오지 않는다
			//그래서 month==0이라는 조건을 추가해주게 되면 ture이기 때문에 조건문을 타게 되어서 1월에서 한번 더 이전달로 넘어갔을 때 전년도 달로 넘어갈 수 있게 된다
			form.year.value = year; //파라미터로 들어온 년도를 form의 년도에 셋팅된다
			form.month.value = month; //파라미터로 들어온 달을 form의 달에 셋팅된다
		}
		form.submit();
		return false;
	}
</script>
<%
	request.setCharacterEncoding("UTF-8"); //아래 파라미터에 특수문자가 있을경우 이와같은 코드를 통해 셋팅해준다
	String yearStr = request.getParameter("year");
	String monthStr = request.getParameter("month");
	String language = request.getParameter("language");
	Locale clinetLocale = request.getLocale();
	
	//언어를 선택하면 그 언어로 바뀌게 설정
	if(language!=null && language.trim().length()>0){
		clinetLocale = Locale.forLanguageTag(language);
	}
	//DateFormatSymbols 객체는 1-7이 자동으로 월-일이 되도록 해준다 //선택한 언어로 월화 나옴
	DateFormatSymbols symbols = new DateFormatSymbols(clinetLocale);
	
	
	Calendar cal = getInstance(); //캘린더 객체에서 사용할 수 있는 메서드들 
	
	//if문에 속하면 파라미터값으로 받은 년/월로 셋팅된다.
	if(yearStr !=null && yearStr.matches("\\d{4}") //널이 아니거나 숫자4개 0000년
			&& monthStr != null && monthStr.matches("1[0-1]|\\d")){//널이 아니거나 10에서 11이거나| 숫자이거나 0-9월
		cal.set(YEAR, Integer.parseInt(yearStr)); //년도와 달을 숫자형태로 바꿔준다
		cal.set(MONTH, Integer.parseInt(monthStr));
	}
	int currentYear = cal.get(YEAR); //현재의 년도
	int currentMonth = cal.get(MONTH); //현재의 달
	
	cal.set(DAY_OF_MONTH, 1);//현재의 달  셋팅
	int firstDayOfWeek = cal.get(DAY_OF_WEEK); //현재의 일 셋팅
	int offset = firstDayOfWeek -1; //첫주에서 무슨 요일로 시작하는지
	int lastDate = cal.getActualMaximum(DAY_OF_MONTH);
	
	//이전달
	cal.add(MONTH, -1);
	int beforYear = cal.get(YEAR); //이전년도 가져오기
	int beforMonth = cal.get(MONTH); //이전달 가져오기
	
	//다음달
	cal.add(MONTH, 2);
	int nextYear = cal.get(YEAR); //다음년도 가져오기
	int nextMonth = cal.get(MONTH); //다음달 가져오기
	
	//현재 시스템에서 제공하는 모든 locale정보 제공
	Locale[] locales = Locale.getAvailableLocales();
%>
<form name="calForm" method="post"><!-- get방식 ->post방식-->
<h4>
<%-- <a href="<%=request.getContextPath() %>/04/calendar.jsp?year=<%=beforYear %>&month=<%=beforMonth%>&language=<%=clinetLocale%>">이전달</a> --%>
<a href="javascript:eventHandler(<%=beforYear%>, <%=beforMonth%>);">이전달</a>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input type="number" name="year" value="<%=currentYear%>"
	onblur="eventHandler();"
/>년
<select name="month" onchange="eventHandler();">
	<%
		String[] monthStrings = symbols.getShortMonths();
		for(int idx = 0; idx < monthStrings.length-1; idx++){
			out.println(String.format("<option value='%d' %s>%s</option>", //%d정수형 %f실수형 %s문자열 %c문자
					idx, idx==currentMonth?"selected":"" ,monthStrings[idx])); 
			//삼항연산자인데 현재달과 선택한 달?이 일치할때 그 달에 selected를 주게 되어서 그 값이 선택되어있게 된다
		}
	%>
</select>
<select name="language" onchange="eventHandler();">
	<%
		//언어선택 UI	
		for(Locale tmp : locales){
			out.println(String.format("<option value='%s' %s>%s</option>", tmp.toLanguageTag(),
					tmp.equals(clinetLocale)?"selected":"",tmp.getDisplayLanguage(clinetLocale)));	
					//삼항연산자로 위에 달을 선택하는것과 비슷한 원리
		}
	%>
</select>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <!-- 공백을 의미한다 &nbsp; 이전달이라는 글자와 form자체사이의 띄어쓰기를 의미한다-->
<a onclick="eventHandler(<%=nextYear%>, <%=nextMonth%>);">다음달</a>
</h4>
<input type="hidden" value="calendar" name="command"/>
</form>
<table>
<thead>
	<tr>
		<%
			//요일출력
			String[] dateStrings = symbols.getShortWeekdays();//long은 월요일 ,화요일 short은 월,화 한국어
			for(int idx = Calendar.SUNDAY; idx<=Calendar.SATURDAY; idx++){
				out.println(String.format("<th>%s</th>", dateStrings[idx]));
			}
		%>
	</tr>
</thead>
<tbody>

<%
	//날짜 출력
	int dayCount = 1;
	for(int row=1; row <=6; row++){
		%>
		<tr>
		<%
		for(int col=1; col <=7; col++){
			int dateChar = dayCount++ - offset; //날짜를 맞게 출력
			if(dateChar < 1 || dateChar > lastDate){
				out.println("<td>&nbsp;</td>");
			}else{	
				String clzValue = "normal";
				if(col==1){
					clzValue = "sunday";
				}else if(col==7){
					clzValue = "saturday";
				}
			out.println(String.format(
					"<td class='%s'>%d</td>", clzValue, dateChar
					));
			}
		}
		%>
		</tr>
		<%
	}
%>
</tbody>
</table>
