<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %>

<script>
    var uploadServlet = '<cms:link>/system/modules/com.jgregorio.opencms.fileupload/elements/fileupload-controller.jsp</cms:link>';

    window.onload = function () {
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
<style>
    #dropbox {
        width: 300px;
        height: 200px;
        border: 1px solid gray;
        border-radius: 5px;
        padding: 5px;
        color: gray;
    }
</style>

<%--CHOOSE FILE--%>
<cms:bundle basename="com.jgregorio.opencms.fileupload.messages">
    <c:set var="uploadUrl"><cms:link>/system/modules/com.jgregorio.opencms.fileupload/elements/v1/upload</cms:link></c:set>

    <%--FORM--%>
    <div id="form-upload" class="form-upload">
        <p><fmt:message key="fileupload.form.text"/></p>

            <%--FILE UPLOADED BOX--%>
        <span class="file-input file-input-ajax-new">

            <%--PREVIEW--%>
            <div class="file-preview">
                <div class="close fileinput-remove">×</div>

                    <%--DRAG AND DROP--%>
                <div class="file-drop-zone">
                    <div class="file-drop-zone-title"><fmt:message key="fileupload.form.drag.and.drop"/></div>
                    <div class="file-preview-thumbnails"></div>
                    <div class="clearfix"></div>
                    <div class="file-preview-status text-center text-success"></div>
                    <div class="kv-fileinput-error"></div>
                </div>
            </div>

            <%--PROGRESS BAR--%>
            <div class="kv-upload-progress hide"></div>

            <%--BUTTONS--%>
            <div class="input-group">

                    <%--FILENAME--%>
                <div tabindex="-1" class="form-control file-caption  kv-fileinput-caption">
                    <span class="file-caption-ellipsis">…</span>
                    <div class="file-caption-name"></div>
                </div>

                <div class="input-group-btn">

                        <%--CANCEL--%>
                    <button type="button" title="Abort ongoing upload"
                            class="hide btn btn-default fileinput-cancel fileinput-cancel-button">
                        <i class="glyphicon glyphicon-ban-circle"></i> Cancel
                    </button>

                        <%--UPLOAD--%>
                    <a href="https://api.latostadora.com/v1/uploadDesign?token=K9Heg92bi3c26aOx04yKkzLo01mc4n5X"
                       title="Upload selected files"
                       class="btn btn-default kv-fileinput-upload fileinput-upload-button"><i
                            class="glyphicon glyphicon-upload"></i> Subir imagen</a>

                        <%--SELECT--%>
                    <div class="btn btn-primary btn-file"><i class="glyphicon glyphicon-folder-open"></i> &nbsp;Seleccionar
                        <input
                                type="file"
                                class="fileupload"
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
                    </div>
                </div>
            </div>
        </span>

            <%--ERROR--%>
        <div id="upload-error" class="file-error-message" style="display: none;"></div>

            <%--REQUIREMENTS--%>
        <div class="check-list">
            <li>Archivos PNG y JPG. Max. 20MB.</li>
            <li>Resolución mínima 120 píxeles/pulgada</li>
        </div>
    </div>
</cms:bundle>