<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link href="https://fonts.googleapis.com/css2?family=Press+Start+2P&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Press Start 2P', cursive;
            background-color: #f4f7f6;
        }
        .login-container {
            max-width: 400px;
            margin: 5% auto;
            padding: 30px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .login-container h2 {
            margin-bottom: 30px;
            font-weight: 500;
            text-align: center;
        }
        .form-control {
            border-radius: 5px;
            font-family: 'Press Start 2P', cursive;
            animation: glitchText 1.5s infinite linear; /* Glitch effect on inputs */
        }
        .btn {
            font-family: 'Press Start 2P', cursive;
            border-radius: 5px;
            animation: glitchText 1.5s infinite linear;
        }

        /* Glitch effect */
        @keyframes glitchText {
            0% {
                text-shadow: 2px 0 red, -2px 0 blue, 0 2px yellow, 0 -2px green;
            }
            20% {
                text-shadow: -2px 0 red, 2px 0 blue, 0 2px yellow, 0 -2px green;
            }
            40% {
                text-shadow: 2px 0 red, -2px 0 blue, 0 2px yellow, 0 -2px green;
            }
            60% {
                text-shadow: -2px 0 red, 2px 0 blue, 0 2px yellow, 0 -2px green;
            }
            80% {
                text-shadow: 2px 0 red, -2px 0 blue, 0 2px yellow, 0 -2px green;
            }
            100% {
                text-shadow: -2px 0 red, 2px 0 blue, 0 2px yellow, 0 -2px green;
            }
        }

        .form-control:focus, .btn:focus {
            outline: none;
            box-shadow: none;
        }

    </style>
</head>
<body style="background-image: url('/images/background.png'); background-size: cover; background-position: center;">

<div class="login-container">
    <h2>Login</h2>

    {if $error}
    <div class="alert alert-danger">
        {$error}
    </div>
    {/if}

    {if $message}
        <div class="alert alert-success">
            {$message}
        </div>
    {/if}

    <!-- Login Form -->
    <form method="POST" action="login.php">
        <div class="mb-3">
            <label for="username" class="form-label">Username</label>
            <input type="text" name="username" id="username" class="form-control" required autofocus>
        </div>
        <div class="mb-3">
            <label for="password" class="form-label">Password</label>
            <input type="password" name="password" id="password" class="form-control" required>
        </div>
        <div class="mb-3 form-check">
            <input type="checkbox" name="remember" id="remember" class="form-check-input">
            <label class="form-check-label" for="remember">Remember Me</label>
        </div>
        <button type="submit" class="btn btn-primary w-100">Login</button>
    </form>

    <!-- Create account link -->
    <div class="mt-3 text-center">
        <a href="register.php" class="btn btn-secondary w-100">Create Account</a>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
