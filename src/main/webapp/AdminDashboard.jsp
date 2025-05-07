<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
        <title>Admin Dashboard - MediCare</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="css/adminDashboard.css">
</head>
<body>
<div class="sidebar">
    <h2>Admin Menu</h2>
    <ul>
        <li><a href="/admin/dashboard">Dashboard</a></li>
        <li><a href="/admin/users">Manage Users</a></li>
        <li><a href="/admin/roles">Manage Roles & Permissions</a></li>
        <li><a href="/admin/settings">Settings</a></li>
    </ul>
</div>

<div class="content">
    <h1>Admin Dashboard</h1>

    <section id="admin-list">
        <h2 class="module-title">Admin Users</h2>
        <button class="button" onclick="location.href='/admin/register'">Add New Admin</button>
        <table>
            <thead>
            <tr>
                <th>ID</th>
                <th>Username</th>
                <th>Email</th>
                <th>Role</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody id="admin-table-body">
            <%-- In a real application, you would dynamically populate this table
                 using data fetched from your backend (e.g., via JSTL tags).
                 For now, let's keep the static example. --%>
            <tr>
                <td>1</td>
                <td>admin1</td>
                <td>admin1@example.com</td>
                <td>Super Admin</td>
                <td>
                    <button class="button" onclick="editAdmin(1)">Edit</button>
                    <button class="button" onclick="deleteAdmin(1)">Delete</button>
                </td>
            </tr>
            <tr>
                <td>2</td>
                <td>editor1</td>
                <td>editor1@example.com</td>
                <td>Editor</td>
                <td>
                    <button class="button" onclick="editAdmin(2)">Edit</button>
                    <button class="button" onclick="deleteAdmin(2)">Delete</button>
                </td>
            </tr>
            </tbody>
        </table>
    </section>

    <section id="admin-registration" style="display:none;">
        <h2 class="module-title">Register New Admin</h2>
        <form id="registration-form" action="/admin/register" method="post"> <%-- Form submission URL --%>
            <div>
                <label for="username">Username:</label>
                <input type="text" id="username" name="username" required>
            </div>
            <div>
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" required>
            </div>
            <div>
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" required>
            </div>
            <div>
                <label for="role">Role:</label>
                <select id="role" name="role">
                    <option value="admin">Admin</option>
                    <option value="editor">Editor</option>
                </select>
            </div>
            <button type="submit" class="button">Register</button>
        </form>
    </section>

</div>

<script>
    // Basic JavaScript for toggling sections (you'll need more for actual data handling)
    function showSection(id) {
        document.querySelectorAll('.content > section').forEach(section => {
            section.style.display = 'none';
        });
        document.getElementById(id).style.display = 'block';
    }

    // Example functions (will need backend integration via JavaScript and potentially AJAX)
    function editAdmin(id) {
        alert('Edit admin with ID: ' + id);
        // Implement logic to fetch and display admin details for editing
    }

    function deleteAdmin(id) {
        if (confirm('Are you sure you want to delete admin with ID: ' + id + '?')) {
            alert('Deleting admin with ID: ' + id);
            // Implement logic to send a delete request to the backend (e.g., AJAX call)
        }
    }

    document.addEventListener('DOMContentLoaded', () => {
        // Initially show the admin list or dashboard
        showSection('admin-list');

        // Example of how you might handle navigation (adapt to your routing)
        document.querySelectorAll('.sidebar a').forEach(link => {
            link.addEventListener('click', function(event) {
                event.preventDefault();
                const path = this.getAttribute('href');
                if (path === '/admin/dashboard' || path === '/admin/users') {
                    showSection('admin-list');
                    // In a real app, you might fetch and display user data here
                } else if (path === '/admin/register') {
                    showSection('admin-registration');
                }
                // Add more conditions for other pages
            });
        });

        document.getElementById('registration-form').addEventListener('submit', function(event) {
            // In a JSP-based application, the form submission will likely trigger a
            // server-side servlet to handle the registration logic.
            // The basic JavaScript alert can be removed or enhanced for client-side validation.
            console.log('Form data submitted:', Object.fromEntries(new FormData(this)));
            alert('Registration submitted (server-side processing will handle this)');
            // After successful registration (handled server-side), you might redirect
            // the user or update the admin list.
        });

        // In a real application, you would fetch admin data from your backend
        // (likely using JSTL tags within the JSP or via AJAX calls)
        // and dynamically populate the 'admin-table-body'.
    });
</script>
</body>
</html>