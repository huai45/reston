<%@ page language="java" import="java.util.*,com.huai.common.domain.*,net.sf.json.JSONArray,net.sf.json.JSONObject,
org.springframework.jdbc.core.BatchPreparedStatementSetter,java.sql.*,
com.huai.common.util.*,com.mongodb.BasicDBObject,org.springframework.jdbc.core.JdbcTemplate,
javax.sql.DataSource,com.huai.common.domain.User" pageEncoding="UTF-8"%><%

String trade_type_code = request.getParameter("TRADE_TYPE_CODE") ;
if(trade_type_code==null||trade_type_code.trim().equals("")){
	System.out.println(ut.err("无效操作类型"));
	out.print(ut.err("无效操作类型"));
	return;
}
try{
	if(trade_type_code.equals("table_delete")){
		out.print(deleteTable(request));	
	}else if(trade_type_code.equals("table_add")){
		out.print(addTable(request));	
	}else if(trade_type_code.equals("table_mod")){
		out.print(modifyTable(request));	
	}else if(trade_type_code.equals("floor_add")){
		out.print(addFloor(request));	
	}else if(trade_type_code.equals("floor_mod")){
		out.print(modifyFloor(request));	
	}else if(trade_type_code.equals("floor_delete")){
		out.print(deleteFloor(request));	
	}else if(trade_type_code.equals("printer_add")){
		out.print(addPrinter(request));	
	}else if(trade_type_code.equals("printer_mod")){
		out.print(modifyPrinter(request));	
	}else if(trade_type_code.equals("printer_delete")){
		out.print(deletePrinter(request));	
	}else if(trade_type_code.equals("role_add")){
		out.print(addRole(request));	
	}else if(trade_type_code.equals("role_mod")){
		out.print(modifyRole(request));	
	}else if(trade_type_code.equals("role_delete")){
		out.print(deleteRole(request));	
	}else if(trade_type_code.equals("user_add")){
		out.print(addUser(request));	
	}else if(trade_type_code.equals("user_mod")){
		out.print(modifyUser(request));	
	}else if(trade_type_code.equals("user_delete")){
		out.print(deleteUser(request));	
	}else if(trade_type_code.equals("phone_user_add")){
		out.print(addPhoneuser(request));	
	}else if(trade_type_code.equals("phone_user_mod")){
		out.print(modifyPhoneuser(request));	
	}else if(trade_type_code.equals("phone_user_delete")){
		out.print(deletePhoneuser(request));	
	}else if(trade_type_code.equals("food_category_add")){
		out.print(addFoodcategory(request));	
	}else if(trade_type_code.equals("food_category_mod")){
		out.print(modifyFoodcategory(request));	
	}else if(trade_type_code.equals("food_category_delete")){
		out.print(deleteFoodcategory(request));	
	}else if(trade_type_code.equals("food_add")){
		out.print(addFood(request));	
	}else if(trade_type_code.equals("food_mod")){
		out.print(modifyFood(request));	
	}else if(trade_type_code.equals("food_delete")){
		out.print(deleteFood(request));	
	}else if(trade_type_code.equals("system_mod")){
		out.print(modifySystemInfo(request));	
	}else if(trade_type_code.equals("ban_mod")){
		out.print(modifyBanInfo(request));	
	}else if(trade_type_code.equals("role_right_mod")){
		out.print(setOrleRight(request));	
	}else if(trade_type_code.equals("food_package_add")){
		out.print(addFoodPackage(request));	
	}else if(trade_type_code.equals("food_package_start")){
		out.print(startFoodPackageById(request));	
	}else if(trade_type_code.equals("food_package_stop")){
		out.print(stopFoodPackageById(request));	
	}else if(trade_type_code.equals("food_package_save")){
		out.print(saveFoodPackage(request));	
	}else{
		out.print(ut.err("无效操作类型！"));
	}

}catch(Exception e){
	e.printStackTrace();
	out.print(ut.err("操作异常！"));
}
%>
<%!
public String addFloor(HttpServletRequest request){
	String id = request.getParameter("id");
	String name = request.getParameter("name");
	JdbcTemplate jdbcTemplate = getJDBC(request);
	jdbcTemplate.update("insert into td_floor (id,floor_id,name) values (?,?,?)",new Object[]{id,id,name});
    return ut.suc("添加成功");	
}
public String modifyFloor(HttpServletRequest request){
	String id = request.getParameter("id");
	String name = request.getParameter("name");
	JdbcTemplate jdbcTemplate = getJDBC(request);
	jdbcTemplate.update(" update td_floor set name = ? where id = ?  ",new Object[]{name,id});
    return ut.suc("修改成功");	
}
public String deleteFloor(HttpServletRequest request){
	String jsonStr = request.getParameter("jsonStr");
	JdbcTemplate jdbcTemplate = getJDBC(request);
	final JSONArray jsonArr = JSONArray.fromObject(jsonStr);
	jdbcTemplate.batchUpdate( " delete  from td_floor where id  = ? " , 
		new BatchPreparedStatementSetter() {
			public int getBatchSize() {
			        return jsonArr.size();
			   }
			public void setValues(PreparedStatement pstmt, int i)
					throws SQLException {
				   JSONObject item = (JSONObject)jsonArr.get(i);
			       pstmt.setString(1, item.getString("id"));    
			       //ut.log(" ****************  id = "+item.getString("id"));
			}
	});
    return ut.suc("删除成功");	
}
public String addTable(HttpServletRequest request){
	String table_id = request.getParameter("table_id");
	String table_name = request.getParameter("table_name");
	String floor_order = request.getParameter("floor_order");
	String floor = request.getParameter("floor");
	String size = request.getParameter("size");
	String limit_money = request.getParameter("limit_money");
	String printer = request.getParameter("printer");
	String queue_tag = request.getParameter("queue_tag");
	JdbcTemplate jdbcTemplate = getJDBC(request);
	jdbcTemplate.update("insert into to_table (table_id,table_name,floor_order,floor,size,limit_money,printer,queue_tag) values (?,?,?,?,?,?,?,?)",
			new Object[]{table_id,table_name,floor_order,floor,size,limit_money,printer,queue_tag});
    return ut.suc("添加成功");	
}
public String modifyTable(HttpServletRequest request){
	String table_id = request.getParameter("table_id");
	String table_name = request.getParameter("table_name");
	String floor_order = request.getParameter("floor_order");
	String floor = request.getParameter("floor");
	String size = request.getParameter("size");
	String limit_money = request.getParameter("limit_money");
	String printer = request.getParameter("printer");
	String queue_tag = request.getParameter("queue_tag");
	JdbcTemplate jdbcTemplate = getJDBC(request);
	jdbcTemplate.update(" update to_table set table_name=?,floor_order=?,floor=?,size=?,limit_money=?,printer=?,queue_tag=? where table_id = ?  ",
			new Object[]{table_name,floor_order,floor,size,limit_money,printer,queue_tag,table_id});
    return ut.suc("修改成功");	
}
public String deleteTable(HttpServletRequest request){
	String jsonStr = request.getParameter("jsonStr");
	JdbcTemplate jdbcTemplate = getJDBC(request);
	final JSONArray jsonArr = JSONArray.fromObject(jsonStr);
	jdbcTemplate.batchUpdate( " delete  from to_table where table_id  = ? " , 
		new BatchPreparedStatementSetter() {
			public int getBatchSize() {
			        return jsonArr.size();
			   }
			public void setValues(PreparedStatement pstmt, int i)
					throws SQLException {
				   JSONObject item = (JSONObject)jsonArr.get(i);
			       pstmt.setString(1, item.getString("id"));    
			       //ut.log(" ****************  id = "+item.getString("id"));
			}
	});
    return ut.suc("删除成功");	
}
public String addPrinter(HttpServletRequest request){
	String ip = request.getParameter("ip");
	String name = request.getParameter("name");
	JdbcTemplate jdbcTemplate = getJDBC(request);
	jdbcTemplate.update("insert into td_printer (name,ip) values (?,?)",new Object[]{name,ip});
    return ut.suc("添加成功");	
}
public String modifyPrinter(HttpServletRequest request){
	String ip = request.getParameter("ip");
	String name = request.getParameter("name");
	JdbcTemplate jdbcTemplate = getJDBC(request);
	jdbcTemplate.update(" update td_printer set ip = ? where name = ?  ",new Object[]{ip,name});
    return ut.suc("修改成功");	
}
public String deletePrinter(HttpServletRequest request){
	String jsonStr = request.getParameter("jsonStr");
	JdbcTemplate jdbcTemplate = getJDBC(request);
	final JSONArray jsonArr = JSONArray.fromObject(jsonStr);
	jdbcTemplate.batchUpdate( " delete  from td_printer where name  = ? " , 
		new BatchPreparedStatementSetter() {
			public int getBatchSize() {
			        return jsonArr.size();
			   }
			public void setValues(PreparedStatement pstmt, int i)
					throws SQLException {
				   JSONObject item = (JSONObject)jsonArr.get(i);
			       pstmt.setString(1, item.getString("id"));    
			       //ut.log(" ****************  id = "+item.getString("id"));
			}
	});
    return ut.suc("删除成功");
}

public String addRole(HttpServletRequest request){
	String role_id = request.getParameter("role_id");
	String rolename = request.getParameter("rolename");
	JdbcTemplate jdbcTemplate = getJDBC(request);
	jdbcTemplate.update("insert into td_role (role_id,rolename) values (?,?)",new Object[]{role_id,rolename});
    return ut.suc("添加成功");	
}
public String modifyRole(HttpServletRequest request){
	String role_id = request.getParameter("role_id");
	String rolename = request.getParameter("rolename");
	JdbcTemplate jdbcTemplate = getJDBC(request);
	jdbcTemplate.update(" update td_role set rolename = ? where role_id = ?  ",new Object[]{rolename,role_id});
    return ut.suc("修改成功");	
}
public String deleteRole(HttpServletRequest request){
	String jsonStr = request.getParameter("jsonStr");
	JdbcTemplate jdbcTemplate = getJDBC(request);
	final JSONArray jsonArr = JSONArray.fromObject(jsonStr);
	jdbcTemplate.batchUpdate( " delete  from td_role where role_id  = ? " , 
		new BatchPreparedStatementSetter() {
			public int getBatchSize() {
			        return jsonArr.size();
			   }
			public void setValues(PreparedStatement pstmt, int i)
					throws SQLException {
				   JSONObject item = (JSONObject)jsonArr.get(i);
			       pstmt.setString(1, item.getString("id"));    
			       //ut.log(" ****************  id = "+item.getString("id"));
			}
	});
    return ut.suc("删除成功");	
}

public String addPhoneuser(HttpServletRequest request){
	String user_id = request.getParameter("user_id");
	String username = request.getParameter("user_name");
	String password = request.getParameter("user_password");
	User user = (User) request.getSession().getAttribute(CC.USER_CONTEXT);
	String rest_id = user.getRest_id();
	JdbcTemplate jdbcTemplate = getJDBC(request);
	jdbcTemplate.update("insert into td_phone_user (rest_id,user_id,username,password) values (?,?,?,?)",new Object[]{rest_id,user_id,username,password});
    return ut.suc("添加成功");	
}

public String modifyPhoneuser(HttpServletRequest request){
	String user_id = request.getParameter("user_id");
	String username = request.getParameter("user_name");
	String password = request.getParameter("user_password");
	User user = (User) request.getSession().getAttribute(CC.USER_CONTEXT);
	String rest_id = user.getRest_id();
	
	JdbcTemplate jdbcTemplate = getJDBC(request);
	jdbcTemplate.update(" update td_phone_user set username = ? , password = ? where user_id = ? and rest_id = ?  ",new Object[]{username,password,user_id,rest_id});
    return ut.suc("修改成功");	
}
public String deletePhoneuser(HttpServletRequest request){
	String jsonStr = request.getParameter("jsonStr");
	JdbcTemplate jdbcTemplate = getJDBC(request);
	final JSONArray jsonArr = JSONArray.fromObject(jsonStr);
	jdbcTemplate.batchUpdate( " delete  from td_phone_user where user_id  = ? and rest_id = ?" , 
		new BatchPreparedStatementSetter() {
			public int getBatchSize() {
			        return jsonArr.size();
			   }
			public void setValues(PreparedStatement pstmt, int i)
					throws SQLException {
				   JSONObject item = (JSONObject)jsonArr.get(i);
				   
			       pstmt.setString(1, item.getString("id"));    
			       pstmt.setString(2, item.getString("rest_id"));    
			       //ut.log(" ****************  id = "+item.getString("id"));
			}
	});
    return ut.suc("删除成功");
}

public String addUser(HttpServletRequest request){
	String custname = request.getParameter("custname");
	String username = request.getParameter("username");
	String password = request.getParameter("password");
	String role_id = request.getParameter("role_id");
	String sub_sys = request.getParameter("sub_sys");
	String state = request.getParameter("state");
	JdbcTemplate jdbcTemplate = getJDBC(request);
	jdbcTemplate.update("insert into td_user (username,custname,password,role_id,sub_sys,state) values (?,?,?,?,?,?)",
			new Object[]{username,custname,password,role_id,sub_sys,state});
    return ut.suc("添加成功");	
}
public String modifyUser(HttpServletRequest request){
	String custname = request.getParameter("custname");
	String username = request.getParameter("username");
	String password = request.getParameter("password");
	String role_id = request.getParameter("role_id");
	String sub_sys = request.getParameter("sub_sys");
	String state = request.getParameter("state");
	JdbcTemplate jdbcTemplate = getJDBC(request);
	jdbcTemplate.update(" update td_user set custname = ? , password = ?, role_id = ?, sub_sys = ?, state = ? where username = ?  ",
			new Object[]{custname,password,role_id,sub_sys,state,username});
    return ut.suc("修改成功");	
}
public String deleteUser(HttpServletRequest request){
	String jsonStr = request.getParameter("jsonStr");
	JdbcTemplate jdbcTemplate = getJDBC(request);
	final JSONArray jsonArr = JSONArray.fromObject(jsonStr);
	jdbcTemplate.batchUpdate( " delete  from td_user where username  = ? " , 
		new BatchPreparedStatementSetter() {
			public int getBatchSize() {
			        return jsonArr.size();
			   }
			public void setValues(PreparedStatement pstmt, int i)
					throws SQLException {
				   JSONObject item = (JSONObject)jsonArr.get(i);
			       pstmt.setString(1, item.getString("id"));    
			       //ut.log(" ****************  id = "+item.getString("id"));
			}
	});
    return ut.suc("删除成功");	
}


public String addFoodcategory(HttpServletRequest request){
	User user = (User)request.getSession().getAttribute(CC.USER_CONTEXT);
	JdbcTemplate jdbcTemplate = getJDBC(request);
	String id = request.getParameter("id").trim();
	
	List data = jdbcTemplate.queryForList("select * from td_food_category where rest_id = ? and category_id = ? ",
			new Object[]{user.getRest_id(),id});
	if(data.size()>0){
		return ut.err("菜品类别 ["+id+"] 已存在!添加失败！");	
	}
	String parent_id = "-1";
	String level = "1";
	if(id.length()==3){
		parent_id = id.substring(0,1);
		level = "2";
	}
	String name = request.getParameter("name").trim();
	jdbcTemplate.update("insert into td_food_category (rest_id,category_id,parent_id,name,level) values (?,?,?,?,?)",
		new Object[]{user.getRest_id(),id,parent_id,name,level});
    return ut.suc("添加菜品类别成功");	
}
public String modifyFoodcategory(HttpServletRequest request){
	User user = (User)request.getSession().getAttribute(CC.USER_CONTEXT);
	JdbcTemplate jdbcTemplate = getJDBC(request);
	String id = request.getParameter("id");
	String name = request.getParameter("name");
	jdbcTemplate.update(" update td_food_category set name = ? where rest_id = ? and category_id = ?  ",
		new Object[]{name,user.getRest_id(),id});
    return ut.suc("修改菜品类别成功");	
}
public String deleteFoodcategory(HttpServletRequest request){
	String jsonStr = request.getParameter("jsonStr");
	final User user = (User)request.getSession().getAttribute(CC.USER_CONTEXT);
	JdbcTemplate jdbcTemplate = getJDBC(request);
	final JSONArray jsonArr = JSONArray.fromObject(jsonStr);
	jdbcTemplate.batchUpdate( " delete  from td_food_category where rest_id = ? and category_id  = ? " , 
		new BatchPreparedStatementSetter() {
			public int getBatchSize() {
			        return jsonArr.size();
			   }
			public void setValues(PreparedStatement pstmt, int i)
					throws SQLException {
				   JSONObject item = (JSONObject)jsonArr.get(i);
			       pstmt.setString(1, user.getRest_id());
			       pstmt.setString(2, item.getString("id"));  
			       //ut.log(" ****************  id = "+item.getString("id"));
			}
	});
    return ut.suc("删除菜品类别成功");	
}

public String addFood(HttpServletRequest request){
	
	User user = (User)request.getSession().getAttribute(CC.USER_CONTEXT);
	JdbcTemplate jdbcTemplate = getJDBC(request);
	
	String food_id = request.getParameter("food_id");
	String food_name = request.getParameter("food_name");
	String abbr = request.getParameter("abbr");
	String price = request.getParameter("price");
	String unit = request.getParameter("unit");
	String category = request.getParameter("category");
	String groups = request.getParameter("groups");
	String remark = request.getParameter("remark");
	
	String printer = request.getParameter("printer");
	String printer_sec = request.getParameter("printer_sec");
	String printer_start = request.getParameter("printer_start");
	String printer_hurry = request.getParameter("printer_hurry");
	String printer_back = request.getParameter("printer_back");
	
	String print_count = request.getParameter("print_count");
	String cook_tag = request.getParameter("cook_tag");
	String cook_time = request.getParameter("cook_time");
	String show_tag = request.getParameter("show_tag");
	String use_tag = request.getParameter("use_tag");
	
	
	jdbcTemplate.update("insert into td_food (rest_id,food_id,food_name,abbr,price,unit,category,groups,"+
		    " printer,printer_sec,printer_start, printer_hurry,printer_back,print_count, cook_tag, cook_time, show_tag, use_tag, remark "+
	        ") values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,? ,?,?)",
			new Object[]{user.getRest_id(), food_id,food_name,abbr.toUpperCase(),price,unit,category,groups,printer,printer_sec,printer_start,printer_hurry,printer_back,
		        print_count, cook_tag, cook_time, show_tag, use_tag, remark});
    return ut.suc("添加成功");	
}
public String modifyFood(HttpServletRequest request){
	
	User user = (User)request.getSession().getAttribute(CC.USER_CONTEXT);
	
	String food_id = request.getParameter("food_id");
	String food_name = request.getParameter("food_name");
	String abbr = request.getParameter("abbr");
	String price = request.getParameter("price");
	String unit = request.getParameter("unit");
	String category = request.getParameter("category");
	String groups = request.getParameter("groups");
	String remark = request.getParameter("remark");
	
	String printer = request.getParameter("printer");
	String printer_sec = request.getParameter("printer_sec");
	String printer_start = request.getParameter("printer_start");
	String printer_hurry = request.getParameter("printer_hurry");
	String printer_back = request.getParameter("printer_back");
	
	String print_count = request.getParameter("print_count");
	String cook_tag = request.getParameter("cook_tag");
	String cook_time = request.getParameter("cook_time");
	String show_tag = request.getParameter("show_tag");
	String use_tag = request.getParameter("use_tag");
	
	JdbcTemplate jdbcTemplate = getJDBC(request);
	jdbcTemplate.update(" update td_food set food_name=?,abbr=?,price=?,unit=?,category=?,groups=?,printer=? , "+
		    " printer_sec=?,printer_start=?,printer_hurry=?,printer_back=?,print_count=?,cook_tag=?,show_tag=?,remark = ?  "+
	        " where food_id = ? and rest_id = ? ",
			new Object[]{food_name,abbr.toUpperCase(),price,unit,category,groups,printer,printer_sec,printer_start, printer_hurry,printer_back,
		        print_count, cook_tag, show_tag, remark ,food_id,user.getRest_id()});
	return ut.suc("修改成功");	
}
public String deleteFood(HttpServletRequest request){
	final User user = (User)request.getSession().getAttribute(CC.USER_CONTEXT);
	String jsonStr = request.getParameter("jsonStr");
	JdbcTemplate jdbcTemplate = getJDBC(request);
	final JSONArray jsonArr = JSONArray.fromObject(jsonStr);
	jdbcTemplate.batchUpdate( " delete  from td_food where rest_id = ? and food_id  = ? " , 
		new BatchPreparedStatementSetter() {
			public int getBatchSize() {
			        return jsonArr.size();
			   }
			public void setValues(PreparedStatement pstmt, int i)
					throws SQLException {
				   JSONObject item = (JSONObject)jsonArr.get(i);
			       pstmt.setString(1, user.getRest_id());    
			       pstmt.setString(2, item.getString("id"));    
			       //ut.log(" ****************  id = "+item.getString("id"));
			}
	});
    return ut.suc("删除成功");	
}

public String modifySystemInfo(HttpServletRequest request){
	String rest_name = request.getParameter("rest_name");
	String address = request.getParameter("address");
	String phone = request.getParameter("phone");
	String helloword = request.getParameter("helloword");
	String printer = request.getParameter("printer");
	String ban_num = request.getParameter("ban_num");
	
	JdbcTemplate jdbcTemplate = getJDBC(request);
	List result = jdbcTemplate.queryForList("select * from td_system ");
	Map info = new HashMap();
	for(int i=0;i<result.size();i++) {
		Map temp = (Map)result.get(i);
		info.put(temp.get("name").toString(), temp.get("value").toString());
	}
	if(!rest_name.equals(info.get("rest_name").toString())){
		jdbcTemplate.update(" update td_system set value = ?  where name = ?  ",new Object[]{rest_name,"rest_name"});
		ut.log("  update rest_name  ");
	}
	if(!address.equals(info.get("address").toString())){
		jdbcTemplate.update(" update td_system set value = ?  where name = ?  ",new Object[]{address,"address"});
		ut.log("  update address  ");
	}
	if(!phone.equals(info.get("phone").toString())){
		jdbcTemplate.update(" update td_system set value = ?  where name = ?  ",new Object[]{phone,"phone"});
		ut.log("  update phone  ");
	}
	if(!helloword.equals(info.get("helloword").toString())){
		jdbcTemplate.update(" update td_system set value = ?  where name = ?  ",new Object[]{helloword,"helloword"});
		ut.log("  update helloword  ");
	}
	if(!printer.equals(info.get("printer").toString())){
		jdbcTemplate.update(" update td_system set value = ?  where name = ?  ",new Object[]{printer,"printer"});
		ut.log("  update printer  ");
	}
	if(!ban_num.equals(info.get("ban_num").toString())){
		jdbcTemplate.update(" update td_system set value = ?  where name = ?  ",new Object[]{ban_num,"ban_num"});
		ut.log("  update ban_num  ");
	}
    return ut.suc("修改成功");	
}

public String modifyBanInfo(HttpServletRequest request){
	String ban = request.getParameter("ban");
	
	ut.log("  modifyBanInfo  ban =  "+ban);
	JdbcTemplate jdbcTemplate = getJDBC(request);
	jdbcTemplate.update(" update td_system set value = ?  where name = ?  ",new Object[]{ban,"ban"});
	ut.log("  update ban  ");
    return ut.suc("修改成功");	
}

public String setOrleRight(HttpServletRequest request){
	final String role_id = request.getParameter("role_id");
	String jsonStr = request.getParameter("jsonStr");
	JdbcTemplate jdbcTemplate = getJDBC(request);
	final JSONArray jsonArr = JSONArray.fromObject(jsonStr);
	jdbcTemplate.update( " delete  from td_role_right where role_id  = ? ",new Object[]{role_id});
	jdbcTemplate.batchUpdate( " insert into td_role_right (role_id,node_id,type,ctrl) values (?,?,?,?) " , 
		new BatchPreparedStatementSetter() {
			public int getBatchSize() {
			        return jsonArr.size();
			   }
			public void setValues(PreparedStatement pstmt, int i)
					throws SQLException {
				   JSONObject item = (JSONObject)jsonArr.get(i);
			       pstmt.setString(1, role_id);  
			       pstmt.setString(2, item.getString("id"));  
			       pstmt.setString(3, "0");  
			       pstmt.setString(4, "");  
			       //ut.log(" ****************  id = "+item.getString("id"));
			}
	});
    return ut.suc("设置成功");	
}


public String addFoodPackage(HttpServletRequest request){
	String package_name = request.getParameter("package_name");
	String type = request.getParameter("type");
	type = "A";
	String price = request.getParameter("price");
	String remark = request.getParameter("remark");
	String state = request.getParameter("state");
	state = "0";
	String create_time = ut.currentTime();
	JdbcTemplate jdbcTemplate = getJDBC(request);
	String package_id = (String)jdbcTemplate.queryForObject(" select nextval('package_id') ", String.class);
	jdbcTemplate.update("insert into td_food_package (package_id,package_name,type,price,state,create_time,remark "+
	        ") values (?,?,?,?,?,?,?)",
			new Object[]{package_id,package_name,type,price,state,create_time,remark});
    return ut.suc("添加成功");	
}

public String startFoodPackageById(HttpServletRequest request){
	final String package_id = request.getParameter("id");
	JdbcTemplate jdbcTemplate = getJDBC(request);
	jdbcTemplate.update( " update td_food_package set state = '1' where package_id  = ? " ,new Object[]{ package_id });
    return ut.suc("启用成功");	
}

public String stopFoodPackageById(HttpServletRequest request){
	final String package_id = request.getParameter("id");
	JdbcTemplate jdbcTemplate = getJDBC(request);
	jdbcTemplate.update( " update td_food_package set state = '0' where package_id  = ? " ,new Object[]{ package_id });
    return ut.suc("停用成功");	
}

public String startFoodPackage(HttpServletRequest request){
	String jsonStr = request.getParameter("jsonStr");
	JdbcTemplate jdbcTemplate = getJDBC(request);
	final JSONArray jsonArr = JSONArray.fromObject(jsonStr);
	jdbcTemplate.batchUpdate( " update td_food_package set state = '1' where package_id  = ? " , 
		new BatchPreparedStatementSetter() {
			public int getBatchSize() {
			        return jsonArr.size();
			   }
			public void setValues(PreparedStatement pstmt, int i)
					throws SQLException {
				   JSONObject item = (JSONObject)jsonArr.get(i);
			       pstmt.setString(1, item.getString("id"));    
			       //ut.log(" ****************  id = "+item.getString("id"));
			}
	});
    return ut.suc("启用成功");	
}

public String stopFoodPackage(HttpServletRequest request){
	String jsonStr = request.getParameter("jsonStr");
	JdbcTemplate jdbcTemplate = getJDBC(request);
	final JSONArray jsonArr = JSONArray.fromObject(jsonStr);
	jdbcTemplate.batchUpdate( " update td_food_package set state = '0' where package_id  = ? " , 
		new BatchPreparedStatementSetter() {
			public int getBatchSize() {
			        return jsonArr.size();
			   }
			public void setValues(PreparedStatement pstmt, int i)
					throws SQLException {
				   JSONObject item = (JSONObject)jsonArr.get(i);
			       pstmt.setString(1, item.getString("id"));    
			       //ut.log(" ****************  id = "+item.getString("id"));
			}
	});
    return ut.suc("停用成功");	
}

public String saveFoodPackage(HttpServletRequest request){
	final String id = request.getParameter("id");
	String item_change_flag = request.getParameter("item_change_flag");
	if(item_change_flag==null){
		item_change_flag = "Y";
	}
	final String package_name = request.getParameter("package_name");
	final String total_price = request.getParameter("total_price");
	String jsonStr = request.getParameter("jsonStr");
	JdbcTemplate jdbcTemplate = getJDBC(request);
	final JSONArray jsonArr = JSONArray.fromObject(jsonStr);
	jdbcTemplate.update( " update  td_food_package set package_name = ?, price = ? where package_id  = ? " ,new Object[]{package_name,total_price, id });
	if(item_change_flag.equals("Y")){
		ut.log(" ****************  item_change_flag.equals(Y)  **************** ");
		jdbcTemplate.update( " delete from  td_food_package_item  where package_id  = ? " ,new Object[]{ id });
		jdbcTemplate.batchUpdate( " insert into td_food_package_item (package_id,food_id,type,package_price,count,remark) values (?,?,?,?,?,?) " , 
			new BatchPreparedStatementSetter() {
				public int getBatchSize() {
				        return jsonArr.size();
				   }
				public void setValues(PreparedStatement pstmt, int i)
						throws SQLException {
					   JSONObject item = (JSONObject)jsonArr.get(i);
				       pstmt.setString(1, id);    
				       pstmt.setString(2, item.getString("food_id"));    
				       pstmt.setString(3, "A");    
				       pstmt.setString(4, item.getString("package_price"));    
				       pstmt.setString(5, item.getString("count")); 
				       pstmt.setString(6, ""); 
				}
		});
	}
    return ut.suc("保存成功");	
}

public String getParam(HttpServletRequest request,String name){
	String param = "Exception";
	try{
		param = new String(request.getParameter(name).getBytes("iso-8859-1"),"UTF-8");
		/*
		ut.log(" name0 :" +new String(request.getParameter(name).getBytes("iso-8859-1"),"UTF-8"));
		ut.log(" name1 :" +new String(request.getParameter(name).getBytes("gbk"),"UTF-8"));
		ut.log(" name2 :" +new String(request.getParameter(name).getBytes("UTF-8"),"gbk"));
		ut.log(" name4 :" +new String(request.getParameter(name).getBytes("iso-8859-1"),"gbk"));
		ut.log(" name5 :" +request.getParameter(name));
		*/
	}catch( Exception e){
		
	}
    return param;	
}


public JdbcTemplate getJDBC(HttpServletRequest request){
	JdbcTemplate jdbcTemplate = (JdbcTemplate)GetBean.getBean("jdbcTemplate");
    return jdbcTemplate;	
}

;  
%>