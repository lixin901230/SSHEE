/**
 * 初始化函数
 */
$(function(){
	
	initJqGrid("#jqGrid_demo", "#jqGrid_pager");
	searchConditionQuery();
});

/**
 *	jqGrid 条件查询
 */
function searchConditionQuery(){
	
	$("#main_div").on("click", "#searchBut", function(){
		var searchDate = [];
		var userName = $("#userName").val();
		var telphone = $("#telephone").val();
		if(userName == null || $.trim(userName) == "" || userName == "undefined" || userName == "请输入用户名...") {
			userName = "";
		}
		if(telphone == null || $.trim(telphone) == "" || telphone == "undefined" || telphone == "请输入电话...") {
			telphone = "";
		}
		//alert(userName)
		$("#jqGrid_demo").jqGrid('setGridParam', {             
			url: basePath + '/sysman/userAction!loadUserlistChildPage.action',             
			postData:{'userVo.userName': userName,'userVo.telphone': telphone}, //发送数据            
			page:1         
		}).trigger("reloadGrid");//重新载入
	});
}

/**
 * 初始化jqGrid表格
 * 		可抽取配置点：url、colNames、colModel、gridComplete 等配置和回调函数可抽出独立出去，让该初始化方法成功公共插件方法
 * @param jqGridTableSelector 页面中table的ID属性值
 */
function initJqGrid(jqGridTableSelector, jqGridPagerSelector){
	
	$(jqGridTableSelector).jqGrid({
	   	url: basePath + '/sysman/userAction!loadUserlistChildPage.action',
	   	mtype: "POST",
		datatype: "json",
	   	colNames: ['ID', '姓名', '性别', '电话','Email', '创建日期', '状态', '操作'],
	   	colModel: [
   			{name: 'id', width:50, align:"center"},
   			{name: 'userName',  width:100, align:"center"},
   			{name: 'sex', width:100, align:"center"},
   			{name: 'telphone', width:100, align:"center"},
   			{name: 'email', width:100, align:"center"},
   			{name: 'createTime', width:150, align:"center", formatter: "date", formatoptions:{srcformat:'u',newformat:'Y-m-d H:i:s'}},
   			{name: 'statu', width:60, align:"center", formatter: userStatusFormatter},
   			{name: '操作', width:180, align:"center", formatter: operateType, cellattr: addCellAttr}
   		],
	   	prmNames: {page: "pager.curPage", rows: "pager.pageSize"},
	   	jsonReader: {					//解析获取后台返回的json参数
	   		root: "data",
	   		cell: "",
			page: "curPage",
			total: "totalPage",
			records: "totalRow",
			repeatitems: false			//该属性设置可以不必严格按照后台返回的数据顺序读取
	   	},
	   	gridComplete: function(){		//表格加载完毕之后，即可进行表格内事件初始化
	   		onGridComplete();
	   	},
	   	rowNum:10,
	   	rowList:[10,20,30],
	   	pager: jqGridPagerSelector,
	   	sortname: 'id',
	    viewrecords: true,
	    sortorder: "desc",
	    rownumbers: true,			//显示行号
	    rownumWidth: 20,			//设置行号列宽度
	    //width:580,
	    //autowidth: true,
	    altRows: true,				//行交替变色
	    height: 260,				//表格高度
	    sortname: "createTime",		//指定默认排序的列，这个地儿最好是设置索引字段为默认值，避免文件排序字段，提高性能
	    sortorder: "asc",			//指定默认排序方式
	    shrinkToFit: false,			//ture，则按比例初始化列宽度。如果为false，则列宽度使用colModel指定的宽度
	    multiselect: true,			//显示checkbox
	    multiboxonly:true			//只选中一个checkbox，单选效果
	    ,caption:"逗比们，这是一个 Hello jqGrid 示例"
	}).jqGrid('navGrid','#jqGrid_pager', {	//设置分页栏中的属性；参考/resource/plugin/jquery.jqGrid-4.5.2/js/jquery.jqGrid.src.js的8790行默认设置
		edit:true, add: true, del: true, search: true, refresh: true, closeOnEscape: true
	});
}

/**
 * jqgrid加载初始化完成后，处理表格中的附属内容
 */
function onGridComplete() {
	initOperateEvent();
	setCss();
}

/**
 * @param cellVal	当前cell的值
 * @param opt		未知
 * @param rowData	当前行的数据，可以通过rowData.属性 获取某个单元格的值
 * @returns {String}
 */
function userStatusFormatter(cellVal, opt, rowData){
	
	//alert(cellVal+"====="+obj+"====="+rowData.userName);
	//状态，0：未激活；1：已激活；2：挂起；3：禁用；4：过期
	if(cellVal == "0") {
		return "<span style='color: yello;'>未激活</span>";
	} else if(cellVal == "1"){
		return "<span style='color: green;'>已激活</span>";
	} else if(cellVal == "2"){
		return "已挂起";
	} else if(cellVal == "3"){
		return "<span style='color: red;'>已禁用</span>";
	} else if(cellVal == "4"){
		return "已过期";
	} else {
		return "数据有误";
	}
}


/**
 * 初始化操作栏
 * @param cellVal	当前单元格的值
 * @param opt		
 * @param rowData	当前行的数据对象
 * @returns {String}
 */
function operateType(cellVal, opt, rowData){
	
	var userId = rowData.id;
	var operteLink = "";
		operteLink += "<a href='javascript:void(0);' id='user_id_"+userId+"' name='operateLink'>详情</a>";
		//屏蔽掉系统级用户，避免误操作导致系统出现脏数据
		if($.trim(rowData.userName) != 'initAdmin' && $.trim(rowData.userName) != 'admin' && $.trim(rowData.userName) != 'lx'){
			operteLink += " | <a href='javascript:void(0);' id='user_id_"+userId+"' name='operateLink'>添加</a>";
			operteLink += " | <a href='javascript:void(0);' id='user_id_"+userId+"' name='operateLink'>编辑</a>";
			operteLink += " | <a href='javascript:void(0);' id='user_id_"+userId+"' name='operateLink'>删除</a>";
		}
	return operteLink;
}

/**
 * 设置连接的颜色样式
 */
function setCss(){
	$("#jqGrid_demo").find("a[name='operateLink']").css("color", "blue");
}

/**
 * 初始化表格操作栏中的点击事件
 */
function initOperateEvent(){
	$("#jqGrid_demo").on("click", "a[name='operateLink']", function(){
		var $this = $(this);
		var idVal = $this.prop("id");
		var userId = "";
		if(idVal) {
			userId = idVal.substring("user_id_".length);
		}
		//得到userId后即可根据该ID去删、改、查看用户信息
		alert("当前行的用户ID："+userId);
	});
}

/**
 * 单元格添加属性
 */
function addCellAttr(rowId, val, rawObject, cm, rdata){
	return "style='color:blue'";
}
