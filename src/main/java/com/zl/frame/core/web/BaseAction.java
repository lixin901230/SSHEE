package com.zl.frame.core.web;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.struts2.ServletActionContext;
import org.codehaus.jackson.map.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

/**
 * @desc：底层Action封装
 * @author lixin
 * @date: 2013-11-19上午9:17:12
 */
@SuppressWarnings("deprecation")
public abstract class BaseAction extends ActionSupport {

	private static final long serialVersionUID = 5821390358465222028L;
	
	private String path = getClass().getProtectionDomain().getCodeSource().getLocation().getPath();
	protected Logger logger = LoggerFactory.getLogger(path);

	private static final String CONTENTTYPE_TEXT = "text/plain";
	private static final String CONTENTTYPE_XML = "text/xml";
	private static final String CONTENTTYPE_HTML = "text/html";
	private static final String CONTENTTYPE_JSON = "application/json";
	
	private static String DATE_FORMAT_TXT = "yyyy-MM-dd HH:mm:ss";
	private static String dateFormat;
	
	private static ObjectMapper mapper = new ObjectMapper();
	static {
    	//jackson默认写出的时间数据为时间戳， 这里修改为相应模式的时间数据输出格式，解决jqgrid日期显示格式化问题
    	mapper.getSerializationConfig().setDateFormat(new SimpleDateFormat(getDateFormat()));
    }
	
	public static HttpServletRequest getRequest(){
		//HttpServletRequest request = (HttpServletRequest) ActionContext.getContext().get(ServletActionContext.HTTP_REQUEST);
		//HttpServletRequest request = (HttpServletRequest)ActionContext.getContext().get(StrutsStatics.HTTP_REQUEST);
		return ServletActionContext.getRequest();
	}
	
	public static HttpServletResponse getResponse(){
		//HttpServletResponse response =(HttpServletResponse) ActionContext.getContext().get(ServletActionContext.HTTP_RESPONSE);
		//HttpServletResponse response = (HttpServletResponse)ActionContext.getContext().get(StrutsStatics.HTTP_RESPONSE);
		return ServletActionContext.getResponse();
	}
	
	public static HttpSession getSession(){
		return getRequest().getSession();
	}
	
	public static ServletContext getServletContext(){
		//ServletContext application = (ServletContext) ActionContext.getContext().get(ServletActionContext.SERVLET_CONTEXT);
		return ServletActionContext.getServletContext();
	}
	
	public static void setValueStack(String valueStackKey, Object value){
		ActionContext actionContext = ActionContext.getContext();
		actionContext.getValueStack().set("jsonRoleList", value);//将值传递到页面上去
	}
	
	public String getRealyPath(String path){   
		return getServletContext().getRealPath(path);   
	} 
	
	public void writeText(String str){
		print(str,CONTENTTYPE_TEXT);
	}
	
	public void writeHtml(String str){
		print(str,CONTENTTYPE_HTML);
	}
	
	public void writeXml(String str){
		print(str,CONTENTTYPE_XML);
	}
	
	public void writeJson(String str){
		print(str,CONTENTTYPE_JSON);
	}
	
	public void writeJson(Object o){
		try {
			 initResponseHeader(CONTENTTYPE_JSON,null);
		     mapper.writeValue(ServletActionContext.getResponse().getWriter(), o);
	    } catch (IOException e) {
	
	    	throw new IllegalArgumentException(e);
	    }
	}
	
	private void print(String str,String contentType) {
		HttpServletResponse response = null;
		PrintWriter writer = null;
		try {
			response = ServletActionContext.getResponse();
			response.setContentType(contentType+";charset=UTF-8");
			writer = response.getWriter();
			writer.write(str);
			writer.flush();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (writer != null)
					writer.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
	
	private static HttpServletResponse initResponseHeader(String contentType, String[] headers) {
	    String encoding = "UTF-8";
//	    boolean noCache = true;
	    HttpServletResponse response = ServletActionContext.getResponse();

	    String fullContentType = contentType + ";charset=" + encoding;
	    response.setContentType(fullContentType);

	    return response;
	}

	public static String getDateFormat() {
		if(StringUtils.isEmpty(dateFormat)) {
			dateFormat = DATE_FORMAT_TXT;
		}
		return dateFormat;
	}
	public void setDateFormat(String dateFormat) {
		BaseAction.dateFormat = dateFormat;
	}
}
