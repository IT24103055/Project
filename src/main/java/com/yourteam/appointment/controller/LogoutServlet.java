package com.yourteam.appointment.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/LogoutServlet")
public class LogoutServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false); // don’t create if it doesn't exist
        if (session != null) {
            session.invalidate(); // clear session data
        }

        response.sendRedirect("login.jsp"); // or your home page
    }
}
