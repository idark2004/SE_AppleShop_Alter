<%-- 
    Document   : viewproduct
    Created on : May 24, 2021, 10:27:48 AM
    Author     : anime
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>ViewProduct</title>
        
        <link rel="stylesheet" href="css/mainP.css">
        <link rel="stylesheet" href="css/mainHoang.css">
        <link rel="stylesheet" href="css/base.css">
        <link rel="stylesheet" href="css/cartListIcon.css">
        <link rel="stylesheet" href="css/carticon.css">
        <link rel="preconnect" href="https://fonts.gstatic.com">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/8.0.1/normalize.min.css" integrity="sha512-NhSC1YmyruXifcj/KFRWoC561YpHpc5Jtzgvbuzx5VozKpWvQ+4nXhPdFgmx8xqexRcpAglTj9sIBWINXa8x5w==" crossorigin="anonymous" />
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
        <link href="fonts/fontawesome-free-5.15.3-web/css/all.css" rel="stylesheet">
        <% 
          String uri = request.getRequestURI();
          int lastIndex = uri.lastIndexOf("/");
            String resource = uri.substring(lastIndex + 1);
        %>
    </head>
    <body>
        <header class="header">

           <div class="shop-logo">
				<a href="Homepage.jsp" class="home-link" style="display: inline-block;">
					<section class="header_item" id="shopLogo">
						<h1><i class="fab fa-apple fa-2x"></i> SE15 Apple Store</h1>
					</section>
				</a>
             </div>


            <div class="login">
                <ul class="header_item_list">
                    <!-- If user logged in suscessfully , the item below wil showup and hide item other li item  -->
                    <c:if test="${sessionScope.user != null }">
                        <li class="header_item header__navbar-user">
                            <span class="header_item_user-name">Hello,${sessionScope.user.name}</span>
                            <ul class="header__navbar-user--menu">
                                    <li class="header__navbar-user--item">
                                         <a href="UserDetailController?userid=${sessionScope.user.userID}">User detail</a>
                                    </li>
                                    
                                    <li class="header__navbar-user--item">
                                        <a href="cartForm.jsp">Order detail</a>
                                    </li>
                                     <li class="header__navbar-user--item">
                                        <a href="OrderHistoryController?userid=${sessionScope.user.userID.trim()}">Order History</a>
                                    </li>
                                     <li class="header__navbar-user--item">
                                        <a href="changePass.jsp">Update Password</a>
                                    </li>
                                    <li class="header__navbar-user--item">
                                        <a href="">Sign out</a>
                                    </li>
                                </ul>
                        </li>
                    </c:if>
                    <c:if test="${sessionScope.user == null }">
                        <li class="header_item">
                            <a href="loginForm.jsp" class="header_item-link">Login</a>
                        </li>
                        <li class="header_item">
                            <a href="signup.jsp" class="header_item-link">Signup</a>
                        </li>
                    </c:if>
                </ul>
            </div> 
        </header>
             <div class="nav">
                <div class="topnav">
                    <div class="product-page">
                        <a class="product-link" href="ViewProductController?categoryID=&status=True" class="header-nav__item-active">All</a>
                        <a class="product-link" href="ViewProductController?categoryID=MB&status=True">Mac</a>
                        <a class="product-link" href="ViewProductController?categoryID=ID&status=True">iPad</a>
                        <a class="product-link" href="ViewProductController?categoryID=IP&status=True">iPhone</a>
                        <a class="product-link" href="ViewProductController?categoryID=AW&status=True">Apple Watch</a>
                        <a class="product-link" href="ViewProductController?categoryID=AS&status=True">Accessories</a>
                    </div>
                    <div class="responsive-div" style="display: flex; ">
                        <div class=" search-container">
                            <form action="" class="search-form">
                                <input type="text" placeholder="Search.." name="search">
                                <button type="submit"><i class="fa fa-search"></i></button>
                            </form>
                        </div>

                        <div class=" cart">
                            
                            <a class="cart-view" href="MainController?action=ViewCart">
                                <i class="carft-icon fas fa-shopping-cart"></i>
                                <c:forEach var="cartItem" items="${sessionScope.cart}">
                                    <c:set var="subtotalCount" value="${cartItem.quantity}"/>
                                    <c:set var="subtotal" value="${subtotal+cartItem.quantity}"/>
                                </c:forEach>
                                <span class="cart-items">${subtotal}</span>
                            
                            </a>
                            <c:choose>
                                <c:when test="${sessionScope.cart == null}">
                                     <div class="header__cart-list header__cart-list--no-cart">

                                         <img src="images/no-cart.png" alt="" class="header___cart--no-cart---img">
                                         <span class="header__cart-list--no-cart-msg">Empty Cart</span>

                                     </div>     
                                </c:when>
                                <c:otherwise>
                                    <div class="header__cart-list">                                                              
                                        <header class="header__cart-heading">
                                            <h4 >View cart</h4>
                                        </header>
                                        <ul class="header__cart-list--item">
                                            <c:forEach var="cartItem" items="${sessionScope.cart}">
                                                <li class="header__cart-item">
                                                    <img src="${cartItem.product.image}" alt="" class="header__cart-img">
                                                    <div class="header__cart-item--info">
                                                        <div class="header__cart-item--head">
                                                            <h5 class="header__cart-item--name">
                                                                ${cartItem.product.name}
                                                            </h5>
                                                            <div class="header__cart-item-price--wrap">
                                                            <span class="header__cart-item--price"><fmt:formatNumber type="number" maxFractionDigits = "0" value="${cartItem.product.price}"/>VND</span>
                                                            <span class="header__cart-item--multiplication">x</span>
                                                            <span class="header__cart-item--quantity">${cartItem.quantity}</span>
                                                            </div>
                                                        </div>
                                                        <div class="header__cart-item--body">
                                                            <span class="header__cart-item--description">
                                                                color:${cartItem.product.color} | ram-storage:${cartItem.product.ram}-${cartItem.product.storage}
                                                            </span>
                                                            <span class="header__cart-item--remove"><a 
                                                                    href="MainController?action=RemoveCart&page=<%=resource%>&productID=${cartItem.product.productID.trim()}&color=${cartItem.product.color.trim()}&ram=${cartItem.product.ram.trim()}&storage=${cartItem.product.storage.trim()}"
                                                            style="color:black;text-align: right;
                                                            padding:0;height: 20px;">Remove</a></span>
                                                        </div>
                                                    </div>
                                                                    
                                                </li>
                                            </c:forEach> 
                                        </ul>
                                        <a class="header__cart-view-cart btn btn__primary" href="MainController?action=ViewCart" style="background-color: #DDDDDD;color:black">View detail</a>
                                    </div> 
                                </c:otherwise>  
                        </c:choose>
                        </div>
                    </div>
                    
    
                </div>
            </div>
            <div class="app__container">
            <div class="product__filter">
                <div class="grid__row">
                    <div class="grid__column-2">
                        <nav class="category">
                            <h3 class="category__heading">
                                <i class="category__heading-icon fas fa-list"></i>
                                Categories
                            </h3>
                            <ul class="category-list">
                                <li class="category-item ">
                                    <a href="#" class="category__item-link ">
                                        All Products
                                    </a>
                                </li>
                                <li class="category-item">
                                    <a href="#" class="category__item-link">
                                        Iphone
                                    </a>
                                </li>
                                <li class="category-item">
                                    <a href="#" class="category__item-link">
                                        Ipad
                                    </a>
                                </li>
                                <li class="category-item">
                                    <a href="#" class="category__item-link">
                                        Mac
                                    </a>
                                </li>
                                <li class="category-item">
                                    <a href="#" class="category__item-link">
                                        Others
                                    </a>
                                </li>
                            </ul>
                            <div class="filter">
                                <label class="filter-option__lable" for="filter-option">OrderBy</label>
                                <select name="filter-option" id="filter-option">
                                    <option value="volvo">Name A-Z</option>
                                    <option value="saab">Name Z-A</option>
                                    <option value="mercedes">ASC Price</option>
                                    <option value="audi">DES Price</option>
                                </select>
                            </div>
                        </nav>

                    </div>
                    <c:choose>
                    <c:when test="${requestScope.PRODUCT_LIST != null}">
                    <div class="grid__column-10">
                        <div class="home__product">
                            <div class="grid__row">
                                <c:forEach var="product" items="${requestScope.PRODUCT_LIST}">
                                <div class="grid__column-2-4">
                                    <div class="home__product-item">
                                        <a href="MainController?action=ProductDetail&productID=${product.productID}" class="home__product-item-link">
                                            <div class="home__product-item--img" style="background-image: url(${product.image});">
                                            </div>
                                            <h4 class="home__product-item--name">
                                                ${product.name}
                                            </h4>
                                            <div class="home__product-item--price">
                                                <span style="font-size: 1.3rem;">From </span><span class="home__product-item--current-price"><fmt:formatNumber type="number" maxFractionDigits = "0" value="${product.price}" /></span>
                                                <a href="${product.productID}" class="home__product-add-to-cart--link"><i class="add-cart__icon fas fa-cart-plus"></i></a>
                                            </div>
                                        </a>  
                                    </div>  
                                </div>
                                </c:forEach>
                            </div>  
                            <!--Need to copy-->
                            <ul class="pagination pagination-product__space">
                                <li class="pagination-item">
                                    <a href="" class="pagination-item__link">
                                        <i class="pagination-item__icon fas fa-angle-left"></i>
                                    </a>
                                </li>
                                <li class="pagination-item pagination-item--active">
                                    <a href="" class="pagination-item__link">
                                        1
                                    </a>
                                </li>
                                <li class="pagination-item">
                                    <a href="" class="pagination-item__link">
                                        2
                                    </a>
                                </li>
                                <li class="pagination-item">
                                    <a href="" class="pagination-item__link">
                                        3
                                    </a>
                                </li>
                                <li class="pagination-item">
                                    <a href="" class="pagination-item__link">
                                        4
                                    </a>
                                </li>
                                <li class="pagination-item">
                                    <a href="" class="pagination-item__link">
                                        5
                                    </a>
                                </li>
                                <li class="pagination-item">
                                    <a href="" class="pagination-item__link">
                                        ...
                                    </a>
                                </li>
                                <li class="pagination-item">
                                    <a href="" class="pagination-item__link">
                                        14
                                    </a>
                                </li>
                                <li class="pagination-item">
                                    <a href="" class="pagination-item__link">
                                        <i class="pagination-item__icon fas fa-angle-right"></i>
                                    </a>
                                </li>
                            </ul>
                            <!--End need to copy-->
                        </div> 
                    </div>
                    </c:when>
                        <c:otherwise>
                            <h1>${requestScope.EMPTY_LIST.msg}</h1>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
        <footer class="footer">
            <div class="grid">
                <h2 class="foot-tittle">Contact us</h2>
                <div class="foot-info">    
                    <div class="foot-left-info">
                        <div class="foot-left-info__mail">
                            <i class="fas fa-envelope"></i>
                            <span class="foot-left-info__mail-addres">SE15AppleStore@gmail.com</span>
                        </div>
                        <div class="foot-left-info__phonenumber">
                            <i class="fas fa-phone-square-alt"></i>
                            <span class="foot-left-info__phonenumber-number">0839440343</span>
                        </div>
                        <div class="foot-left-info__shop-address">
                            <i class="fas fa-map-marker-alt"></i>
                            <span class="foot-left-info__shop-address-text">Số 69 Phố Trần Duy Hưng Hà Nội</span>
                        </div>
                    </div>
                    <div class="foot-right-info">
                        <div class="foot-right-info__apple-icon"><i class="fab fa-apple"></i></div>
                        <div class="foot-right-info__link">
                            <div class="foot-right-info__product">
                                <a href="" class="foot-right-info__product-link">Iphone</a>
                                <a href="" class="foot-right-info__product-link">Ipad</a>
                                <a href="" class="foot-right-info__product-link">Mac</a>
                                <a href="" class="foot-right-info__product-link">Others</a>
                            </div>
                            <div class="foot-right-info__policy">
                                <a href="" class="foot-right-info__policy-link">Privacy Policies</a>
                                <a href="" class="foot-right-info__policy-link">Sale and refund</a>
                            </div>
                        </div>
                    </div>      
                </div>
            </div>
        </footer>
    </body>
</html>
