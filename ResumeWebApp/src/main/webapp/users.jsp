<%@page import="com.company.main.Context"%>
<%@page import="com.company.dao.inter.UserDaoInter"%>
<%@page import="com.company.entity.User"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="assets/css/users.css">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.1/css/all.css" integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr" crossorigin="anonymous">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            List<User> searchedList = new ArrayList<>();
            List<User> listUsers = new ArrayList<>();
            UserDaoInter userDao = Context.instanceUserDao();
            List<User> list = userDao.getAll(null, null, null);
            if(request.getAttribute("searchedUsers")!=null){
                searchedList=(List<User>) request.getAttribute("searchedUsers");
            }
            listUsers=(searchedList!=null && searchedList.size()>0)? searchedList:list;
        %>
        <div class="container">
            <%--<div class="row">--%>
                <%--<div class="col-sm-8">col-sm-8</div>--%>
                <%--<div class="col-sm-4">col-sm-4</div>--%>
            <%--</div>--%>
            <%--<div class="row">--%>
                <%--<div class="col-sm">col-sm</div>--%>
                <%--<div class="col-sm">col-sm</div>--%>
                <%--<div class="col-sm">col-sm</div>--%>
            <%--</div>--%>
            <div class="row">
                <div class="col-4 ">
                    <form action="users?action=search" method="GET">
                        <div class="form-group">
                            <label for="name">name:</label>
                            <input placeholder="Enter name" class="form-control" type="text" name="name" value=""/>
                        </div>
                        <div class="form-group">
                            <label for="surname">surname:</label>
                            <input placeholder="Enter surname" class="form-control" type="text" name="surname" value=""/>
                        </div>

                        <button class="btn btn-primary" type="submit" name="action" value="search"><i class="fas fa-search-plus"></i></button>
                        <button style="margin-left: 260px;" class="btn btn-primary" type="submit" name="action" value="clear"><i class="fas fa-search-minus"></i></button>
                    </form>
                </div>
            </div>
            <div style="padding-top: 70px;">
                <table class="table">
                    <thead>
                    <tr>
                        <th>name</th>
                        <th>surname</th>
                        <th>nationality</th>
                        <th></th>
                        <th></th>
                    </tr>
                    </thead>
                    <tbody>
                    <%
                        for(User u: listUsers){
                    %>
                    <tr>
                        <td><%=u.getName()%></td>
                        <td><%=u.getSurname()%></td>
                        <td><%=u.getNationality()==null?"N/A":u.getNationality()%></td>
                        <td style="width:5px">
                            <form action="userdetail?action=delete" method="POST">
                                <input type="hidden" name="id" value="<%=u.getId()%>"/>
                                <button class="btn btn-danger" type="submit" value="delete">
                                    <i class="fas fa-trash-alt"></i>
                                </button>
                            </form>
                        </td>
                        <td style="width:5px">
                            <form action="userdetail?action=update" method="POST">
                                <input type="hidden" name="id" value="<%=u.getId()%>"/>
                                <button class="btn btn-secondary" type="submit" value="update">
                                    <i class="fas fa-pen-square"></i>
                                </button>
                            </form>
                        </td>
                    </tr>
                    <%}%>
                    </tbody>
                </table>

            </div>
        </div>

    </body>
</html>
