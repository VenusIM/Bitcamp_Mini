<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	
	<title>Insert title here</title>
	
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>

	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

	<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
	<link rel="stylesheet" href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
	<script src="https://cdn.bootpay.co.kr/js/bootpay-3.3.2.min.js" type="application/javascript"></script>
	<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
<style>
	body{
		padding-top : 70px;
	}
</style>
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>
<div class="container">
	 <strong>���ô±�</strong>
</div>
<div class="container">
	 <div id="googleMap" style="width: 100%;height: 700px;"></div>
	 
</div>
<div class="container">
	<div class="row">
		<div class="col-md-4"></div>
		<div class="col-md-4">
			<button class="btn btn-primary">���� ��ġ</button>
			<button class="btn btn-primary">���� ��ġ</button>
			<button class="btn btn-primary">�Ѵ��� ����</button>
		</div>
		<div class="col-md-4"></div>
		
	</div>
</div>
<script>



$(function(){
	
	$('button:contains("�Ѵ��� ����")').on("click",function(){
		if (navigator.geolocation) { // GPS�� �����ϸ�
		    navigator.geolocation.getCurrentPosition(function(position) {
		    latitude = position.coords.latitude;
		    longitude = position.coords.longitude;
		    var end = latitude+","+longitude;
		    const location = { lat: position.coords.latitude, lng: position.coords.longitude };
		    const mapOptions = { 
		    		center : { lat :(position.coords.latitude + 37.400973)/2 , lng: (position.coords.longitude + 127.104118)/2},
		            zoom:11
		      };
		    var map = new google.maps.Map(document.getElementById("googleMap"), mapOptions );
		  
		    
		    const marker = new google.maps.Marker({ map:map, position: location })
		    const marker2 = new google.maps.Marker({ map:map, position: {lat : 37.400973, lng : 127.104118}})
		    
		    
		    const infowindow = new google.maps.InfoWindow({
		        content: "<p>������ġ</p>"
		        
		      });
		    const infowindow2 = new google.maps.InfoWindow({
		    	content : "<p>������ġ</p><br/>"
		    				+ "<p>��ȣ : 080-123-4567</p><br/>"
		    				+ "<p>�����ð� : 9:30 ~ 22:00</p>"
		    });
		    
			
		      google.maps.event.addListener(marker, "click", () => {
		        infowindow.open(map, marker);
		      });
		      
		      google.maps.event.addListener(marker2, "click", () => {
			    infowindow2.open(map, marker2);
			  });
		   	
		    }, function(error) {
		      console.error(error);
		    }, {
		      enableHighAccuracy: false,
		      maximumAge: 0,
		      timeout: Infinity
		    });
		  } else {
		    alert('GPS�� �������� �ʽ��ϴ�');
		  }
	});

	$('button:contains("���� ��ġ")').on("click",function(){
		console.log("������ġ");
		if (navigator.geolocation) { // GPS�� �����ϸ�
		    navigator.geolocation.getCurrentPosition(function(position) {
		    latitude = position.coords.latitude;
		    longitude = position.coords.longitude;
		    
		    const location = { lat: position.coords.latitude, lng: position.coords.longitude };
		    
		    const mapOptions = { 
		    		center: location,
		            zoom:17
		      };
		    var map = new google.maps.Map(document.getElementById("googleMap"), mapOptions );
		    
		    const marker = new google.maps.Marker({ map:map, position: location })
		    const marker2 = new google.maps.Marker({ map:map, position: {lat : 37.400973, lng : 127.104118}})
		    
		    const infowindow = new google.maps.InfoWindow({
		        content: "<p>������ġ</p>"
		        
		      });
		    const infowindow2 = new google.maps.InfoWindow({
		    	content : "<p>������ġ</p><br/>"
    						+ "<p>��ȣ : 080-123-4567</p><br/>"
    						+ "<p>�����ð� : 9:30 ~ 22:00</p>"
		    });
		    
			
		      google.maps.event.addListener(marker, "click", () => {
		        infowindow.open(map, marker);
		      });
		      
		      google.maps.event.addListener(marker2, "click", () => {
			    infowindow2.open(map, marker2);
			  });
		    
		    }, function(error) {
		      console.error(error);
		    }, {
		      enableHighAccuracy: false,
		      maximumAge: 0,
		      timeout: Infinity
		    });
		  } else {
		    alert('GPS�� �������� �ʽ��ϴ�');
		  }
		
	});

	$('button:contains("���� ��ġ")').on("click",function(){
		console.log("���� ��ġ");
		getLocation();
	});
	
	getLocation();
});


function getLocation() {
	  
	if (navigator.geolocation) { // GPS�� �����ϸ�
	    navigator.geolocation.getCurrentPosition(function(position) {
	    latitude = position.coords.latitude;
	    longitude = position.coords.longitude;
	    
	    const location = { lat: position.coords.latitude, lng: position.coords.longitude };
	    
	    const mapOptions = { 
	    		center: {lat : 37.400973, lng : 127.104118},
	            zoom:17
	      };
	    var map = new google.maps.Map(document.getElementById("googleMap"), mapOptions );
	    
	    const marker = new google.maps.Marker({ map:map, position: location })
	    const marker2 = new google.maps.Marker({ map:map, position: {lat : 37.400973, lng : 127.104118}})
	    
	    const infowindow = new google.maps.InfoWindow({
	        content: "<p>������ġ</p>"
	        
	      });
	    const infowindow2 = new google.maps.InfoWindow({
	    	content : "<p>������ġ</p><br/>"
					+ "<p>��ȣ : 080-123-4567</p><br/>"
					+ "<p>�����ð� : 9:30 ~ 22:00</p>"
	    });
	    
		
	      google.maps.event.addListener(marker, "click", () => {
	        infowindow.open(map, marker);
	      });
	      
	      google.maps.event.addListener(marker2, "click", () => {
		    infowindow2.open(map, marker2);
		  });
	    
	    }, function(error) {
	      console.error(error);
	    }, {
	      enableHighAccuracy: false,
	      maximumAge: 0,
	      timeout: Infinity
	    });
	  } else {
	    alert('GPS�� �������� �ʽ��ϴ�');
	  }
}
     
 
      
</script> 
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyA2o8hbkl7NrOvFI0JOxMK0K8YdAKUEMkE"></script>



</body>
</html>