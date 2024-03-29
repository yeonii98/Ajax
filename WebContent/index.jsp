<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="css/bootstrap.css">
	<title>JSP AJAX</title>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
	<script type="text/javascript">
		var searchRequest = new XMLHttpRequest();
		var registerRequest = new XMLHttpRequest();
		function searchFunction(){//http request객체의 open()과 send() 사용하여 요청
			//true면 비동기식, false면 동기식
			searchRequest.open("POST","./UserSearchServlet?userName="+encodeURIComponent(document.getElementById("userName").value),true);
			//서버로 보낸 요청에 대한 응답을 받았을 때 어떤 동작을 할 것인지 정해야한다.
			searchRequest.onreadystatechange = searchProcess;//특정 함수 할당,어떤 변수도 전달하지 않는다.
			searchRequest.send(null);
		}
		function searchProcess(){//요청에 대한 상태가 변화할 때  불림
			var table = document.getElementById("ajaxTable");
			table.innerHTML = "";
			if(searchRequest.readyState == 4 && searchRequest.status == 200){
				//request.responseText:서버의 응답을 텍스트 문자열로 반환
				var object = eval('(' + searchRequest.responseText + ')');
				var result = object.result;//회원들의 정보가 담긴 배열
				for(var i = 0; i < result.length; i++){
					var row = table.insertRow(0);
					for(var j = 0; j < result[i].length; j++){
						var cell = row.insertCell(j);
						cell.innerHTML = result[i][j].value;
					}
				}
			}
		}
		function registerFunction(){
			registerRequest.open("POST","./UserRegisterServlet?userName=" + encodeURIComponent(document.getElementById("registerName").value) +
					"&userAge=" + encodeURIComponent(document.getElementById("registerAge").value) +
					"&userGender=" + encodeURIComponent($('input[name=registerGender]:checked').val()) +
					"&userEmail=" + encodeURIComponent(document.getElementById("registerEmail").value),true);
			registerRequest.onreadystatechange = registerProcess;//특정 함수 할당,어떤 변수도 전달하지 않는다.
			registerRequest.send(null);
		}
		function registerProcess(){
			if(registerRequest.readyState == 4 & registerRequest.status == 200){
				var result = registerRequest.responseText;
				if(result != 1){
					alert('등록에 실패했습니다.');
				}
				else {
					var userName = document.getElementById("userName");
					var registerName = document.getElementById("registerName");
					var registerAge = document.getElementById("registerAge");
					var registerEmail = document.getElementById("registerEmail");
					userName.value="";
					registerName.value="";
					registerAge.value="";
					registerEmail.value="";
					searchFunction();
				}
			}
		}
		window.onload = function(){
			searchFunction();
		}
	</script>
</head>
<body>
	<br>
	<div class="container">
		<div class="form-group row pull-right">
			<div class="col-xs-8">
				<input class="form-control" id="userName" onkeyup="searchFunction()" type="text" size="20">
			</div>
			<div class="col-xs-2">
				<button class="btn btn-primary" onclick="searchFunction();" type="button">검색</button>
			</div>
		</div>	
		<table class="table" style="text-align: center; border:1px solid #dddddd">
			<thead>
				<tr>
					<th style="background-color: #fafafa; text-align: center;">이름</th>
					<th style="background-color: #fafafa; text-align: center;">나이</th>
					<th style="background-color: #fafafa; text-align: center;">성별</th>
					<th style="background-color: #fafafa; text-align: center;">이메일</th>
				</tr>
			</thead>
			<tbody id="ajaxTable">
			</tbody>
		</table>
	</div>
	<div class ="container">
		<table class="table" style="text-align: center; border: 1px solid #dddddd">
			<thead>
				<tr>
					<th colspan="2" style="background-color: #fafafa; text-align:center;">회원 등록 양식</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td style="background-color: #fafafa; text-align:center;"><h5>이름</h5></td>
					<td><input class="form-control" type="text" id="registerName" size="20"></td>
				</tr>
				<tr>
					<td style="background-color: #fafafa; text-align:center;"><h5>나이</h5></td>
					<td><input class="form-control" type="text" id="registerAge" size="20"></td>
				</tr>
				<tr>
					<td style="background-color: #fafafa; text-align:center;"><h5>성별</h5></td>
					<td>
						<div class="form-group" style="text-align: center; margin: 0 auto;">
							<div class="btn-group" data-toggle="buttons">
								<label class="btn btn-primary active">
									<input type="radio" name="registerGender" autocomplete="off" value="남자" checked>남자
								</label>
								<label class="btn btn-primary">
									<input type="radio" name="registerGender" autocomplete="off" value="여자">여자
								</label>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td style="background-color: #fafafa; text-align:center;"><h5>이메일</h5></td>
					<td><input class="form-control" type="text" id="registerEmail" size="20"></td>
				</tr>
				<tr>
					<td colspan="2"><button class="btn btn-primary pul-right" onclick="registerFunction();" type="button">등록</button>
				</tr>
			</tbody>
			</table>
		</div>
</body>
</html>