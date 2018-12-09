<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content=" width=device-width, initial-scale=1.0">
    <title><spring:message code="PAGE_TITLE"/> <spring:message code="productbyid"/></title>
</head>

<body>

<%@include file="../layouts/preloader.jsp" %>
<%@include file="../layouts/high_menu_bar.jsp" %>
<div class="container content">
    <div class="row wrapper-for-product-in-productbyid">
        <div class="col-lg-4">
            <h2><strong>${productid.title}</strong></h2>

            <div class="product-img-1">
                <img width="250" height="250" src="https://drive.google.com/uc?export=download&confirm=no_antivirus&id=${productid.photo}"
                     onerror="this.src='${contextPath}/resources/img/placeholder-image.png'">

            </div>

            <security:authorize access="(hasRole('ROLE_ADMIN') or hasRole('ROLE_USER'))">
                <div class="product-icons">
                    <c:choose>
                        <c:when test="${favorite_products.contains(productid)}">
                            <a href="#" id="${productid.id}" class="icon-green">
                                <img src="${contextPath}/resources/img/heart.png">
                            </a>
                        </c:when>
                        <c:otherwise>
                            <a href="#" id="${productid.id}" class="icon">
                                <img src="${contextPath}/resources/img/heart.png">
                            </a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </security:authorize>

        </div>
        <div class="col-lg-6 description-of-the-product">
            <p class="name-of-product">
                <strong><spring:message code="product.characteristics"/></strong>
            </p>
            <div class="wrapper-for-ul">
                <ul>
                    <c:forEach items="${productid.attributesAndValues}" var="value">
                        <li><strong><spring:message code="${value.key}"/> :</strong></li>
                    </c:forEach>
                    <li><strong><spring:message code="product.cost"/>:</strong></li>
                    <li><strong><spring:message code="product.description"/>:</strong></li>
                    <c:if test="${not empty productid.phone}" >   <li><strong><spring:message code="profile.telephone"/>:</strong></li></c:if>
                 <c:if test="${not empty productid.owner}" > <li><strong><spring:message code="OWNER"/>:</strong></li></c:if>
                </ul>
                <ul>
                    <c:forEach items="${productid.attributesAndValues}" var="value">
                        <li>${value.value}</li>
                    </c:forEach>
                   <li> ${productid.cost}</li>
                   <li>${productid.description}</li>
                    <li>${productid.phone}</li>
                    <li><a href="${contextPath}/account/${productid.owner}">${productid.owner}</a></li>
                </ul>

            </div>

            <security:authorize access="(hasRole('ROLE_ADMIN') or hasRole('ROLE_USER')) and principal.username=='${productid.owner}' and '${productid.ownerStatus.equals(\"UNBLOCKED\")}'">
                <form action="" method="post">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    <a href="${contextPath}/product/edit/${productid.id}">
                        <img style="margin-left: 1000%;" src="${contextPath}/resources/img/gear.png">
                    </a>
                </form>
            </security:authorize>

        </div>

        <c:if test="${productid.productStatus.toString() == 'MODERATION'}">
            <sec:authorize access="hasRole('ROLE_ADMIN')">
                <div class="col-lg-2 btn-group-vertical align-middle">
                    <button type="button" name="${productid.id}" id="btn_accept" class="btn btn-primary"><spring:message
                            code="moderationButtonAccept"/></button>
                    <button type="button" name="${productid.id}" id="btn_deny" class="btn btn-primary"><spring:message
                            code="moderationButtonDeny"/></button>
                </div>
            </sec:authorize>
        </c:if>
    </div>
    <%@include file="../layouts/comment_layout.jsp" %>
    <%@include file="../layouts/footer_layout.jsp"%>
</div>
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

    $(document).on('click','#btn_accept',function(event) {

        var btn = document.getElementsByName(event.currentTarget.name)[0].disabled=true;
        var btn = document.getElementsByName(event.currentTarget.name)[1].disabled=false;

        event.preventDefault();
        var productId = event.currentTarget.name;
        $.ajax({
            url : "/not_moderated_accept",
            type : 'GET',
            dataType : 'json',
            contentType : "application/json",
            data : ({
                productId : productId
            })
        });
    });


    $(document).on('click','#btn_deny',function(event) {
        var btn = document.getElementsByName(event.currentTarget.name)[0].disabled=false;
        var btn = document.getElementsByName(event.currentTarget.name)[1].disabled=true;

        event.preventDefault();
        var productId = event.currentTarget.name;
        $.ajax({
            url : "/not_moderated_deny",
            type : 'GET',
            dataType : 'json',
            contentType : "application/json",
            data : ({
                productId : productId
            })
        });
    });

</script>