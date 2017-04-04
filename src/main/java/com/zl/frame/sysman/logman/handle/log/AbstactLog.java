package com.zl.frame.sysman.logman.handle.log;

import java.util.Calendar;
import java.util.Date;


/**
 * @desc：抽象日志接口
 * @author lixin
 * @date: 2014-3-6下午4:49:14
 */
public abstract class AbstactLog implements Log,Comparable<AbstactLog>{

	private static final long serialVersionUID = 8010804228283049975L;
	
	protected Date generateTime = Calendar.getInstance().getTime();
	
	public int compareTo(AbstactLog o) {
		
		if(o == null){
			return -1;
		}
		
		if(o.generateTime.getTime() > this.getGenerateTime().getTime()){
			return 1;
		}
		
		return 0;
	}
	
	public Date getGenerateTime() {
		return generateTime;
	}
	public void setGenerateTime(Date generateTime) {
		this.generateTime = generateTime;
	}
}
