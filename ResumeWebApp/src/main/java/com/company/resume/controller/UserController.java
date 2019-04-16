/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.company.resume.controller;

import com.company.dao.inter.UserDaoInter;
import com.company.entity.User;
import com.company.main.Context;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 *
 * @author jale.mammadli
 */
@WebServlet(name = "UserController", urlPatterns = {"/users"})
public class UserController extends HttpServlet {
    private UserDaoInter userDao = Context.instanceUserDao();
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = "";
        if (request.getParameter("action") != null) {
            action = request.getParameter("action");
        }
        try {
            if(action.equalsIgnoreCase("search")) {
                if ((request.getParameter("name") != null && !request.getParameter("name").isEmpty())
                        || (request.getParameter("surname") != null && !request.getParameter("surname").isEmpty())
                ) {
                    String name = request.getParameter("name");
                    String surname = request.getParameter("surname");
                    String nationalityIdStr = request.getParameter("nid");

                    Integer nationalityId = null;
                    if (nationalityIdStr != null && !nationalityIdStr.trim().isEmpty()) {
                        nationalityId = Integer.parseInt(nationalityIdStr);
                    }
                    List<User> serachedList = userDao.getAll(name, surname, nationalityId);
                    request.setAttribute("searchedUsers", serachedList);
                    request.getRequestDispatcher("users.jsp").forward(request, response);
                }else {
                    response.sendRedirect("error?msg=not found");
                }
            }else if(action.equalsIgnoreCase("clear")){
                response.sendRedirect("users");
            }else{
                request.getRequestDispatcher("users.jsp").forward(request, response);
            }
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
