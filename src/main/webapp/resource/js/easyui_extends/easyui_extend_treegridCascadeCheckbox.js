/**
 * 扩展树表格级联选择（点击checkbox才生效）：
 * 		自定义属性：
 * 		threeLinkCheck  :  三级联动(父节点和子节点都被选中)
 * 		cascadeCheck    :  普通级联(不包括未加载的子节点),针对子节点。(这种个人认为主要区别应该在异步加载，如果非异步加载，看不出区别)
 * 		deepCascadeCheck:  深度级联(包括未加载的子节点),针对子节点
 */
$.extend($.fn.treegrid.defaults, {
	onLoadSuccess : function() {
		var target = $(this);
		var opts = $.data(this, "treegrid").options;
		var panel = $(this).datagrid("getPanel");
		var gridBody = panel.find("div.datagrid-body");
		var idField = opts.idField;//这里的idField其实就是API里方法的id参数
		gridBody.find("div.datagrid-cell-check input[type=checkbox]").click(function(e){
			//if(opts.singleSelect) return;//单选不管
			if(opts.cascadeCheck || opts.deepCascadeCheck || opts.threeLinkCheck){
				var id = $(this).parent().parent().parent().attr("node-id");
				var status = false;
				if($(this).attr("checked")) status = true;
				
				if(opts.threeLinkCheck){
					//三级联动,是否深度级联还需要设置deepCascadeCheck的值
					selectParent(target, id, idField, status);
					selectChildren(target, id, idField, opts.deepCascadeCheck, status);
				}else{
					//只设置cascadeCheck或者deepCascadeCheck
					if(opts.cascadeCheck || opts.deepCascadeCheck){
						//普通级联
						selectChildren(target, id, idField, opts.deepCascadeCheck, status);
					}
				}
				/**
				 * 级联选择父节点
				 * @param {Object} target
				 * @param {Object} id 节点ID
				 * @param {Object} status 节点状态，true:勾选，false:未勾选
				 * @return {TypeName} 
				 */
				function selectParent(target, id, idField, status){
					var parent = target.treegrid('getParent', id);
					if(parent){
						var parentId = parent[idField];
						if(status)
							$("input[type=checkbox][value='"+parentId+"']").attr("checked", true); 
						else
							$("input[type=checkbox][value='"+parentId+"']").attr("checked", false);
						selectParent(target, parentId, idField, status);
					}
				}
				/**
				 * 级联选择子节点
				 * @param {Object} target
				 * @param {Object} id 节点ID
				 * @param {Object} deepCascade 是否深度级联
				 * @param {Object} status 节点状态，true:勾选，false:未勾选
				 * @return {TypeName} 
				 */
				function selectChildren(target, id, idField, deepCascade, status){
					//深度级联时先展开节点
					if(status && deepCascade){
						target.treegrid('expand', id);
					}
						
					//根据ID获取所有孩子节点
					var children = target.treegrid('getChildren', id);
					for(var i=0; i<children.length; i++){
						var childId = children[i][idField];//可以根据key取到任意值
						if(status){
							$("input[type=checkbox][value='"+childId+"']").attr("checked", true); 
						}else{
							$("input[type=checkbox][value='"+childId+"']").attr("checked", false); 
						}
					}
				}
			}
			e.stopPropagation();//停止事件传播
		});
	}
});