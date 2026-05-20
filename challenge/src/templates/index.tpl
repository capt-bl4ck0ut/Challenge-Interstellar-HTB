<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Index</title>
    <link href="https://fonts.googleapis.com/css2?family=Press+Start+2P&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Press Start 2P', cursive;
            background-image: url('images/background.png');
            background-size: cover;
            background-position: center;
            background-color: #f4f7f6;
        }

        .index-container {
            max-width: 500px;
            margin: 5% auto;
            padding: 30px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        .index-container h2 {
            margin-bottom: 20px;
            font-weight: 500;
        }

        .form-control, .btn {
            border-radius: 5px;
            font-family: 'Press Start 2P', cursive;
            animation: glitchText 1.5s infinite linear;
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

        /* Form styling for name change */
        .form-container {
            max-width: 600px;
            margin: 10% auto;
            padding: 30px;
            background-color: rgba(0, 0, 0, 0.6);
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            text-align: center;
            color: white;
        }

        .form-container h2 {
            margin-bottom: 20px;
            font-weight: 500;
        }

        .form-control, .btn {
            border-radius: 5px;
            font-family: 'Press Start 2P', cursive;
        }

        .navbar {
            background-color: rgba(0, 0, 0, 0.6);
            display: flex;
            justify-content: center;
            padding: 10px 0;
            position: absolute;
            width: 100%;
            top: 0;
            left: 0;
            z-index: 1000;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.5);
        }

        .navbar a {
            color: white;
            padding: 14px 20px;
            text-align: center;
            text-decoration: none;
            display: block;
            margin: 0 5px;
            font-size: 14px;
        }

        .navbar a:hover {
            background-color: transparent;
            color: #ff69b4;
            text-shadow: 0 0 8px #ff69b4, 0 0 12px #ff69b4;
        }

        .error-message, .success-message {
            color: white;
            font-weight: bold;
            margin-top: 20px;
            padding: 10px;
            text-align: center;
            max-width: 400px;  /* Optional: limit the width of the message */
            margin-left: auto;
            margin-right: auto;
            border-radius: 5px;
}
    </style>
</head>
<body>

<!-- Navigation Bar -->
<nav class="navbar">
    <a href="/">Home</a>
    <a href="/communicate.php">Communication device</a>
    <a href="/logout.php">Logout</a>
</nav>

<!-- Existing content -->
<div class="index-container">
    <h2>Yo, {$name}</h2>
    <p>Currently you are in <span>{$planet}</span></p>
</div>

<!-- Name Change Form -->
<div class="form-container">
    <h2>Change your name</h2>
    <form action="/" method="POST">
        <div class="mb-3">
            <label for="newname" class="form-label">New Name:</label>
            <input type="text" name="new_name" class="form-control" id="newname" required>
            <input type="hidden" name="action" class="form-control" id="action" value="edit" required>
        </div>

        <button type="submit" class="btn btn-primary">Submit</button>
    </form>
</div>

{if isset($error)}
    <div class="error-message">
        {$error}
    </div>
{/if}

{if isset($message)}
    <div class="success-message">
        {$message}
    </div>
{/if}
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
