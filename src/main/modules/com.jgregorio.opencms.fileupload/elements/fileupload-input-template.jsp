<%@ page import="org.apache.commons.lang3.StringUtils" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %>

<%!
    private static final String
        data_id="id",
        data_class="class",
        data_name="name",
        data_upload_servlet="uploadServlet",
        data_container_id="containerId",
        data_show_preview="showPreview",
        data_show_remove="showRemove",
        data_is_drag_and_drop="isDragAndDrop",
        data_caption_placeholder="captionPlaceholder",
        data_browse_label="browseLabel",
        data_max_size="maxSize",
        data_info_max_size="infoMaxSize",
        data_error_max_size="errorMaxSize",
        data_format="format",
        data_info_format="infoFormat",
        data_error_format="errorFormat",
        data_btn_cancel_title="btnCancelTitle",
        data_btn_cancel_text="btnCancelText",
        data_btn_upload_title="btnUploadTitle",
        data_btn_upload_text="btnUploadText",
        data_btn_select_title="btnSelectTitle",
        data_btn_select_text="btnSelectText";

    /**
     * Return data value or empty string
     * @param req
     * @param data
     * @return
     */
    String getData(HttpServletRequest req, String data) {
        String dataStr = req.getParameter(data);
        if (StringUtils.isBlank(data)) {
            dataStr = "";
        }
        return dataStr;
    }
%>
<c:set var="uploadServlet"><%=getData(request, data_upload_servlet)%></c:set>
<c:if test="${not empty uploadServlet}">
    <div class="input-group" id="container-file">
        <%--ADDON--%>
        <span class="input-group-addon">
            <i class="fa fa-upload" aria-hidden="true"></i>
        </span>

        <%--CAPTION--%>
        <div id="dropbox" tabindex="-1" class="form-control file-caption">
            <span class="file-caption-ellipsis"><%=getData(request, data_caption_placeholder)%></span>
                <!--TODO UPDATE FILE NAME WHEN SELECTED-->
            <div id="file-caption-name" class="file-caption-name"></div>
        </div>

        <%--BUTTONS--%>
        <div class="input-group-btn">

            <%--CANCEL--%>
            <button type="button" title="<%=getData(request, data_btn_cancel_title)%>"
                    class="hide btn btn-default btn-fileinput-cancel">
                <i class="fa fa-ban"></i>&nbsp;<%=getData(request, data_btn_cancel_text)%>
            </button>
f
            <%--UPLOAD--%>
            <button type="button"
                    title="<%=getData(request, data_btn_upload_title)%>"
                    class="hide btn btn-default btn-fileinput-upload">
                <i class="fa fa-upload"></i>&nbsp;<%=getData(request, data_btn_upload_text)%>
            </button>

            <%--SELECT--%>
            <button type="button"
                    id="<%=data_id%>-select"
                    class="btn btn-primary btn-file btn-fileinput-select"
                    title="<%=getData(request, data_btn_select_title)%>">
                <i class="fa fa-folder-open-o"></i>&nbsp;<%=getData(request, data_btn_select_text)%>
            </button>

            <%--INPUT--%>
            <input
                    type="file"
                    id="<%=data_id%>"
                    name="<%=data_name%>"
                    class="hidden <%=data_class%>"
                    data-upload-servlet="<%=data_upload_servlet%>"
                    data-container-id="<%=data_container_id%>"
                    data-show-preview="<%=data_show_preview%>"
                    data-show-remove="<%=data_show_remove%>"
                    data-is-drag-and-drop="<%=data_is_drag_and_drop%>"
                    data-caption-placeholder="<%=data_caption_placeholder%>"
                    data-browse-label="<%=data_browse_label%>"
                    data-max-size="<%=data_max_size%>"
                    data-info-max-size="<%=data_info_max_size%>"
                    data-error-max-size="<%=data_error_max_size%>"
                    data-format="<%=data_format%>"
                    data-info-format="<%=data_info_format%>"
                    data-error-format="<%=data_error_format%>"
                    data-btn-cancel-title="<%=data_btn_cancel_title%>"
                    data-btn-cancel-text="<%=data_btn_cancel_text%>"
                    data-btn-upload-title="<%=data_btn_upload_title%>"
                    data-btn-upload-text="<%=data_btn_upload_text%>"
                    data-btn-select-text="<%=data_btn_select_text%>"
            >
        </div>
    </div>

    <%--PROGRESS BAR--%>
    <div id="status" class="hide status"></div>

    <%--ERROR--%>
    <div id="upload-error" class="file-error-message" style="display: none;"></div>

    <%--REQUIREMENTS--%>
    <div class="check-list">
        <li><%=getData(request, data_info_max_size)%></li>
        <li><%=getData(request, data_info_format)%></li>
    </div>

    <%--TODO CALL UPLOAD FILE JS--%>
</c:if>