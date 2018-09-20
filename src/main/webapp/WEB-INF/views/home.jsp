<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="a" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page session="false" contentType="text/html; charset=UTF-8" %>
<html>
<head>
	<title>Home</title>
	
	<!-- Jquery -->
	<script type="text/javascript" src="${pageContext.servletContext.contextPath}/resources/jquery/jquery-3.2.1.js"></script>
	<script type="text/javascript" src="${pageContext.servletContext.contextPath}/resources/jquery/jquery-3.2.1.min.js"></script>
	
	<!-- MathJax -->
	<script type="text/javascript" 
				src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.5/latest.js?
					config=TeX-MML-AM_CHTML" async></script>
					
	<!-- Bootstrap -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	
	<style>
		body{display: grid; grid-template-columns: 60% 40%}
		#left{padding-left: 7px}
		#right{padding: 10px 20px}
		.dropdown{margin-bottom: 10px; display: inline-block}
		#btnSave{display: none}
		textarea{width: 100%}
		iframe{border: none}
		#keyboard{margin-top: 10px}
		.tab {overflow: hidden; border: 1px solid #ccc; background-color: #f1f1f1}
		.tab button {background-color: inherit; float: left; border: none; outline: none; font-weight: bold;
					cursor: pointer; padding: 14px 16px; transition: 0.3s; font-size: 14px}
		.tab button:hover {background-color: #ddd}
		.tab button.active {background-color: #ccc}
		.tabcontent {display: none; padding: 6px 12px; border-top: none}
		
		/* Math Button */
		#general-key .fkey, #other-key .fkey{float: left}
		#general-key .fkey{height: 51px; width: 32px}
		.tabcontent:after, #general-key:after, #other-key:after{content: " "; display: block; clear: both}
		#other-key{width: 100%; margin-top: 10px}
		.tabcontent{padding: 6px 0}
		#other-key .fkey{margin-left: 5px; margin-top: 5px}
		#Algebra .fkey{height: 73.3px}
		#Derivation .fkey{height: 72.65px}
		#Statistics .fkey{height: 82.65px}
		#Matrices .fkey{height: 95.71px}
		#Trigonometry .fkey{height: 73.25px}
		
	</style>
</head>
<body>
	<div id="left">
		<h1>Math Formulas</h1>
		<div class="dropdown div-drop">
			<button class="btn btn-default dropdown-toggle div-btn"
				type="button" data-toggle="dropdown">
				Chọn lĩnh vực <span class="caret"></span>
			</button>
			<ul class="dropdown-menu div-drop-menu">
				<a:forEach items="${DIVISIONS}" var="dvs">
					<li><a href="${dvs.id}">${dvs.name}</a></li>
				</a:forEach>
			</ul>
		</div>
		<div class="dropdown cat-drop">
			<button class="btn btn-default dropdown-toggle cat-btn"
				type="button" data-toggle="dropdown">
				Chọn loại <span class="caret"></span>
			</button>
			<ul class="dropdown-menu cat-drop-menu">
			</ul>
		</div>
		<input type="hidden" id="catId">
		<button class="btn btn-warning" id="btnUpload">Add image</button>
		<div id="imgDiv" style="margin-bottom: 10px; display: none">
			Image URL <input type="text" id="imgUrl" size="40">
			<button id="addImg" class="btn btn-success">Add</button>
			<button id="cancelAddImg" class="btn btn-danger">Cancel</button>
		</div>
		<!-- <input id="imgFile" name="imageFile" type="file" class="form-control-file" 
					accept="image/*" style="display: none"> -->
		<button class="btn btn-primary" id="btnSave">Save Formula</button>
		
		<script>
			$("#btnUpload").click(function () {
				$(this).hide();
				$("#imgDiv").css("display","block");
			});

			$("#cancelAddImg").click(function () {
				$("#btnUpload").show();
				$("#imgDiv").css("display","none");
				$("#imgUrl").val('');
			});

			$("#addImg").click(function () {
				var imgUrl = $("#imgUrl").val();
				var xhr = new XMLHttpRequest();
				xhr.onload = function() {
					var reader = new FileReader();
				    reader.onloadend = function() {
				    	var curText = $("#input").val();
				    	alert('add image: ' + curText);
				    	var base64ImgCode = reader.result;
						$("#input").val(curText + '\n' + base64ImgCode + '\n');
						$("#input").focus();
				    }
				    reader.readAsDataURL(xhr.response);
				};
				xhr.open('GET', imgUrl);
				/* xhr.setRequestHeader('Access-Control-Allow-Origin', '*'); */
				xhr.responseType = 'blob';
				xhr.send();
				$("#cancelAddImg").click();
			});
		</script>
		
		<script>
			$(".div-drop-menu").find("a").click(function (e) {
				e.preventDefault();
				$(".div-btn").text($(this).text() + " ")
							.append($('<span class="caret">'));
				$(".cat-btn").text("Chọn loại ")
							.append($('<span class="caret">'));

				$.ajax({
					url : 'get-categories-by-division?divId=' + $(this).attr('href'),
					type : 'GET',
					contentType : 'application/json',
					dataType: 'json',
					success: function(res) {
						var cats = JSON.parse(res.categories);
						$(".cat-drop-menu").empty();
						for(var i = 0; i < cats.length; i++) {
							$(".cat-drop-menu")
									.append($('<li>')
											.append($('<a href="' + cats[i].id + '">')
													.append(cats[i].categoryName)
											)
									)
						}

						$(".cat-drop-menu").find('a').click(function (e) {
							e.preventDefault();
							$("#catId").val($(this).attr('href'));
							$(".cat-btn").text($(this).text() + " ")
										.append($('<span class="caret">'));
							$("#btnSave").css('display', 'inline-block');
						});
					},
					error: function(res) {
						alert('Some errors occured');
					}
				});
			});

			$("#btnSave").click(function () {
				if ($.trim($('#input').val())) {
					var input = $('#input').val();
					var data = {
						'id' : 0,
						'detail' : input
					};
					console.log(input);
					$.ajax({
						url : 'save-formula?catId=' + $("#catId").val(),
						type : 'POST',
						dataType : 'json',
						contentType : 'application/json',
						data : JSON.stringify(data),
						success: function(res) {
							alert("Saved!")
						},
						error: function(res) {
							alert('Save formula fail');
						}
					});
				}
			});
		</script>
		
		<textarea type="text" id="input" rows="8"></textarea>
		<div id="keyboard">
			<div id="general-key">
				<button class="fkey">\[ \lt \]</button>	
				<button class="fkey">\[ \gt \]</button>
				<button class="fkey">\[ \le \]</button>
				<button class="fkey">\[ \ge \]</button>
				<button class="fkey">\[ \gg \]</button>
				<button class="fkey">\[ \approx \]</button>
				<button class="fkey">\[ \simeq \]</button>
				<button class="fkey">\[ \ne \]</button>
				<button class="fkey">\[ \equiv \]</button>
				<button class="fkey">\[ \pm \]</button>
				<button class="fkey">\[ \mp \]</button>
				<button class="fkey">\[ \times \]</button>
				<button class="fkey">\[ \to \]</button>
				<button class="fkey">\[ \Leftrightarrow \]</button>
				<button class="fkey">\[ \Rightarrow \]</button>
				<button class="fkey">\[\exists \]</button>
				<button class="fkey">\[\forall \]</button>
				<button class="fkey">\[ \wedge \]</button>
				<button class="fkey">\[ \vee \]</button>
				<button class="fkey">\[ \in \]</button>
				<button class="fkey">\[ \notin \]</button>
				<button class="fkey">\[ \cup \]</button>
				<button class="fkey">\[ \cap \]</button>
				<button class="fkey">\[ \subset \]</button>
				<button class="fkey">\[ \supset \]</button>
				<button class="fkey">\[ \subseteq \]</button>
				<button class="fkey">\[ \supseteq \]</button>
				<button class="fkey">\[ \not\subset \]</button>
				<button class="fkey">\[\emptyset \]</button>
				<button class="fkey">\[\infty \]</button>
				<button class="fkey">\[\Delta \]</button>
				<button class="fkey">\[\angle \]</button>
				<button class="fkey">\[ \bot \]</button>
				<button class="fkey">\[\parallel \]</button>
				<button class="fkey">\[\alpha \]</button>
				<button class="fkey">\[\beta \]</button>
				<button class="fkey">\[\chi \]</button>
				<button class="fkey">\[\varepsilon \]</button>
				<button class="fkey">\[\phi \]</button>
				<button class="fkey">\[\varphi \]</button>
				<button class="fkey">\[\sigma \]</button>
				<button class="fkey">\[\omega \]</button>
				<button class="fkey">\[\mu \]</button>
			</div>
			
			<div id="other-key">
				<div class="tab">
					<button class="tablinks" onclick="openCity(event, 'Algebra')" id="defaultOpen">Algebra</button>
				  	<button class="tablinks" onclick="openCity(event, 'Derivation')">Derivation</button>
				  	<button class="tablinks" onclick="openCity(event, 'Statistics')">Statistics</button>
				  	<button class="tablinks" onclick="openCity(event, 'Matrices')">Matrices</button>
				  	<button class="tablinks" onclick="openCity(event, 'Sets')">Sets</button>
				  	<button class="tablinks" onclick="openCity(event, 'Trigonometry')">Trigonometry</button>
				  	<button class="tablinks" onclick="openCity(event, 'Geometry')">Geometry</button>
				</div>
			
				<div id="Algebra" class="tabcontent">
					<button class="fkey" content="\[\mathop {\lim }\limits_{x \to \infty } \]">\[\mathop {\lim }\limits_{x \to \infty } \]</button>
				  	<button class="fkey">\[\frac{{n!}}{{r!\left( {n - r} \right)!}}\]</button>
				  	<button class="fkey">\[\frac{a}{b}\]</button>
				  	<button class="fkey">\[\left[ {0,1} \right]\]</button>
				  	<button class="fkey">\[\infty \]</button>
				  	<button class="fkey">\[\sqrt x \]</button>
				  	<button class="fkey">\[\sqrt[x]{y}\]</button>
				  	<button class="fkey">\[\sqrt {{a^2} + {b^2}} \]</button>
				  	<button class="fkey">\[\sqrt {{b^2} - 4ac} \]</button>
				  	<button class="fkey">\[\frac{{ - b \pm \sqrt {{b^2} - 4ac} }}{{2a}}\]</button>
				</div>
				<div id="Derivation" class="tabcontent">
				  	<button class="fkey">\[\frac{{dy}}{{dx}}\]</button>
				  	<button class="fkey">\[\frac{{\Delta y}}{{\Delta x}}\]</button>
				  	<button class="fkey">\[\frac{{\delta y}}{{\delta x}}\]</button>
				  	<button class="fkey">\[\frac{{{\partial ^2}\Omega }}{{\partial {u^2}}}\]</button>
				  	<button class="fkey">\[\frac{{{\partial ^2}\Omega }}{{\partial u\partial v}}\]</button>
				  	<button class="fkey">\[\mathop {\lim }\limits_{\delta x \to 0} \]</button>
				  	<button class="fkey">\[dx\]</button>
				  	<button class="fkey">\[\partial x\]</button>
				</div>
				<div id="Statistics" class="tabcontent">
				  	<button class="fkey">\[\sum\limits_{i = 1}^n {{X_i}} \]</button>
				  	<button class="fkey">\[\sum\limits_{i = 1}^n {X_i^2} \]</button>
				  	<button class="fkey">\[\sum\limits_{i = 1}^n {{X_i}{Y_i}} \]</button>
				  	<button class="fkey">\[\sum\limits_{i = 1}^n {{{({X_i} - \bar X)}^2}} \]</button>
				  	<button class="fkey">\[{X_1}, \ldots ,{X_n}\]</button>
				  	<button class="fkey">\[\frac{{x - \mu }}{\sigma }\]</button>
				  	<button class="fkey">\[{\mu _X}\]</button>
				  	<button class="fkey">\[{\sigma _X}\]</button>
				  	<button class="fkey">\[\sigma _X^2\]</button>
				  	<button class="fkey">\[\bar X\]</button>
				</div>
				<div id="Matrices" class="tabcontent">
				  	<button class="fkey">\[\left( {\begin{array}{*{20}{c}}{{a_{11}}}&{{a_{12}}}\\{{a_{21}}}&{{a_{22}}}\end{array}} \right)\]</button>
				  	<button class="fkey">\[\left( {\begin{array}{*{20}{c}}
										{{a_{11}}}&{{a_{12}}}&{{a_{13}}}\\
										{{a_{21}}}&{{a_{22}}}&{{a_{23}}}\\
										{{a_{31}}}&{{a_{32}}}&{{a_{33}}}
										\end{array}} \right)\]</button>
					<button class="fkey">\[\left( {\begin{array}{*{20}{c}}
										{{a_{11}}}&{{a_{12}}}&{{a_{13}}}\\
										{{a_{21}}}&{{a_{22}}}&{{a_{23}}}\\
										{{a_{31}}}&{{a_{32}}}&{{a_{33}}}
										\end{array}} \right)\]</button>
					<button class="fkey">\[\left( {\begin{array}{*{20}{c}}
										a&b\\
										c&d
										\end{array}} \right)\]</button>
				</div>
				<div id="Sets" class="tabcontent">
				  	<button class="fkey">\[\bigcup\limits_{i = 1}^n {{X_i}} \]</button>
				  	<button class="fkey">\[\bigcap\limits_{i = 1}^n {{X_i}} \]</button>
				</div>
				<div id="Trigonometry" class="tabcontent">
				  	<button class="fkey">\[{\cos ^{ - 1}}\theta \]</button>
				  	<button class="fkey">\[{\sin ^{ - 1}}\theta \]</button>
				  	<button class="fkey">\[\arcsin \theta \]</button>
				  	<button class="fkey">\[{e^{i\theta }}\]</button>
				  	<button class="fkey">\[\frac{{{\rm{Opposite}}}}{{{\rm{Hypotenuse}}}}\]</button>
				  	<button class="fkey">\[\left( {\frac{\pi }{2} - \theta } \right)\]</button>
				  	<button class="fkey">\[\theta \]</button>
				  	<button class="fkey">\[\varphi \]</button>
				  	<button class="fkey">\[{90^ \circ }\]</button>
				</div>
				<div id="Geometry" class="tabcontent">
				  	<button class="fkey">\[\overrightarrow {AB} \]</button>
				</div>
			</div>
		</div>
	</div>
	<div id="right">
		<h3>Preview</h3>
		<iframe scrolling="no" src="${pageContext.servletContext.contextPath}/showFormula?text=">
		</iframe>
	</div>
	
	<script>
		$("#input").on("input", function () {
			var input = encodeURIComponent($("#input").val());
			$('iframe').attr('src', "${pageContext.request.contextPath}/showFormula?text=" + input);
		});

		function openCity(evt, cityName) {
			var i, tabcontent, tablinks;
		    tabcontent = document.getElementsByClassName("tabcontent");
		    for (i = 0; i < tabcontent.length; i++) {
		        tabcontent[i].style.display = "none";
		    }
		    tablinks = document.getElementsByClassName("tablinks");
		    for (i = 0; i < tablinks.length; i++) {
		        tablinks[i].className = tablinks[i].className.replace(" active", "");
		    }
		    document.getElementById(cityName).style.display = "block";
		    evt.currentTarget.className += " active";
		}

		document.getElementById("defaultOpen").click();

		$('.fkey').click(function () {
			var fkeyText = '\\(' + $(this).find('script').text() + '\\)';
			var curText = $("#input").val();
			$("#input").val(curText + fkeyText);
			var input = encodeURIComponent($("#input").val());
			$('iframe').attr('src', "${pageContext.request.contextPath}/showFormula?text=" + input);
			$('#input').focus();
		});
	</script>
</body>
</html>
