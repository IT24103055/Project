package com.yourteam.appointment.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

        import java.io.*;

@WebServlet("/AdminRegisterServlet")
public class AdminRegisterServlet extends HttpServlet {

    private static final String FILE_PATH = "data/admins.txt";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // ✅ Restrict registration to "main" admins only
        HttpSession session = request.getSession(false);
        String currentRole = (session != null) ? (String) session.getAttribute("role") : null;

        if (!"main".equals(currentRole)) {
            request.setAttribute("errorMessage", "Only the main admin can register new admins.");
            request.getRequestDispatcher("AdminManagement.jsp").forward(request, response);
            return;
        }

        // ✅ Retrieve new admin details
        String fullName = request.getParameter("fullname");
        String email = request.getParameter("email");
        String nic = request.getParameter("nic");
        String gender = request.getParameter("gender");
        String password = request.getParameter("password");
        String confirm = request.getParameter("confirm");
        String role = request.getParameter("role"); // from a dropdown like: <select name="role"><option>standard</option></select>

        // Get full file path
        String filePath = getServletContext().getRealPath(FILE_PATH);

        // Check password match
        if (!password.equals(confirm)) {
            request.setAttribute("errorMessage", "Passwords do not match.");
            request.getRequestDispatcher("AdminManagement.jsp").forward(request, response);
            return;
        }

        // Check for existing email/NIC
        if (isDuplicate(email, nic, filePath)) {
            request.setAttribute("errorMessage", "Admin with this Email or NIC already exists.");
            request.getRequestDispatcher("AdminManagement.jsp").forward(request, response);
            return;
        }

        // ✅ Save new admin with role
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath, true))) {
            writer.write(fullName + "|" + email + "|" + password + "|" + nic + "|" + gender + "|" + role);
            writer.newLine();
        }

        request.setAttribute("successMessage", "Admin registered successfully.");
        request.getRequestDispatcher("AdminManagement.jsp").forward(request, response);
    }

    private boolean isDuplicate(String email, String nic, String filePath) {
        try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split("\\|");
                if (parts.length >= 6) {
                    if (parts[1].equalsIgnoreCase(email) || parts[3].equalsIgnoreCase(nic)) {
                        return true;
                    }
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return false;
    }
}
