<%@page import="com.company.main.Context"%>
<%@page import="com.company.dao.inter.UserDaoInter"%>
<%@page import="com.company.entity.User"%>
<%@ page import="com.company.entity.Skill" %>
<%@ page import="java.util.List" %>
<%@ page import="com.company.entity.UserSkill" %>
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
    <div class="container">
        <%
            User u = (User) request.getAttribute("user");
        %>
        <div class="row">
            <div class="col-4">
                <form action="userdetail?action=updated" method="POST">
                    <input type="hidden" name="id" value="<%=u.getId()%>"/>
                    <div class="form-group">
                    <label for="name">name:</label>
                    <input type="text" name="name" class="form-control" value="<%=u.getName()%>"/>
                    </div>
                    <div class="form-group">
                    <label for="surname">surname</label>
                    <input type="text" name="surname" class="form-control" value="<%=u.getSurname()%>"/>
                    </div>
                    <div class="form-group">
                    <label for="nationality">nationality</label>
                    <input type="text" name="nationality" class="form-control" value="<%=u.getNationality()%>"/>
                    </div>
                    <input type="submit" name="save" value="Save"/>
                </form>
            </div>
            <div class="col-12" style="padding-top: 70px;">
                <table class="table">
                    <thead>
                    <tr>
                        <th>Email</th>
                        <th>Phone</th>
                        <th>Birthdate</th>
                        <th>Country</th>
                        <th>Nationality</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td><%=u.getEmail()%></td>
                        <td><%=u.getPhone()%></td>
                        <td><%=u.getBirthDate()%></td>
                        <td><%=u.getBirthPlace()%></td>
                        <td><%=u.getNationality()%></td>
                    </tr>
                    </tbody>
                </table>
                <table class="table">
                    <thead>
                    <tr>
                        <th>Profile Description</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td><%=u.getProfileDesc()%></td>
                    </tr>
                    </tbody>
                </table>

            </div>
        <div class="col-12" style="padding-top: 70px;">
            <table class="table">
                <thead>
                <tr>
                    <th>Skill Name</th>
                    <th>Power</th>
                </tr>
                </thead>
                <tbody>
                <%
                    List<UserSkill> listSkills = (List<UserSkill>) request.getAttribute("listSkills");
                    for(UserSkill s: listSkills){
                %>
                <tr>
                    <td><%=s.getSkill()%></td>
                    <td><%=s.getPower()%></td>
                </tr>
                <% } %>
                </tbody>
            </table>

        </div>
        </div>
    </div>
    </body>
</html>
