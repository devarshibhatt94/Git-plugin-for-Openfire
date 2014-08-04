<%@ page import="java.util.Map" %>
<%@ page import= "java.util.HashMap" %>
<%@ page import= "plugin.GitInPlugin" %>
<%@ page import= "org.jivesoftware.openfire.*" %>
<%@ page import= "org.jivesoftware.util.*" %>
<%@ page  errorPage="error.jsp" %>
<%@ page import= "prop.*" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<fmt:setBundle basename="prop.gitin_i18n"/>
<c:if test="${param['lang'] !=null}">
    <fmt:setLocale value="${param['lang']}" scope="session" />
</c:if>

<%
    boolean run = request.getParameter("run")!=null;
    boolean gitinEnabled = ParamUtils.getBooleanParameter(request, "gitinenabled");
    String gitinCommand = ParamUtils.getParameter(request,"gitincommand");
    String address = ParamUtils.getParameter(request, "address");
    String message="hello";
    
    GitInPlugin plugin = new GitInPlugin();//(GitInPlugin)XMPPServer.getInstance().getPluginManager().getPlugin("gitin");
    Map<String, String>errors = new HashMap<String,String>();
    if(run){
    	
    	if(address == null)
    	{
    		errors.put("missingAddress","missingAddress");
    	}
        if(gitinCommand == null)
        {
            errors.put("missingCommand","missingCommand");
        }
        if(errors.size() == 0)
        {
            plugin.setEnabled(gitinEnabled);
            plugin.setCommand(address+" & "+gitinCommand);
           
            message=plugin.runCommand();
            response.sendRedirect("gitin-form.jsp?CommandEntered=true");
            return;
        }
    }
    
    gitinEnabled = plugin.isEnabled();
    gitinCommand = plugin.getCommand();
    
    
%>

<html>
    <head>
        <title><fmt:message key="gitin.title"/></title>
        <meta name="pageID" content="gitin-form"/>
      
    </head>
    <body>
   
        <form id='form1' action="gitin-form.jsp?run" method ="post">
            <div class="jive-contentBoxHeader">
                <fmt:message key="gitin.options"/>
            </div>
            
            <div class ="jive-contentBox">
                
                <% if (ParamUtils.getBooleanParameter(request,"CommandEntered")){%>
                <div class="jive-success">
                    <table cellpadding="0" cellspacing="0" border="0">
                        <tbody>
                            <tr>
                            <td class ="jive-icon"><img src="images/success-16x16.gif" width="16" height="16" border ="0"></td>
                            <td class="jive-icon-label"><fmt:message key="gitin.run.success" /></td>
                            </tr>
                        </tbody>
                    </table>
            </div>
                <% } %>
                
                <table cellpadding="3" cellspacing="0" border="0" width="100%">
                    <tbody>
                        <tr>
                            <td width="1%" align="center" nowrap>
                                <input type="checkbox" name="gitinenabled" <%= gitinEnabled?"checked":""%>></td>
                            <td width="99%" align="left"><fmt:message key="gitin.enable" />
                            </td>
                        </tr>
                    </tbody>
                </table>
                            
                       <br><br>
                               <p><fmt:message key="gitin.directions"/></p>
                                                        
                    <table cellpadding="3" cellspacing="0" border ="0" width="100%">
                                <tbody>
                                 <tr>
                            <td width="5%" valign="top">
                                            <fmt:message key="gitin.address" />:&nbsp;</td>
                                        <td width="95%"><input type="text" name="address" value="<%=address%>"></td>
                                        <% if(errors.containsKey("missingAddress")){ %>
                                <span class="jive-error-text"><fmt:message key="gitin.address.missing"/></span>
                                <% } %>
                            </tr>
                                    <tr>
                                        <td width="5%" valign="top">
                                            <fmt:message key="gitin.command" />:&nbsp;</td>
                                        <td width="95%"><input type="text" name="gitincommand" value="<%=gitinCommand%>"></td>
                                        <% if(errors.containsKey("missingCommand")){ %>
                                <span class="jive-error-text"><fmt:message key="gitin.command.missing"/></span>
                                <% } %>
							
                            </tr>
                            
                                                      
                            </tbody>
                            </table>
                            
            </div>
             
                                <input type="submit" value="<fmt:message key="gitin.button.run"/>"/>
                                 
        </form>
       
    
   
    </body>
</html>
