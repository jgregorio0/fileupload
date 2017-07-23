<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %><%--
--%><%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %><%--
--%><%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %><%--
--%><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%--
--%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%--
--%>
<fmt:setLocale value="${cms.locale}" />
<!DOCTYPE html>
<html lang="${cms.locale}">
<head>
    <title>${cms.title}</title>
    <meta charset="${cms.requestContext.encoding}">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <cms:enable-ade/>

    <%--CSS OFFLINE--%>
    <c:if test="${not cms.isOnlineProject}">
        <cms:headincludes type="css" closetags="false"
                          defaults="%(link.weak:/system/modules/com.jgregorio.opencms.fileupload/resources/bootstrap-3.3.7/css/bootstrap.css:0aa3b944-6f9d-11e7-9758-f53d2dda7236)
			|%(link.weak:/system/modules/com.jgregorio.opencms.fileupload/resources/bootstrap-3.3.7/css/bootstrap-theme.css:09e942dc-6f9d-11e7-9758-f53d2dda7236)
			|%(link.weak:/system/modules/com.jgregorio.opencms.fileupload/resources/css/font-awesome.css:3bb2326e-6f9a-11e7-9758-f53d2dda7236)" />
    </c:if>

    <%--CSS ONLINE--%>
    <c:if test="${cms.isOnlineProject}">
        <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">
    </c:if>

    <%--JS OFFLINE--%>
    <c:if test="${not cms.isOnlineProject}">
        <cms:headincludes type="javascript"
                          defaults="%(link.weak:/system/modules/com.jgregorio.opencms.fileupload/resources/js/jquery-3.2.1.js:0dd179ae-6f9d-11e7-9758-f53d2dda7236)
            |%(link.weak:/system/modules/com.jgregorio.opencms.fileupload/resources/bootstrap-3.3.7/js/bootstrap.js:0c9ddbaa-6f9d-11e7-9758-f53d2dda7236)"/>
    </c:if>

    <%--JS ONLINE--%>
    <c:if test="${cms.isOnlineProject}">
        <script src="https://code.jquery.com/jquery-3.2.1.min.js" integrity="sha256-hwg4gsxgFZhOsEEamdOYGBf13FyQuiTwlAQgxVSNgt4=" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
    </c:if>

</head>
<body>
<div class="page-wrap wrapper">
    <cms:bundle basename="com.jgregorio.opencms.fileupload.messages">
        <cms:container name="page-complete" type="page" width="1200" maxElements="15" editableby="ROLE.DEVELOPER">
            <div>
                <h2><fmt:message key="fileupload.emptycontainer.title"/></h2>
                <p><fmt:message key="fileupload.emptycontainer.text"/></p>
            </div>
        </cms:container>
    </cms:bundle>
</div><!--/page-wrap-->
</body>
</html>