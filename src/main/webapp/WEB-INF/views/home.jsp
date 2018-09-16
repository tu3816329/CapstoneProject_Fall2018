<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" contentType="text/html; charset=UTF-8" %>
<html>
<head>
	<title>Home</title>
	<!-- Jquery -->
	<script type="text/javascript" src="${pageContext.servletContext.contextPath}/resources/jquery/jquery-3.2.1.js"></script>
	<script type="text/javascript" src="${pageContext.servletContext.contextPath}/resources/jquery/jquery-3.2.1.min.js"></script>
	
	<!-- jqMath -->
	<link rel="stylesheet" href="http://fonts.googleapis.com/css?family=UnifrakturMaguntia">
	<link rel="stylesheet" href="${pageContext.servletContext.contextPath}/resources/mathscribe/jqmath-0.4.3.css">
	
	<%-- <script src="${pageContext.servletContext.contextPath}/resources/mathscribe/jquery-1.4.3.min.js"></script> --%>
	<script src="${pageContext.servletContext.contextPath}/resources/mathscribe/jqmath-etc-0.4.6.min.js" charset="utf-8"></script>
	
	<style>
		span {
			color: red;
		}
		
		textarea{
			margin-left: 10px;
		}
		
		iframe{
			width: 100%;
			border: 0;
		}
	</style>
</head>
<body>
	<h1>Math Formulas</h1>
	<ul>
		<li><span class="special">$</span>, or <span class="special">\(</span> and
			<span class="special">\)</span>, to delimit inline mathematics</li>
		<li><span class="special">$$</span>, or <span class="special">\[</span> and
			<span class="special">\]</span>, to delimit block or “display” mathematics</li>
		<li><span class="special">^</span> for superscript</li>
		<li><span class="special">_</span> for subscript</li>
		<li><span class="special">{</span> and <span class="special">}</span> for grouping</li>
		<li><span class="special">↖</span> for overscript</li>
		<li><span class="special">↙</span> for underscript</li>
		<li><span class="special">\</span> or <span class="special">`</span> to quote the next
			character (turning off its special meaning), start a macro or multi-letter name, or
			make a name non-italic</li>
		<li><span class="special">\bo</span>, <span class="special">\it</span>, or
			<span class="special">\bi</span> for a bold, italic, or bold-italic variable
		</li><li><span class="special">\sc</span> or <span class="special">\fr</span> for a script or
			Fraktur letter
		</li><li><span class="special">\ov</span> for an overbar
		</li><li><span class="special">\table</span> for a matrix, table, or simply tabular alignment -
			separate entries with <span class="special">,</span> and rows with
			<span class="special">;</span></li>
		<li><span class="special">\text</span> or <span class="special">\html</span> for plain text
			or html inside mathematics - specify the text or html inside quotes (note \html only
			works inside a trusted source)</li>
		<li>spaces, tabs and newlines are ignored - jqMath formats the mathematics</li>
		<li>you can use <span class="special">\$</span> for a real $, or
			<span class="special">\\</span> for a \ if necessary
		</li>
	</ul>
	<p>$$<textarea type="text" id="input" rows="1" cols="60"></textarea>$$ produces:</p>
	<iframe scrolling="no" src="${pageContext.servletContext.contextPath}/showFormula?text=$$$$"></iframe>
	<script>
		$("#input").on("input", function () {
			var input = encodeURIComponent("$$" + $("#input").val() + "$$");
			var url = "$$" + input + "$$";
			$('iframe').attr('src', "${pageContext.request.contextPath}/showFormula?text=" + input);
		});
	</script>
</body>
</html>
