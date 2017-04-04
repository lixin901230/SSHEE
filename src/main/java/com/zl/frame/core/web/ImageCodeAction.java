package com.zl.frame.core.web;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.util.Random;

import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * 图片验证码Action
 */
public class ImageCodeAction extends BaseAction {
	
	private static final long serialVersionUID = 3206570836473776111L;
	
	private Log log = LogFactory.getLog(ImageCodeAction.class);
	
	/**
	 * 获取码
	 * @param mapping
	 * @param form
	 * @param request
	 * @param resp
	 * @throws Exception
	 */
	public void getImageCode() throws Exception {
		
		log.info("获取验证码信息");
		
		HttpServletRequest request = getRequest();
		HttpServletResponse response = getResponse();
		
		HttpSession session = request.getSession();
		
		//产生随机的验证码
		char[] chs={'A','B','C','D','E','F','G','H','J','K','L',
		'M','N','P','Q','R','S','T','U','V','W','X','Y','Z','0',
		'1','2','3','4','5','6','7','8','9','a','b','c','d','e',
		'f','g','h','i','j','k','m','n','p','q','r','s','t','u',
		'v','w','x','y','z'};
		Random rd=new Random();
		StringBuffer code=new StringBuffer();
		for(int i=0;i<4;i++){
			code.append(chs[rd.nextInt(chs.length)]);
		}
		//将产生的验证码存放起来,以便和用户输入的进行对比
		session.setAttribute("code",code.toString());
		
		//绘图
		//定义画布
		int width=85;
		int height=30;
		//建一个画板
		BufferedImage image=new BufferedImage(width,height,BufferedImage.TYPE_INT_RGB);	
		//获取画笔,从当前画布中
		Graphics g=image.getGraphics();
		
		//填充背景色
		//为画笔上色
		g.setColor(Color.lightGray);//使用已经定义好的常量  可用颜色：lightGray，ORANGE
//		g.setColor(new Color(128,56,79));//自定义颜色,红,绿,蓝(0-255)
//		g.setColor(Color.decode("#0000ff"));//将十六进制转换为Color
		
		//填充背景
		g.fillRect(0,0,width,height);
		
		//绘制验证码
		//为画笔换色
		g.setColor(Color.decode("#800000"));
		
		//设置字体 ITALIC LAYOUT_LEFT_TO_RIGHT
		g.setFont(new Font("微软雅黑",Font.ITALIC,25));
		
		//绘制验证码
		g.drawString(code.toString(),10,22);
		//添加噪音码
//		for(int i=0;i<100;i++){
		for(int i=0;i<40;i++){
			g.fillOval(rd.nextInt(width+1),rd.nextInt(height+1),3,3 );
		}
		//添加干扰线（加了干扰线后，很难辨认，在此注释掉）
//		g.drawLine(0,rd.nextInt(height+1),width,rd.nextInt(height+1));
//		g.drawLine(rd.nextInt(width+1),0,rd.nextInt(width+1),height);
//		g.drawLine(rd.nextInt(width+1),0,rd.nextInt(width+1),height);
		//获取用于向客户端浏览器传输数据的输出流
		ServletOutputStream sos = response.getOutputStream();
		
		//将图片格式固定并产生,然后通过sos传输给客户端
		ImageIO.write(image,"JPEG",sos);
		sos.flush();
		sos.close();
	}
}
