<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="org.apache.commons.lang3.ArrayUtils"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="org.apache.commons.lang3.StringEscapeUtils"%>
<%@page import="jease.cms.domain.Content"%>
<%@page import="jease.cms.domain.News"%>
<%@page import="jease.cms.domain.Topic"%>
<%@page import="jease.cms.domain.Folder"%>
<%@page import="jease.site.Navigations"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Random"%>


<% 
	Content content = (Content) request.getAttribute("Node"); 
	Content root = (Content) request.getAttribute("Root");
	String pname=content.getPath();

	
	request.setAttribute("pname", pname);

%>
<!doctype html>
<html lang="en" dir="ltr">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <meta http-equiv="Content-Language" content="en" />
    <meta name="msapplication-TileColor" content="#2d89ef">
    <meta name="theme-color" content="#4188c9">
    <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent"/>
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="mobile-web-app-capable" content="yes">
    <meta name="HandheldFriendly" content="True">
    <meta name="MobileOptimized" content="320">
    <link rel="icon" href="<%=request.getContextPath() %>/site/web/tabler/assets/favicon.ico" type="image/x-icon"/>
    <link rel="shortcut icon" type="image/x-icon" href="<%=request.getContextPath() %>/site/web/tabler/assets/favicon.ico" />
    <title><%=Navigations.getPageTitle(content)%></title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,300i,400,400i,500,500i,600,600i,700,700i&amp;subset=latin-ext">
    <script src="<%=request.getContextPath() %>/site/web/tabler/assets/js/require.min.js"></script>
    <script>
      requirejs.config({
          baseUrl: '.'
      });
    </script>
    <!-- Dashboard Core -->
    <link href="<%=request.getContextPath() %>/site/web/tabler/assets/css/dashboard.css" rel="stylesheet" />
    <script src="<%=request.getContextPath() %>/site/web/tabler/assets/js/dashboard.js"></script>
   
  </head>

  <body class="">
    <div class="page">
      <div class="page-main">
        <div class="header py-4">
          <div class="container">
            <div class="d-flex">
              <a class="header-brand" href="<%=request.getContextPath() %>/">
                <img src="<%=request.getContextPath() %>/site/web/tabler/assets/images/logo.png" class="header-brand-img" alt="jease logo">
              </a>
              <div class="d-flex order-lg-2 ml-auto">
                <div class="nav-item d-none d-md-flex">
                  <a href="https://github.com/jease/jease" class="btn btn-sm btn-outline-primary" target="_blank">Source code</a>
                </div>
                <div class="dropdown d-none d-md-flex">
                  <a class="nav-link icon" data-toggle="dropdown">
                    <i class="fe fe-bell"></i>
                    <span class="nav-unread"></span>
                  </a>
                  <div class="dropdown-menu dropdown-menu-right dropdown-menu-arrow">
                    
<%
		News[] news = Navigations.getNews((Content) content.getParent());
		if(ArrayUtils.isNotEmpty(news)) {
			for (News item : news) {
	%>
			<a href="#" class="dropdown-item d-flex">
                      
                      <div>
                        <strong><%=item.getTitle()%></strong>                       
                        <div class="small text-muted"><% if (item.getDate() != null) { %>
<%=String.format("%tF", item.getDate())%>
			<%} %>	</div>
                      </div>
                    </a>
		<% } %>
	<% } %>

                  </div>
                </div>
                
              </div>
              <a href="#" class="header-toggler d-lg-none ml-3 ml-lg-0" data-toggle="collapse" data-target="#headerMenuCollapse">
                <span class="header-toggler-icon"></span>
              </a>
            </div>
          </div>
        </div>
        <div class="header collapse d-lg-flex p-0" id="headerMenuCollapse">
          <div class="container">
            <div class="row align-items-center">
              <div class="col-lg-3 ml-auto">
                <form action="<%=request.getContextPath() %><%=root.getPath()%>" method="get" class="input-icon my-3 my-lg-0">
                  <input type="search" name="query" <% if(request.getParameter("query") != null) { %>value="<%= StringEscapeUtils.escapeHtml4(request.getParameter("query")) %>"<% } else { %>value="Enter your search..." onfocus="this.value='';"<% } %>  class="form-control header-search" placeholder="Search&hellip;" tabindex="1">
			<input type="hidden" name="page" value="/site/service/Search.jsp" />
                  <div class="input-icon-addon">
                    <i class="fe fe-search"></i>
                  </div>
                </form>
              </div>
              <div class="col-lg order-lg-first">
                <ul class="nav nav-tabs border-0 flex-column flex-lg-row">
<% for (Content tab : Navigations.getTabs(root)) { %>
                    					<li <%=content.getPath().startsWith(tab.getPath()) ? " class=\"current\"" : "class=\"nav-item\""%>>
                    						<a class="nav-link" href="<%=request.getContextPath() %><%=tab.getPath()%>"><%=tab.getTitle()%></a>
                    					</li>
                    				<% } %>
                 
                  
                </ul>
              </div>
            </div>
          </div>
        </div>
         <div class="my-3 my-md-5">
          <div class="container">
            <div class="page-header">
              <h1 class="page-title">
                <%=((Content) content.getParent()).getTitle()%>
              </h1>
            </div>
            <div class="row">
              <div class="col-lg-3 order-lg-1 mb-4">
<div class="card">
                  <div class="card-body">
                <!-- Components -->
                <div class="list-group list-group-transparent mb-0">
<% for (Content item : Navigations.getItems((Content) content.getParent())) { %>
				<% if (item instanceof Topic) { %>
 <span  class="list-group-item list-group-item-action active"><span class="icon mr-3"><i class="fe fe-flag"></i></span><%=item.getTitle()%></span>
					
				<% } else { %>
<a class="list-group-item list-group-item-action" href="<%=request.getContextPath() %><%=item.getPath()%>"><%=item.getTitle()%></a>
			<% } %>
		<% } %>                  

</div>
</div>
<div class="card">
<div class="card-body">
<%
String[] color=new String[]{"red","blue","yellow","orange","green"};
		if(ArrayUtils.isNotEmpty(news)) {
			for (News item : news) {
	%>
                    <div class="card">
                      <div class="card-status bg-<%=color[new Random().nextInt(5)]%>"></div>
                      <div class="card-body">
                        <h4 class="mb-3"><%=item.getTitle()%></h4>
                        <div class="row">
                          <div class="col-auto">
<% if (item.getDate() != null) { %>


                            <div class="text-muted-dark"><i class="mdi mdi-calendar mr-1 text-muted w-4 text-center"></i> <%=String.format("%tF", item.getDate())%></div>
			<%} %>	
                          </div>
                          <div class="col-auto">
                            <div class="text-muted-dark"><i class="mdi mdi-map-marker mr-1 text-muted w-4 text-center"></i> <% if (StringUtils.isBlank(item.getTeaser())) { %>
				<%=item.getStory()%>
			<% } else { %>
				<p><%=item.getTeaser()%><br />
				<a href="<%=request.getContextPath() %><%=item.getPath()%>?print">More...</a>
				</p>
			<% } %></div>
                          </div>
                        </div>

                      </div>
                    </div>
<% } %>
	<% } %>
                </div>
                </div>
                </div>
              </div>

              <div class="col-lg-9">
                <div class="card">
                  <div class="card-body">
<p id="breadcrumb">
				<% for (Content parent : Navigations.getBreadcrumb(root, content)) { %>
					&raquo; <a href="<%=request.getContextPath() %><%=parent.getPath()%>"><%=parent.getTitle()%></a>
				<% } %>
			</p>
<% pageContext.include((String) request.getAttribute("Page.Template")); %>
			<div style="clear: both"></div>
			<p id="editorial">
			<% Content latestChange = Navigations.getLatestContribution(content); %>
			Last modified on <%=String.format("%tF", latestChange.getLastModified())%>
			<% if (latestChange.getEditor() != null) { %>
				by <%=latestChange.getEditor().getName()%>
			<% }%>
			</p>






            </div>
          </div>

        </div>
      </div>

        </div>
      </div>
      <div class="footer">
        <div class="container">
          <div class="row">
            <div class="col-lg-8">
              <div class="row">
Choose template : <span ></span><%@include file="/site/service/Designswitch.jsp" %>
              </div>
            </div>
            <div class="col-lg-4 mt-4 mt-lg-0">
               Jease means "Java with Ease", so Jease promises to keep simple things simple and the hard things (j)easy.
            </div>
          </div>
        </div>
      </div>
      <footer class="footer">
        <div class="container">
          <div class="row align-items-center flex-row-reverse">
            <div class="col-auto ml-lg-auto">
              <div class="row align-items-center">
                <div class="col-auto">
                  <ul class="list-inline list-inline-dots mb-0">
                    <li class="list-inline-item"><a href="<%=request.getContextPath() %>/documentation/">Documentation</a></li>
                    <li class="list-inline-item"><a href="<%=request.getContextPath() %>/support/">FAQ</a></li>
                  </ul>
                </div>
                <div class="col-auto">
                  <a href="https://github.com/jease/jease" class="btn btn-outline-primary btn-sm">Source code</a>
                </div>
              </div>
            </div>
            <div class="col-12 col-lg-auto mt-3 mt-lg-0 text-center">
              Copyright ©2009-<%@include file="/site/service/Copyright.jsp" %> | Template Design by <a href="http://github.com/tabler/tabler">Tabler template</a> All rights reserved.
            </div>
          </div>
        </div>
      </footer>
    </div>
  </body>
</html>
