<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <link href="${contextPath}/resources/css/catalog.css" rel="stylesheet">

</head>

<body>

<script type="text/JavaScript"
        src="${pageContext.request.contextPath}/resources/js/jquery-3.2.1.min.js">
</script>

<div class="container content">

    <div class="col-xs-12" id="msg" style="font-size: x-large; text-align: center">
        <label class="msg"></label>
    </div>

    <div class="col-lg-12">

        <div class="products">

            <c:forEach items="${products}" var="product">
                <div class="col-sm-4">
                    <div class="product">
                        <div class="product-img">
                            <a class="prod-img" href="#">
                                <img height="200" width="300" src="https://drive.google.com/uc?export=download&confirm=no_antivirus&id=${product.photo}"
                                     onerror="this.src='${contextPath}/resources/img/placeholder-image.png'"/>
                            </a>
                            <sec:authorize access="hasRole('ROLE_USER') or hasRole('ROLE_ADMIN')">

                                <div class="product-icons" id="${product.title}">
                                    <c:choose>
                                    <c:when test="${favorite_products.contains(product)}">
                                        <a href="#" id="${product.id}" class="icon-green">
                                            <img src="${contextPath}/resources/img/heart.png" >
                                        </a>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="#" id="${product.id}" class="icon">
                                            <img src="${contextPath}/resources/img/heart.png">
                                        </a>
                                    </c:otherwise>
                                    </c:choose>
                                </div>

                            </sec:authorize>
                        </div>

                        <p class="product-title">
                            <a class="product-title" href="${contextPath}/product/${product.id}">
                                <strong>${product.title}</strong>
                            </a>
                        </p>

                        <p class="product-desc">${product.description}</p>
                        <p class="product-category"><spring:message code="${product.category}"/> </p>
                        <p class="product-price">${product.cost}</p>
                    </div>
                </div>
            </c:forEach>
        </div>

    </div>
</div>

<script src="${contextPath}/resources/js/bootstrap.min.js"></script>

</body>

<script>
    $(document).on('click','.icon',function(event) {
        event.preventDefault();
        var productId = event.currentTarget.id;

        $.ajax({
            url : "/add-product-to-favorites",
            type : "GET",
            dataType : 'json',
            contentType : "application/json",
            data : ({
                productId : productId
            }),
            complete: function () {
                $('#' + productId).addClass('icon-green').removeClass('icon');
            }
        });
    });

    $(document).on('click','.icon-green',function(event) {
        event.preventDefault();
        var productId = event.currentTarget.id;

        $.ajax({
            url : "/remove-product-from-favorites",
            type : "GET",
            dataType : 'json',
            contentType : "application/json",
            data : ({
                productId : productId
            }),
            complete: function () {
                $('#' + productId).addClass('icon').removeClass('icon-green');
            }
        });
    });

</script>