package com.zl.frame.core.util;

import java.io.IOException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;

import org.codehaus.jackson.JsonGenerator;
import org.codehaus.jackson.JsonProcessingException;
import org.codehaus.jackson.map.JsonSerializer;
import org.codehaus.jackson.map.SerializerProvider;

/**
 * @desc：对象转json时，日期属性格式化类
 * @author lixin
 * @date: 2013-12-8下午11:30:12
 */
public class JsonDateSerializer extends JsonSerializer<Timestamp> {

	private static final SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");

	@Override
	public void serialize(Timestamp arg0, JsonGenerator arg1, SerializerProvider arg2)
			throws IOException, JsonProcessingException {
		
		String formattedDate = dateFormat.format(arg0);
		arg1.writeString(formattedDate);
	}

}
