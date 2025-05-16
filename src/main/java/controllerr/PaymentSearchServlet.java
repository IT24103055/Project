package com.yourteam.appointment.controller;

import com.yourteam.appointment.model.Patient;
import com.yourteam.appointment.utils.PaymentUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/PaymentSearchServlet")
public class PaymentSearchServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String query = request.getParameter("searchQuery"); // form input
        String filePath = getServletContext().getRealPath("/data/patients.txt");

        List<Patient> matchedPatients = PaymentUtil.searchPatientsForPayment(query, filePath);

        if (matchedPatients.isEmpty()) {
            request.setAttribute("error", "No matching patient found.");
            request.getRequestDispatcher("paymentsearch.jsp").forward(request, response);
        } else {
            HttpSession session = request.getSession();
            session.setAttribute("matchedPatients", matchedPatients);
            response.sendRedirect("payment.jsp");
        }
    }
}
