package com.yourteam.appointment.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

        import java.io.*;

@WebServlet("/UpdateAdminServlet")
public class UpdateAdminServlet extends HttpServlet {

    private static final String FILE_PATH = "data/admins.txt";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String fullname = request.getParameter("fullname").trim();
        String email = request.getParameter("email").trim();
        String password = request.getParameter("password").trim();
        String nic = request.getParameter("nic").trim();
        String gender = request.getParameter("gender").trim();

        String filePath = getServletContext().getRealPath(FILE_PATH);
        File inputFile = new File(filePath);
        File tempFile = new File(filePath + ".tmp");

        HttpSession session = request.getSession();
        String sessionUsername = (String) session.getAttribute("username"); // should be fullname

        boolean updated = false;

        try (
                BufferedReader reader = new BufferedReader(new FileReader(inputFile));
                BufferedWriter writer = new BufferedWriter(new FileWriter(tempFile))
        ) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split("\\|");
                if (parts.length == 6 && parts[0].equalsIgnoreCase(sessionUsername)) {
                    String role = parts[5]; // ✅ Preserve the original role
                    String updatedLine = fullname + "|" + email + "|" + password + "|" + nic + "|" + gender + "|" + role;
                    writer.write(updatedLine);
                    session.setAttribute("username", fullname); // Update session name if changed
                    updated = true;
                } else {
                    writer.write(line);
                }
                writer.newLine();
            }
        }

        // Replace original file with updated one
        if (inputFile.delete() && tempFile.renameTo(inputFile) && updated) {
            request.setAttribute("successMessage", "Profile updated successfully.");
        } else {
            request.setAttribute("errorMessage", "Update failed.");
        }

        request.getRequestDispatcher("AdminProfile.jsp").forward(request, response);
    }
}
