<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>About Us - MediCare</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Bootstrap & Font Awesome -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/style.css">
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>

    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(to right, #f4f6f9, #e8f0ff);
            color: #343a40;
        }


        .icon-card {
            background: linear-gradient(145deg, #ffffff, #f1f1f1);
            border-radius: 20px;
            padding: 30px;
            text-align: center;
            box-shadow: 0 6px 18px rgba(0, 0, 0, 0.15);
            transition: transform 0.4s ease, box-shadow 0.4s ease;
            margin-bottom: 30px;
        }

        .icon-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
        }

        .icon-card i {
            font-size: 2.8rem;
            margin-bottom: 15px;
        }

        .icon-card h5 {
            font-size: 1.5rem;
            font-weight: 700;
            color: #343a40;
        }

        .icon-card p, .icon-card ul {
            font-size: 1.05rem;
            line-height: 1.6;
            margin: 0;
        }

        .icon-card ul {
            padding-left: 0;
            list-style: none;
        }

        .icon-card ul li {
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 10px;
        }

        .icon-card ul li i {
            color: #28a745;
            margin-right: 10px;
        }

        .vision {
            background: linear-gradient(135deg, #e0f7fa, #b2ebf2);
        }

        .mission {
            background: linear-gradient(135deg, #ede7f6, #d1c4e9);
        }

        .focus {
            background: linear-gradient(135deg, #fbe9e7, #ffccbc);
        }

        .vision i { color: #17a2b8; }
        .mission i { color: #6f42c1; }
        .focus i { color: #dc3545; }

        footer {

            padding: 20px 0;
            color: #fff;
            text-align: center;
            margin-top: 40px;
        }


    </style>
</head>
<body>
<jsp:include page="includes/topbar.jsp" />
<jsp:include page="includes/navbar.jsp" />


<!-- Vision, Mission, Focus -->
<div class="container mt-5">
    <div class="row text-center">

        <!-- Vision -->
        <div class="col-md-4">
            <div class="icon-card vision">
                <i class="fas fa-lightbulb"></i>
                <h5>Our Vision</h5>
                <p>To revolutionize healthcare by offering secure, smart, and accessible technology solutions to everyone.</p>
            </div>
        </div>

        <!-- Mission -->
        <div class="col-md-4">
            <div class="icon-card mission">
                <i class="fas fa-bullseye"></i>
                <h5>Our Mission</h5>
                <p>To deliver intuitive and powerful tools that improve healthcare workflows, trust, and patient engagement.</p>
            </div>
        </div>

        <!-- Focus -->
        <div class="col-md-4">
            <div class="icon-card focus">
                <i class="fas fa-hand-holding-heart"></i>
                <h5>Our Focus</h5>
                <ul>
                    <li><i class="fas fa-check-circle"></i> Secure Data Management</li>
                    <li><i class="fas fa-check-circle"></i> User-Friendly Experience</li>
                    <li><i class="fas fa-check-circle"></i> Mobile First Design</li>
                    <li><i class="fas fa-check-circle"></i> 24/7 Accessibility</li>
                </ul>
            </div>
        </div>

    </div>

    <div class="text-center footer-quote">
        MediCare – Bridging the gap between care and technology.
    </div>
</div>

<jsp:include page="includes/footer.jsp" />

<!-- Bootstrap Scripts -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
