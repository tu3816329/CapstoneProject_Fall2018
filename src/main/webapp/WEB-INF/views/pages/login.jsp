<%@ page session="false" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="a"%>

<div class="limiter">
	<div class="container-login100"
		style="background-image: url('${pageContext.servletContext.contextPath}/resources/login/images/math-bg.jpg');">
		<div class="wrap-login100">
			<form class="login100-form validate-form" name="f"
				action="j_spring_security_check" method="post">
				<span class="login100-form-logo"> <img
					src="${pageContext.servletContext.contextPath}/resources/login/images/icons/math.png"
					width="65px">
				</span>

				<span class="login100-form-title p-b-34 p-t-27">
					Đăng nhập
				</span>

				<a:if test="${param.error eq true}">
					<span style="color: white"> Tên đăng nhập hoặc mật khẩu không
						hợp lệ </span>
					<br><br>
				</a:if>

				<div class="wrap-input100 validate-input"
					data-validate="Enter username">
					<input class="input100" type="text" name="username"
						placeholder="Username"> <span class="focus-input100"
						data-placeholder="&#xf207;"></span>
				</div>

				<div class="wrap-input100 validate-input"
					data-validate="Enter password">
					<input class="input100" type="password" name="password"
						placeholder="Password"> <span class="focus-input100"
						data-placeholder="&#xf191;"></span>
				</div>

				<div class="container-login100-form-btn">
					<button type="submit" class="login100-form-btn">Đăng nhập
					</button>
				</div>
			</form>
		</div>
	</div>
</div>

<div id="dropDownSelect1"></div>