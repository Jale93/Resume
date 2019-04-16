/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.company.resume.controller;

import com.company.dao.inter.UserDaoInter;
import com.company.dao.inter.UserSkillDaoInter;
import com.company.entity.User;
import com.company.entity.UserSkill;
import com.company.main.Context;
import java.io.IOException;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author jale.mammadli
 */
@WebServlet(name = "UserDetailController", urlPatterns = {"/userdetail"})
public class UserDetailController extends HttpServlet {

   private UserDaoInter userDao = Context.instanceUserDao();
    private UserSkillDaoInter userSkillDao = Context.instanceUserSkillDao();
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = "";
        if (request.getParameter("action") != null) {
            action = request.getParameter("action");
        }
        try {
            if(action.equalsIgnoreCase("update")) {

                String userIdStr = request.getParameter("id");
                if (userIdStr == null || userIdStr.trim().isEmpty()) {
                    throw new IllegalArgumentException("id is not specified");
                }

                Integer userId = Integer.parseInt(userIdStr);
                User u = userDao.getById(userId);
                List<UserSkill> s=userSkillDao.getAllSkillByUserId(userId);
                if (u == null) {
                    throw new IllegalArgumentException(" There is no user with this id");
                }

                request.setAttribute("owner", true);
                request.setAttribute("user", u);
                request.setAttribute("listSkills", s);
                request.getRequestDispatcher("userdetail.jsp").forward(request, response);
            }else if(action.equalsIgnoreCase("updated")) {
                int id= Integer.valueOf(request.getParameter("id"));
                String name = request.getParameter("name");
                String surname = request.getParameter("surname");

                System.out.println("name=" + name);
                System.out.println("surname=" + surname);

                User user = userDao.getById(id);
                user.setName(name);
                user.setSurname(surname);

                userDao.updateUser(user);
            }else if(action.equalsIgnoreCase("delete")){
                int id= Integer.valueOf(request.getParameter("id"));
                userDao.removeUser(id);
            }
            response.sendRedirect("users");
        } catch (Exception ex){
            ex.printStackTrace();
        }
    }
     
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }


}
