<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Patient Dashboard - MediCare</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/AdminUsers.css">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<!-- Header -->
<div class="top-bar">
    <div class="container d-flex justify-content-between align-items-center">
        <div class="logo-title d-flex align-items-center">
            <h2 style="margin: 0;">MediCare</h2>
            <img src="images/medical-heart-logo-icon-vector-260nw-2477158081.webp" alt="Logo" class="top-logo">
        </div>
    </div>
</div>

<%@ include file="includes/navbar.jsp" %>

<div class="content">
    <section id="admin-list">
        <div class="module-title">
            <h4 class="mb-4 font-weight-bold text-center">Admin Users</h4>
        </div>

        <table>
            <thead>
            <tr>
                <th>Full Name</th>
                <th>Email Address</th>
                <th>NIC</th>
                <th>Gender</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody id="admin-table-body">
            <tr>
                <td>admin1</td>
                <td>admin1@example.com</td>
                <td>200281403343</td>
                <td>male</td>
                <td class="action-buttons">
                    <button class="button" onclick="editAdmin(1)">
                        <i class="fa-solid fa-pen"></i> Edit
                    </button>
                    <button class="button" onclick="deleteAdmin(1)">
                        <i class="fa-solid fa-trash"></i> Delete
                    </button>
                </td>
            </tr>
            <tr>
                <td>admin2</td>
                <td>admin2@example.com</td>
                <td>200471204432</td>
                <td>female</td>
                <td class="action-buttons">
                    <button class="button" onclick="editAdmin(2)">
                        <i class="fa-solid fa-pen"></i> Edit
                    </button>
                    <button class="button" onclick="deleteAdmin(2)">
                        <i class="fa-solid fa-trash"></i> Delete
                    </button>
                </td>
            </tr>
            </tbody>
        </table>
    </section>
</div>

<script>
    function editAdmin(id) {
        alert("Editing admin with ID: " + id);
    }

    function deleteAdmin(id) {
        const confirmDelete = confirm("Are you sure you want to delete admin ID " + id + "?");
        if (confirmDelete) {
            alert("Admin " + id + " deleted.");
        }
    }
</script>

<%@ include file="includes/footer.jsp" %>

<script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
<script>
    document.querySelector("form").addEventListener("submit", function (e) {
        const password = document.getElementById("password");
        const confirm = document.getElementById("confirm");
        if (password && confirm && password.value !== confirm.value) {
            e.preventDefault();
            alert("Passwords do not match. Please try again.");
        }
    });
</script>

</body>
</html>