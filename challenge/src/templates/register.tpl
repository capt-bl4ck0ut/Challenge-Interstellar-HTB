<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register</title>
    <link href="https://fonts.googleapis.com/css2?family=Press+Start+2P&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Press Start 2P', cursive;
            background-color: #f4f7f6;
        }
        .register-container {
            max-width: 400px;
            margin: 5% auto;
            padding: 30px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .register-container h2 {
            margin-bottom: 30px;
            font-weight: 500;
            text-align: center;
        }
        .form-control {
            border-radius: 5px;
            animation: glitchText 1.5s infinite linear; /* Glitch effect on inputs */
        }
        .btn {
            font-family: 'Press Start 2P', cursive;
            border-radius: 5px;
            animation: glitchText 1.5s infinite linear; /* Glitch effect on button */
        }

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

<div class="register-container">
    <h2>Register</h2>

    {if isset($error)}
    <div class="alert alert-danger">
        {$error}
    </div>
    {/if}


    <form method="POST" action="register.php">
        <div class="mb-3">
            <label for="name" class="form-label">Name</label>
            <input type="text" name="name" id="name" class="form-control" value="{$name|escape}" required autofocus>
        </div>
        <div class="mb-3">
            <label for="username" class="form-label">Username</label>
            <input type="text" name="username" id="username" class="form-control" value="{$username|escape}" required>
        </div>
        <div class="mb-3">
            <label for="password" class="form-label">Password</label>
            <input type="password" name="password" id="password" class="form-control" required>
        </div>
        <button type="submit" class="btn btn-primary w-100">Register</button>
    </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
