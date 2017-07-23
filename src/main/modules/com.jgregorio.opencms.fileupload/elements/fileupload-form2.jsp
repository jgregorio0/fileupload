<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %>
<%!
    /**
     * REFERENCIAS
     * http://www.matlus.com/html5-file-upload-with-progress/
     * https://stackoverflow.com/questions/2422468/how-to-upload-files-to-server-using-jsp-servlet/2424824#2424824
     */

    private static final String MODULE_PATH = "/system/modules/com.jgregorio.opencms.fileupload";
    private static final String UPLOAD_SERVLET_PATH = "/elements/v1/upload/";
    private static final String INPUT_TEMPLATE_PATH = "/elements/fileupload-input-template.jsp";
%>

<%--HTML FORM FILEUPLOAD--%>
<fmt:setLocale value="${cms.locale}"/>
<cms:bundle basename="com.jgregorio.opencms.fileupload.messages">
    <div>
            <%--ATTRIBUTES--%>
        <c:set var="uploadServlet"><cms:link><%=MODULE_PATH%><%=UPLOAD_SERVLET_PATH%></cms:link></c:set>
        <c:set var="inputTemplate"><cms:link><%=MODULE_PATH%><%=INPUT_TEMPLATE_PATH%></cms:link></c:set>

            <%--JS FILEUPLOAD--%>
        <script>
            var uploadServlet = '${uploadServlet}';

            $(function(){
                // format inputs type file identified by class "uploadfile"
                formatUploadFileInputs();
            });

            function formatUploadFileInputs(){
                var inputs = $('.uploadfile');
                for (var i = 0; i < inputs.length; i++){
                    var input = $(inputs.get(i));
                    formatUploadFileInput(input);
                }
            }

            function formatUploadFileInput(input){
                // Add id
                var ctxt = {
                    id: input.attr('id'),
                    class: input.attr('class'),
                    name: input.attr('name')
                };

                // Add data
                var inputData = input.data();
                for(var i in inputData){
                    ctxt[i] = inputData[i];
                }

                // Get input html template
                $.get('${inputTemplate}', ctxt)
                    .done(function(data) {
                        updateUploadFileInput(ctxt, data);
                    })
                    .fail(function(err) {
                        console.error("ERROR loading input template", err);
                    });
            }

            function updateUploadFileInput(ctxt, data) {
                if (data && data.length) {
                    // Append content data
                    $('#' + ctxt.containerId).empty().append(data);

                    // Onlick event
                    $('#' + ctxt.id + '-select').click(function () {
                       $('#' + ctxt.id).click();
                    });


                    if (ctxt.isDragAndDrop) {
                        dragAndDropZone();
                    }
                }
            }

            function dragAndDropZone () {
//                TODO mark as dropbox class
                var dropbox = document.getElementById("dropbox");
                dropbox.addEventListener("dragenter", noop, false);
                dropbox.addEventListener("dragexit", noop, false);
                dropbox.addEventListener("dragover", noop, false);
                dropbox.addEventListener("drop", dropUpload, false);
            }

            function noop(event) {
                event.stopPropagation();
                event.preventDefault();
            }

            function dropUpload(event) {
                noop(event);
                var files = event.dataTransfer.files;

                for (var i = 0; i < files.length; i++) {
                    upload(files[i]);
                }
            }

            function upload(file) {
                document.getElementById("status").innerHTML = "Uploading " + file.name;

                var formData = new FormData();
                formData.append("file", file);

                var xhr = new XMLHttpRequest();
                xhr.upload.addEventListener("progress", uploadProgress, false);
                xhr.addEventListener("load", uploadComplete, false);
                xhr.open("POST", uploadServlet, true); // If async=false, then you'll miss progress bar support.
                xhr.send(formData);
            }

            function uploadProgress(event) {
                // Note: doesn't work with async=false.
                var progress = Math.round(event.loaded / event.total * 100);
                document.getElementById("status").innerHTML = "Progress " + progress + "%";
            }

            function uploadComplete(event) {
                document.getElementById("status").innerHTML = event.target.responseText;
            }
        </script>

            <%--STYLES--%>
            <%--<style>
                #dropbox {
                    width: 300px;
                    height: 200px;
                    border: 1px solid gray;
                    border-radius: 5px;
                    padding: 5px;
                    color: gray;
                }
            </style>--%>
            <%--<div id="dropbox">Drag and drop a file here...</div>--%>
            <%--<div id="status"></div>--%>

            <%--FILEUPLOAD FORM--%>
        <form id="fileupload-form" class="row fileupload-form" method="post" enctype="multipart/form-data">
            <div class="form-group" id="container-file">
                <label for="uploadfile" class="col-sm-2 control-label">
                    <fmt:message key="fileupload.form.file.label"/>
                </label>
                <div class="col-sm-10">
                    <div class="input-group">
                        <input type="file" <%-- TODO class="form-control"--%> name="uploadfile" id="uploadfile" class="uploadfile"
                               data-upload-servlet="${uploadServlet}"
                               data-container-id="container-file"
                               data-show-preview="true"
                               data-show-remove="true"
                               data-is-drag-and-drop="true"
                               data-caption-placeholder="<fmt:message key='fileupload.form.file.caption.placeholder'/>"
                               data-browse-label="<fmt:message key='fileupload.form.file.browse.label'/>"
                               data-max-size="<fmt:message key='fileupload.form.file.max.size'/>"
                               data-info-max-size="<fmt:message key='info.fileupload.form.file.max.size'/>"
                               data-error-max-size="<fmt:message key='error.fileupload.form.file.max.size'/>"
                               data-format="<fmt:message key='fileupload.form.file.format'/>"
                               data-info-format="<fmt:message key='info.fileupload.form.file.format'/>"
                               data-error-format="<fmt:message key='error.fileupload.form.file.format'/>"
                               data-btn-cancel-title="<fmt:message key="fileupload.form.btn.cancel.title"/>"
                               data-btn-cancel-text="<fmt:message key="fileupload.form.btn.cancel.text"/>"
                               data-btn-upload-title="<fmt:message key="fileupload.form.btn.upload.title"/>"
                               data-btn-upload-text="<fmt:message key="fileupload.form.btn.upload.text"/>"
                               data-btn-select-title="<fmt:message key="fileupload.form.btn.select.title"/>"
                               data-btn-select-text="<fmt:message key="fileupload.form.btn.select.text"/>"
                        >
                    </div>
                </div>
            </div>

            <h2>EJEMPLO</h2>
            <div class="input-group">
                <div tabindex="-1" class="form-control file-caption">
                    <span class="file-caption-ellipsis"><fmt:message
                            key="fileupload.form.file.caption.placeholder"/></span>
                        <%--TODO UPDATE FILE NAME WHEN SELECTED--%>
                    <div id="file-caption-name" class="file-caption-name"></div>
                </div>
                <div class="input-group-btn">

                        <%--CANCEL--%>
                    <button type="button" title="<fmt:message key="fileupload.form.btn.cancel.title"/>"
                            class="hide btn btn-default btn-fileinput-cancel">
                        <i class="glyphicon glyphicon-ban-circle"></i>&nbsp;<fmt:message
                            key="fileupload.form.btn.cancel.text"/>
                    </button>

                        <%--UPLOAD--%>
                    <a href="https://api.latostadora.com/v1/uploadDesign?token=K9Heg92bi3c26aOx04yKkzLo01mc4n5X"
                       title="Upload selected files"
                       class="hide btn btn-default btn-fileinput-upload">
                        <i class="glyphicon glyphicon-upload"></i> Subir imagen
                        <input
                                type="file"
                                class="ejemplo"
                                data-upload-url="./v1/upload"
                                data-show-preview="true"
                                data-show-remove="false"
                                data-upload-label="Subir imagen"
                                data-browse-label="Seleccionar"
                                data-msg-size-too-large="El fichero supera el límite máximo permitido de 20MB"
                                data-msg-invalid-file-extension="Fichero no válido. Sólo se permiten ficheros JPG o PNG"
                                data-max-file-size="20480"
                                data-msg-validation-error="Archivo no válido"
                                name="fileupload"
                                id="fileupload">
                    </a>

                        <%--SELECT--%>
                    <div class="btn btn-primary btn-file">
                        <i class="glyphicon glyphicon-folder-open"></i> &nbsp;Seleccionar
                    </div>
                </div>
            </div>
                <%--ERROR--%>
            <div id="upload-error" class="file-error-message" style="display: none;"></div>

                <%--REQUIREMENTS--%>
            <div class="check-list">
                <li>Archivos PNG y JPG. Max. 20MB.</li>
            </div>
        </form>
    </div>
</cms:bundle>