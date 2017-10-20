<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title>CPULoad</title>
</head>
<script src="../../jquery-2.1.1.js"></script>
<script type="text/javascript">

	function add(){
		var num=document.getElementById ("num").value;
		$.ajax({
			type: 'POST',
			url: '${pageContext.request.contextPath}/servlet/addServlet',
			data:{
				"num":num
			},
			dataType: 'text',
			success:function(obj){
				$("#addcount").text(obj.toString());
				document.getElementById ("num").value=''
			}
		});
	}

	function reduce(){
		var num=document.getElementById ("num2").value;
		$.ajax({
			type: 'POST',
			url: '${pageContext.request.contextPath}/servlet/reduceServlet',
			data:{
				"num":num
			},
			dataType: 'text',
			success:function(obj){
				$("#redcount").text(obj.toString());
				document.getElementById ("num2").value=''
			}
		});
	}
	function getenv(){
		$.ajax({
			type: 'POST',
			url: '${pageContext.request.contextPath}/servlet/getEnvServlet',
			dataType: 'text',
			success:function(obj){
			    var arrayObj = new Array();
			    var arrayObj = obj.toString().split(",");
			    var  envdiv = $("#envval");
			    for(var i=0;i<arrayObj.length;i++){
			      envdiv.append("<li>"+arrayObj[i]+"</li>");
			    }
			}
		});
	}
	function getcpuval(){
		$.ajax({
			type: 'POST',
			url: '${pageContext.request.contextPath}/servlet/getCpuRatioServlet',
			dataType: 'text',
			success:function(obj){
			    $("#cpucon").text(obj.toString());
			}
		});
	}

</script>
<body>
<%

		String userType = response.getHeader("userType");
		if(userType == null || userType.trim().equals(""))
		{
			RequestDispatcher disp = request.getRequestDispatcher(request.getContextPath() + "/index.jsp");
			disp.forward(request, response);
		}
	%>

        <div> Version 1
        </div>
        <p>Welcome: <%=userType%>.
	<div>
		<input type="button" id="addButton" onClick="add()" value="Add"/>
		<input type="text" id="num"></input>
		<span>&nbsp;&nbsp;</span>
	    <span id="addcount"></span>
	</div>
	<br/>
	<div>
		<input type="button" id="reduceButton" onClick="reduce()" value="Reduce"/>
		<input  type="text" id="num2"></input>
		<span>&nbsp;&nbsp;</span>
	    <span id="redcount"></span>
	</div>
	<br/>
	<div>
		<input type="button" id="cpuval" onClick="getcpuval()" value="CPU%"/>
		<span>&nbsp;&nbsp;</span>
	     <span id="cpucon"></span>
	</div>
	<br/>
	<div>
		<input type="button" id="env" onClick="getenv()" value="ENV"/>
		<div id="envval"></div>
	</div>

</body>
</html>
