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
            <h2><strong>${documentid.name}</strong></h2>

            <div class="product-img-1">
                <img src="../../resources/img/document.png"/>
            </div>

        </div>
        <div class="col-lg-6 description-of-the-product">
            <p class="name-of-product">
                <strong><spring:message code="product.characteristics"/></strong>
            </p>
            <div class="wrapper-for-ul">
                <ul>
                    <li><strong><spring:message code="product.description"/>:</strong></li>
                    <c:if test="${not empty documentid.owners.iterator().next().telephone}">
                        <li><strong><spring:message code="profile.telephone"/>:</strong></li>
                    </c:if>
                    <c:if test="${not empty documentid.name}">
                        <li><strong><spring:message code="OWNER"/>:</strong></li>
                    </c:if>
                    <c:if test="${not empty documentid.name}">
                        <li><strong>Подписан:</strong></li>
                    </c:if>
                </ul>
                <ul>
                    <li>${documentid.name}</li>
                    <li>${documentid.owners.iterator().next().telephone}</li>
                    <c:forEach items="${documentid.owners}" var="owner">
                        <li><a href="${contextPath}/account/${owner.username}">${owner.username}</a></li>
                    </c:forEach>
                    <li>${!sign}</li>
                </ul>

            </div>
            <c:if test="${!pageContext.request.userPrincipal.name.equals(documentid.owners.iterator().next().username) and sign}">
                <div>
                    <a class="btn btn-success"
                       href="${contextPath}/sign_by_user/${pageContext.request.userPrincipal.name}/document/${documentid.id}"
                       role="button" style="margin-bottom: 1%; margin-left: 90%">
                        <spring:message code="Sign"/></a>
                </div>
            </c:if>
        </div>
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