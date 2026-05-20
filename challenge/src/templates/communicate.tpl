<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Communicate</title>
    <link href="https://fonts.googleapis.com/css2?family=Press+Start+2P&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Press Start 2P', cursive;
            background-image: url('/images/background.png');
            background-size: cover;
            background-position: center;
            background-color: #f4f7f6;
        }
    
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

        .error-message {
            color: red;
            font-weight: bold;
            margin-top: 20px;
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


<div class="form-container">
    <h2>Send request to your mother land!</h2>

    {if isset($error)}
        <div class="error-message">
            {$error}
        </div>
    {/if}

    <form id="curlForm" action="" method="POST">
        <div class="mb-3">
            <label for="url" class="form-label">URL:</label>
            <input type="text" name="url" class="form-control" id="url" required>
        </div>

        <div class="mb-3">
            <label for="key" class="form-label">Key:</label>
            <input type="text" name="key" class="form-control" id="key" placeholder="Enter key data" required>
        </div>

        <div class="mb-3">
            <label for="value" class="form-label">Value:</label>
            <input type="text" name="value" class="form-control" id="value" placeholder="Enter value data" required>
        </div>

        <button type="submit" class="btn btn-primary">Submit</button>
    </form>

    {if isset($response)}
        <div class="mt-3">
            <h4>Response:</h4>
            <pre>{$response}</pre>
        </div>
    {/if}
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="/js/sendForm.js"></script>
</body>
</html>
