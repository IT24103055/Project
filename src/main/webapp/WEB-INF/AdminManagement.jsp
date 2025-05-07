<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Management</title>
    <link rel="stylesheet" href="AdminManagement.css">
</head>
<body>
<div class="container">
    <h1>Admin Management</h1>

    <div id="registration-form">
        <h2>Register Admin</h2>
        <form id="registerForm">
            <div class="form-group">
                <label for="reg-username">Username:</label>
                <input type="text" id="reg-username" name="reg-username" required>
            </div>
            <div class="form-group">
                <label for="reg-password">Password:</label>
                <input type="password" id="reg-password" name="reg-password" required>
            </div>
            <div class="form-group">
                <label for="reg-email">Email:</label>
                <input type="email" id="reg-email" name="reg-email" required>
            </div>
            <div class="form-group">
                <label for="reg-role">Role:</label>
                <input type="text" id="reg-role" name="reg-role">
            </div>
            <button type="button" onclick="registerAdmin()">Register</button>
            <div id="registration-message" class="message"></div>
        </form>
    </div>

    <div id="profile-section">
        <h2>Admin Profile</h2>
        <div id="profile-details">
            <p><strong>ID:</strong> <span id="profile-id"></span></p>
            <p><strong>Username:</strong> <span id="profile-username"></span></p>
            <p><strong>Email:</strong> <span id="profile-email"></span></p>
            <p><strong>Role:</strong> <span id="profile-role"></span></p>
        </div>
        <button type="button" onclick="fetchProfile()">View Profile</button>
        <div id="profile-message" class="message"></div>
    </div>

    <div id="delete-section">
        <h2>Delete Account</h2>
        <form id="deleteForm">
            <div class="form-group">
                <label for="delete-username">Username to Confirm:</label>
                <input type="text" id="delete-username" name="delete-username" required>
            </div>
            <button type="button" onclick="deleteAccount()">Delete Account</button>
            <div id="delete-message" class="message"></div>
        </form>
    </div>

    <div id="admin-list-section">
        <h2>All Admins</h2>
        <ul id="admin-list">
        </ul>
        <button type="button" onclick="fetchAllAdmins()">List All Admins</button>
        <div id="list-message" class="message"></div>
    </div>
</div>

<script>
    // Mock API endpoint (replace with your actual backend API URL)
    const API_BASE_URL = '/api/admin'; // Example

    async function registerAdmin() {
        const username = document.getElementById('reg-username').value;
        const password = document.getElementById('reg-password').value;
        const email = document.getElementById('reg-email').value;
        const role = document.getElementById('reg-role').value;
        const messageDiv = document.getElementById('registration-message');

        console.log("Registering:", { username, password, email, role });
        messageDiv.textContent = "Registration request sent (mock).";
    }

    async function fetchProfile() {
        // In a real application, you might need an admin ID or session token
        const profileDetailsDiv = document.getElementById('profile-details');
        const profileIdSpan = document.getElementById('profile-id');
        const profileUsernameSpan = document.getElementById('profile-username');
        const profileEmailSpan = document.getElementById('profile-email');
        const profileRoleSpan = document.getElementById('profile-role');
        const messageDiv = document.getElementById('profile-message');

        // Mock data
        const mockProfile = { id: "ADMIN_1", username: "testadmin", email: "admin@example.com", role: "Super Admin" };
        profileIdSpan.textContent = mockProfile.id;
        profileUsernameSpan.textContent = mockProfile.username;
        profileEmailSpan.textContent = mockProfile.email;
        profileRoleSpan.textContent = mockProfile.role;
        messageDiv.textContent = "Profile fetched (mock).";

    }

    async function deleteAccount() {
        const username = document.getElementById('delete-username').value;
        const messageDiv = document.getElementById('delete-message');

        // In a real application, you would send this to your backend API
        console.log("Deleting account for:", { username });
        messageDiv.textContent = "Deletion request sent (mock).";

    }

    async function fetchAllAdmins() {
        const adminListUl = document.getElementById('admin-list');
        const messageDiv = document.getElementById('list-message');
        adminListUl.innerHTML = ''; // Clear previous list

        // Mock data
        const mockAdmins = [
            { id: "ADMIN_1", username: "testadmin", role: "Super Admin" },
            { id: "ADMIN_2", username: "editor1", role: "Editor" }
        ];

        if (mockAdmins.length > 0) {
            mockAdmins.forEach(admin => {
                const listItem = document.createElement('li');
                listItem.textContent = `ID: ${admin.id}, Username: ${admin.username}, Role: ${admin.role}`;
                adminListUl.appendChild(listItem);
            });
            messageDiv.textContent = "Admin list updated (mock).";
        } else {
            messageDiv.textContent = "No admins found (mock).";
        }

    }
</script>
</body>
</html>