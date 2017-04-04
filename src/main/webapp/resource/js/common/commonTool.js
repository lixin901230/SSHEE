var g_ctx = document.getElementById('ctx').value;

/**
 * 判断传入字符是否为空
 * 		true: 不为空；false: 为空
 * @param str
 * @returns {Boolean}
 */
function isNotEmpty(str){
	
	var isEmpty = false;
	if(str != null && str != "" && str != 'undefined'){
		isEmpty = true;
	}
	return isEmpty;
}