var request = null;

//request 생성 function Definition	 	 	
function createRequest(){	 	
	try{
		request = new XMLHttpRequest();
		alert ("XMLHttpRequest() 로 request instancet생성완료");
		}catch(trymicrosoft){
		try{
			request = new ActiveXObject("Msxml2.XMLHTTP");
			alert ("ActiveXObject(Msxml2.XMLHTTP) 로 request instancet생성완료");
		}catch(othermicrosoft){
			try{
				request =new ActiveXObject("Microsoft.XMLHTTP");
				alert ("new ActiveXObject(Microsoft.XMLHTTP) 로 request instancet생성완료");
			}catch(failed){
				request = null;
			}
		}
	}
	if( request == null ){
		alert ("request객체 생성시 error 발생함.");
	}
} 


//==> open() / callback Method지정 / send()를 처리하는 fuction Definition
function openSendRequest(httpURL, httpMETHOD, httpPARAM, callBackMethod){
	
	//url 결정
	var url = httpURL;
	//alert("1. url : "+url);
	
	//http method 결정
	var method = (httpMETHOD == "POST") ? "POST" : "GET";
	//alert("2. Method : "+method);
	
	//param 결정(QueryString)
	var param = httpPARAM;
	if( method == "GET" && param != null){
		url = url+"?"+param;
	}
	//alert("3. Param : "+param+" url : "+url);
	
	//callback 결정 
	var callBack = callBackMethod;
	//alert("4. callBack : "+callBack);
	
	//request를 Get/Post방식,해당url,비동기로 연결할 것을 결정(연결초기화)
	request.open(method,url,true);
	
	//send() 호출전 아래의 속성을 지정 respons시 callBack Method 지정			
	request.onreadystatechange =  callBack;

	//request시 data전송 header설정
	request.setRequestHeader('Content-Type','application/x-www-form-urlencoded');
	
	//Post방식일 경우 Param 전송
	param = (method == "POST") ? param : null;
	//alert("5. param : "+param);
	request.send( param );
}


//trim 정의 Function
function trim(str) {  
  		return str.replace(/^\s\s*/, '').replace(/\s\s*$/, '');  
}  