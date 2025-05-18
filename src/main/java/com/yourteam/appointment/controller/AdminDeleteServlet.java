package com.yourteam.appointment.controller;

import com.yourteam.appointment.utils.AdminUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/AdminDeleteServlet")
public class AdminDeleteServlet extends HttpServlet {

    private static final String FILE_PATH = "/data/admins.txt";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String nicToDelete = request.getParameter("nic");
        HttpSession session = request.getSession(false);

        String currentRole = (session != null) ? (String) session.getAttribute("role") : null;
        String currentNic = (session != null) ? (String) session.getAttribute("nic") : null;
        String realPath = getServletContext().getRealPath(FILE_PATH);

        // ✅ Delegate deletion logic to AdminUtil
        boolean deleted = AdminUtil.deleteAdmin(nicToDelete, currentNic, currentRole, realPath, request);

        // ✅ Set success or error message based on outcome
        if (deleted) {
            request.setAttribute("successMessage", "Admin account deleted successfully.");
        } else if (request.getAttribute("errorMessage") == null) {
            request.setAttribute("errorMessage", "No matching NIC found.");
        }

        request.getRequestDispatcher("AdminDelete.jsp").forward(request, response);
    }
}
