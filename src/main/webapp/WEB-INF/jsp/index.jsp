<!DOCTYPE HTML>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<html>
<head>
  <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta http-equiv="Pragma" content="no-cache"> 
    <meta http-equiv="Cache-Control" content="no-cache"> 
    <meta http-equiv="Expires" content="Sat, 01 Dec 2001 00:00:00 GMT">
    
    <c:choose>
      <c:when test = "${mode == 'MODE_HOME'}">
        <title>Task Manager | Home</title>
      </c:when>
      <c:when test = "${mode == 'MODE_TASKS'}">
        <title>Task Manager | Task List</title>
      </c:when>
      <c:when test = "${mode == 'MODE_UPDATE'}">
        <title>Task Manager | Manage Task</title>
      </c:when>
      <c:when test = "${mode == 'MODE_NEW'}">
        <title>Task Manager | New Task</title>
      </c:when>
    </c:choose>
    
    <link href="/static/css/bootstrap.min.css" rel="stylesheet">
    <link href="/static/css/style.css" rel="stylesheet">
    
    <!--[if lt IE 9]>
    <script src="static/js/html5shiv.min.js"></script>
    <script src="static/js/respond.min.js"></script>
    <![endif]-->
</head>
<body>
  <nav class="navbar navbar-inverse navbar-fixed-top">
    <div class="container">
      <div class = "navbar-header">
	      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
	        <span class="sr-only">Toggle Navigation</span>
	        <span class="icon-bar"></span>
	        <span class="icon-bar"></span>
	        <span class="icon-bar"></span>
	      </button>
	      <a href="/" class="navbar-brand">Task Manager</a>
	    </div>
	    <div id="navbar" class="navbar-collapse collapse" style="height:1px">
        <ul class="nav navbar-nav">
          <li><a href="/new-task">New Task</a></li>
          <!-- <li><a href="all-tasks">All Tasks</a></li> -->
        </ul>
      </div>
    </div>
  </nav>
  <c:choose>
    <%-- <c:when test="${mode == 'MODE_HOME'}">
      <div class="container text-center" id="homeDiv">
        <div class="jumbotron text-center">
          <h1>Welcome to Task Manager</h1>
        </div>
      </div>
    </c:when> --%>
    <c:when test="${mode == 'MODE_TASKS'}">
      <div class="container" id="tasksDiv">
        <h3 class="text-center">My Tasks</h3>
        <hr>
        <%-- <div class="table-responsive">
          <table class="table table-striped table-bordered text-left">
            <thead>
              <tr>
                <th>Id</th>
                <th>Name</th>
                <th>Description</th>
                <th>Date Created</th>
                <th>Finished</th>
                <th></th>
                <th></th>
              </tr>
            </thead>
            <tbody>
              <c:forEach var="task" items="${tasks}">
                <tr>
                  <td>${task.id}</td>
                  <td>${task.name}</td>
                  <td>${task.description}</td>
                  <td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${task.dateCreated}"/></td>
                  <td>${task.finished}</td>
                  <td><a href="update-task?id=${task.id}"><span class="glyphicon glyphicon-pencil"></span></a></td>
                  <td><a href="delete-task?id=${task.id}"><span class="glyphicon glyphicon-trash"></span></a></td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
        </div> --%>
	      <ul>   
	        <c:forEach var = "task" items="${tasks}">  
	          <li class="task-name"><a href="tasks/${task.id}">${task.name}</a> - 
	          <c:choose>
					    <c:when test="${task.finished==true}">
					        Finished
					    </c:when>    
					    <c:otherwise>
					        Not finished
					    </c:otherwise>
					 </c:choose></li>
	        </c:forEach>
	      </ul>	     
      </div>
    </c:when>
    <c:when test="${mode == 'MODE_NEW' || mode == 'MODE_UPDATE'}">
      <div class="container">
         <c:choose>
            <c:when test="${mode == 'MODE_NEW'}">
              <h3 class="text-center">New Task</h3>
            </c:when>
            <c:when test="${mode == 'MODE_UPDATE'}">
              <h3 class="text-center">Manage Task</h3>
            </c:when>
          </c:choose>
        <hr>
        <form id="form" method="POST" action="<c:url value="/save-task" />">
          <input type="hidden" name="id" value="${task.id}"/>
          <div class="form-group">
            <label for="name" class="control-label">Name</label>
            <input type="text" class="form-control" name="name" value="${task.name}"/>
          </div>
          <div class="form-group">
            <label for="decription" class="control-label">Description</label>
            <input type="text" class="form-control" name="description" value="${task.description}"/>
          </div>
          <div class="form-group">
            <label for="finished" class="radio control-label">Finished</label>
            <label class="radio-inline"><input type="radio" name="finished" value="true"/>Yes</label>
            <label class="radio-inline"><input type="radio" name="finished" value="false" checked/>No</label>
          </div>    
          <div class="form-group">
            <input type="submit" class="btn btn-primary" value="Save"/>
            <c:choose>
	            <c:when test="${mode == 'MODE_UPDATE'}">
	              <button type="button" class="btn btn-danger" name='deleteButton' id='deleteButton' value="${task.id}">Delete</button>
	            </c:when>
	          </c:choose>
          </div>
        </form>
      </div>
      <div class="modal fade" id="infoModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
          <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 id="modalTitle" class="modal-title" id="myModalLabel">Success</h4>
            </div>
            <div class="modal-body">
                <c:choose>
			            <c:when test="${mode == 'MODE_NEW'}">
			              <p id="modalMessage">New task created successfully!</p>
			            </c:when>
			            <c:when test="${mode == 'MODE_UPDATE'}">
			              <p id="modalMessage">Task updated successfully!</p>
			            </c:when>
			          </c:choose>
            </div>
            <div class="modal-footer">
                <a class="btn btn-primary" href="/" role="button">Go Back</a>
            </div>
          </div>
        </div>
      </div>
    </c:when>   
  </c:choose>

  <script src="/static/js/jquery-1.11.1.min.js"></script>    
  <script src="/static/js/bootstrap.min.js"></script>
  <script src="/static/js/main.js"></script>
</body>
</html>