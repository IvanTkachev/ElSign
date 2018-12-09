<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<%@ page contentType="text/html; charset=UTF-8"%>

<!DOCTYPE html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content=" width=device-width, initial-scale=1.0">
    <meta name="_csrf" content="${_csrf.token}"/>
    <meta name="_csrf_header" content="${_csrf.headerName}"/>
    <style>textarea{
    resize:none;
    } </style>
</head>
<body>

<script type="text/JavaScript"
        src="${pageContext.request.contextPath}/resources/js/jquery-3.2.1.min.js">
</script>

<script type="text/javascript">
    function doAjax() {

        var inputText = "${productid.id}";

        $.ajax({
            url : '/getcomments',
            type: 'GET',
            dataType: 'json',
            contentType: 'application/json',
            data : ({
                id: inputText
            }),
            success: function (data) {
                $('.wrapper-for-comments').empty();
                $.each(data, function(id, key){
                    var comment = "<div class=\"comment-in-product\">\n" +
                        "\n" +
                        "        <p class=\"comment-date\">"+key.date+"</p>\n" +
                        "        <p class=\"username\"><a href=\"${contextPath}/account/"+key.username+"\">"+key.username+"</a> </p>\n" +
                        "    <div class=\"image-of-user\">\n" +
                        "        <img src=\"https://drive.google.com/uc?export=download&confirm=no_antivirus&id="+ key.userPhoto+"\" onerror=\"this.src='${contextPath}/resources/img/placeholder-user.png'\"> \n" +
                        "    </div>\n" +
                        "    <div class=\"text-in-user-comment\">\n" +
                        "        <p class=\"comment\">"+key.text+"</p>\n" +
                        "    </div>\n" +
                        "</div>";
                    $('.wrapper-for-comments').append(comment);
                })

            }



        });
    }

</script>


<script type="text/javascript"> doAjax() </script>

<div class="block">
    <div class="wrapper-for-comments">

    </div>

<sec:authorize access="hasRole('ROLE_USER') or hasRole('ROLE_ADMIN')">
<form class="form-horizontal" id="comment-form">
    <p><h3><strong><spring:message code="form.comment"/></strong></h3><Br>
        <textarea id="textField" name="text" cols="60" rows="5"
                  placeholder="<spring:message code="comment.size"/>"    ></textarea>
        <input id="postId" type="hidden" name="postID" value="${productid.id}"/>
    </p>
    <button type="submit" id="btn" class="btn btn-success" value="Отправить"><spring:message code="button.send"/></button>

        </form>
    </sec:authorize>
</div>
</body>


<script>
    jQuery(document).ready(function($) {

        $("#comment-form").submit(function(event) {
            // Prevent the form from submitting via the browser.
            event.preventDefault();
            ajaxAddComment();
        });
    });

    $(function () {
        var token = $("meta[name='_csrf']").attr("content");
        var header = $("meta[name='_csrf_header']").attr("content");
        $(document).ajaxSend(function(e, xhr, options) {
            xhr.setRequestHeader(header, token);
        });
    });

    function ajaxAddComment() {

        var comment = {};
        comment["username"] = "${pageContext.request.userPrincipal.name}";
        comment["postId"] = $("#postId").val();
        comment["text"] = $("#textField").val();

        $.ajax({
            type : "POST",
            contentType : "application/json",
            url : "/addComment",
            data : JSON.stringify(comment),
            dataType : 'json',
            complete:function () {
                doAjax();
                $('form[id=comment-form]').trigger('reset');
            }
        });

    }

</script>