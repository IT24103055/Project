<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Feedback Manager - MediCare</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/DeleteFeedback.css">
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
            <h4 class="mb-4 font-weight-bold text-center">User Feedback</h4>
        </div>

        <table>
            <thead>
            <tr>
                <th>Username</th>
                <th>Feedback</th>
                <th>Action</th>
            </tr>
            </thead>
            <tbody id="admin-table-body">
            <tr>
            <tr id="feedback-1">
                <td>user1</td>
                <td>Love the new features!</td>
                <td><button class="delete-btn" onclick="deleteFeedback(1)"><i class="fa-solid fa-trash"></i> Delete</button></td>
            </tr>
            <tr>
            <tr id="feedback-2">
                <td>user2</td>
                <td>Service was a bit slow today.</td>
                <td><button class="delete-btn" onclick="deleteFeedback(2)"><i class="fa-solid fa-trash"></i> Delete</button></td>

            </tr>
            </tbody>
        </table>
    </section>
</div>

<script>
    function deleteFeedback(id) {
        const confirmed = confirm("Are you sure you want to delete this feedback?");
        if (confirmed) {
            const row = document.getElementById("feedback-" + id);
            row.remove();
            document.getElementById("message").textContent = `✅ Feedback ID ${id} deleted successfully.`;
            setTimeout(() => {
                document.getElementById("message").textContent = "";
            }, 3000);
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