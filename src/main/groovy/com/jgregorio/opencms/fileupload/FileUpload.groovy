package com.jgregorio.opencms.fileupload

import org.opencms.file.CmsObject
import org.opencms.i18n.CmsMessages
import org.opencms.jsp.CmsJspActionElement

import javax.servlet.http.HttpServletRequest
import javax.servlet.http.HttpServletResponse
import javax.servlet.jsp.PageContext

/**
 * Created by jesus on 22/07/2017.
 */
class FileUpload extends CmsJspActionElement {

    public static final String BUNDLE = "com.jgregorio.opencms.fileupload"
    private CmsObject cmso;
    private Locale locale;
    private CmsMessages messages;

    FileUpload(PageContext context, HttpServletRequest req, HttpServletResponse res) {
        super(context, req, res)

        this.cmso = getCmsObject();
        this.locale = getCmsObject().getRequestContext().getLocale();
        this.messages = getMessages(BUNDLE,
                getCmsObject().getRequestContext().getLocale());
    }

    public void handle() {
        getRequest().getPart("file")

    }
}
