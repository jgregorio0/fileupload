<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>

<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %>

<script>
    var uploadServlet = '<cms:link>/system/modules/com.jgregorio.opencms.fileupload/elements/v1/upload/</cms:link>';

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
<div>
    <div id="dropbox">Drag and drop a file here...</div>
    <div id="status"></div>
</div>