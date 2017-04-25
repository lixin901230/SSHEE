package com.zl.frame.core.security.tag;

import java.io.IOException;
import java.util.List;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.Tag;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.zl.frame.core.security.cache.UserRightCache;
import com.zl.frame.core.security.util.SecurityUtial;

/**
 * @desc：自定义JSP权限检查标签 
 * <li>根据权限ID（nodeCode）从权限Map缓存中匹配权限，匹配上了则显示标签中的内容，否则不显示标签中的内容
 * ，（权限Map缓存在MySecurityMetadataSource中查询并设置到权限Map缓存对象中）</li>
 * @author lixin
 * @date: 2014-1-12下午4:54:13
 */
public class SecurityRightCheckTag extends TagSupport {

	private static final long serialVersionUID = -890287688533970311L;

	private static Logger logger = LoggerFactory.getLogger(SecurityRightCheckTag.class);
	
	private static final int INCLUDE = 1;//Tag.EVAL_BODY_INCLUDE;	// 返回1：WEB容器会执行自定义标签的标签体（会渲染标签体内的元素）
	private static final int SKIP = 0;//Tag.SKIP_BODY;	// 返回0：WEB容器会忽略自定义标签的标签体，直接解释执行自定义标签的结束标记（不渲染标签体内的元素）
	private String rightId;
	private String showContent;

	public int doStartTag() throws JspException {
		
		if(StringUtils.isEmpty(rightId)){
			return SKIP;
		}
		
		String userName = SecurityUtial.getCurrentUserName();
		logger.info("当前用户:" + userName);
		
		if ((userName == null) || (userName.trim().length() == 0)) {
			return SKIP;
		}

		logger.info("从用户权限缓存对象中获取当前用户的权限信息");
		List<String> currentUserRights = UserRightCache.getUserRight(userName);
		
		logger.info("自定义spring security 页面url鉴权标签检查当前用户是否拥有该标签范围内的的访问权限["+rightId+"]");
		if(currentUserRights != null && currentUserRights.size() > 0){
			//如果当前用户权限中包含自定义权限标签中配置的权限ID，则说明该用户能访问该权限标签限制的内容
			//如果当前用户权限中包含自定义权限标签中配置的权限ID，则说明该用户能访问该权限标签限制的内容
			if(currentUserRights.contains(rightId)){	
				return INCLUDE;
			}
		}
		
		if ((this.showContent != null) && (this.showContent.trim().length() > 0)) {
			
			JspWriter out = this.pageContext.getOut();
			try {
				out.print(this.showContent);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return SKIP;
	}

	public String getRightId() {
		return this.rightId;
	}
	public void setRightId(String rightId) {
		this.rightId = rightId;
	}

	public String getShowContent() {
		return this.showContent;
	}
	public void setShowContent(String showContent) {
		this.showContent = showContent;
	}
}
